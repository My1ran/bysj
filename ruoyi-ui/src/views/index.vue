<template>
  <div class="app-container polyp-dashboard">
    <el-row :gutter="16" class="card-row">
      <el-col v-for="card in overviewCards" :key="card.key" :xs="24" :sm="12" :lg="8" :xl="4">
        <el-card shadow="hover" class="metric-card">
          <div class="metric-label">{{ card.label }}</div>
          <div class="metric-value">{{ card.value }}</div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="16" class="chart-row">
      <el-col :xs="24" :lg="16">
        <el-card shadow="never">
          <div slot="header">
            <span>最近 7 天检查任务趋势</span>
          </div>
          <div ref="trendChart" class="chart-box" />
        </el-card>
      </el-col>
      <el-col :xs="24" :lg="8">
        <el-card shadow="never">
          <div slot="header">
            <span>图片/视频任务占比</span>
          </div>
          <div ref="distributionChart" class="chart-box" />
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="16" class="status-row">
      <el-col :span="24">
        <el-card shadow="never">
          <div slot="header">
            <span>任务状态分布</span>
          </div>
          <div class="status-wrap">
            <div v-for="item in statusItems" :key="item.status" class="status-item">
              <div class="status-header">
                <span>{{ statusText(item.status) }}</span>
                <span>{{ item.count }}</span>
              </div>
              <el-progress :percentage="statusPercent(item.count)" :show-text="false" :stroke-width="10" />
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="16" class="table-row">
      <el-col :span="24">
        <el-card shadow="never">
          <div slot="header" class="table-header">
            <span>最近任务（10 条）</span>
            <el-button type="primary" size="mini" @click="$router.push('/system/polyp')">进入息肉检测中心</el-button>
          </div>
          <el-table v-loading="loading" :data="recentTasks" border size="small" empty-text="暂无任务数据">
            <el-table-column label="任务ID" prop="taskId" width="90" align="center" />
            <el-table-column label="任务编号" prop="taskNo" min-width="220" />
            <el-table-column label="媒体类型" width="100">
              <template slot-scope="scope">
                <el-tag size="mini">{{ scope.row.mediaType === 'video' ? '视频' : '图片' }}</el-tag>
              </template>
            </el-table-column>
            <el-table-column label="状态" width="100">
              <template slot-scope="scope">
                <el-tag size="mini" :type="statusTagType(scope.row.status)">{{ statusText(scope.row.status) }}</el-tag>
              </template>
            </el-table-column>
            <el-table-column label="推理耗时(ms)" prop="inferenceMs" width="130" />
            <el-table-column label="原始文件名" prop="originName" min-width="200" show-overflow-tooltip />
            <el-table-column label="创建时间" min-width="170">
              <template slot-scope="scope">
                {{ formatDateTime(scope.row.createTime) }}
              </template>
            </el-table-column>
          </el-table>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import echarts from 'echarts'
import { parseTime } from '@/utils/ruoyi'
import {
  getPolypDashboardOverview,
  getPolypDashboardTrend,
  getPolypDashboardDistribution,
  getPolypDashboardRecent
} from '@/api/system/polypDashboard'

export default {
  name: 'Index',
  data() {
    return {
      loading: false,
      overview: {
        totalTaskCount: 0,
        todayTaskCount: 0,
        successTaskCount: 0,
        failedTaskCount: 0,
        avgInferenceMs: 0,
        totalPolypCount: 0
      },
      trendData: [],
      mediaItems: [],
      statusItems: [],
      recentTasks: [],
      trendChartIns: null,
      distributionChartIns: null
    }
  },
  computed: {
    overviewCards() {
      return [
        { key: 'totalTaskCount', label: '总检查任务数', value: this.overview.totalTaskCount },
        { key: 'todayTaskCount', label: '今日检查任务数', value: this.overview.todayTaskCount },
        { key: 'successTaskCount', label: '成功任务数', value: this.overview.successTaskCount },
        { key: 'failedTaskCount', label: '失败任务数', value: this.overview.failedTaskCount },
        { key: 'avgInferenceMs', label: '平均推理耗时(ms)', value: Number(this.overview.avgInferenceMs || 0).toFixed(2) },
        { key: 'totalPolypCount', label: '累计识别息肉数量', value: this.overview.totalPolypCount }
      ]
    },
    statusTotal() {
      return this.statusItems.reduce((sum, item) => sum + Number(item.count || 0), 0)
    }
  },
  mounted() {
    this.loadDashboard()
    window.addEventListener('resize', this.handleResize)
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.handleResize)
    if (this.trendChartIns) {
      this.trendChartIns.dispose()
      this.trendChartIns = null
    }
    if (this.distributionChartIns) {
      this.distributionChartIns.dispose()
      this.distributionChartIns = null
    }
  },
  methods: {
    async loadDashboard() {
      this.loading = true
      try {
        const [overviewRes, trendRes, distributionRes, recentRes] = await Promise.all([
          getPolypDashboardOverview(),
          getPolypDashboardTrend(),
          getPolypDashboardDistribution(),
          getPolypDashboardRecent(10)
        ])
        this.overview = overviewRes.data || this.overview
        this.trendData = trendRes.data || []
        const distribution = distributionRes.data || {}
        this.mediaItems = distribution.media || []
        this.statusItems = distribution.status || []
        this.recentTasks = recentRes.data || []
        this.$nextTick(() => {
          this.renderTrendChart()
          this.renderDistributionChart()
        })
      } catch (e) {
        this.$modal.msgError('加载监测总览数据失败')
      } finally {
        this.loading = false
      }
    },
    renderTrendChart() {
      if (!this.$refs.trendChart) return
      if (!this.trendChartIns) {
        this.trendChartIns = echarts.init(this.$refs.trendChart)
      }
      const xData = this.trendData.map(item => item.date)
      const yData = this.trendData.map(item => item.taskCount || 0)
      this.trendChartIns.setOption({
        tooltip: { trigger: 'axis' },
        grid: { left: 36, right: 20, top: 28, bottom: 24 },
        xAxis: {
          type: 'category',
          boundaryGap: false,
          data: xData
        },
        yAxis: {
          type: 'value',
          minInterval: 1
        },
        series: [
          {
            name: '检查任务数',
            type: 'line',
            smooth: true,
            data: yData,
            areaStyle: { opacity: 0.15 },
            lineStyle: { width: 2 },
            itemStyle: { color: '#409EFF' }
          }
        ]
      })
    },
    renderDistributionChart() {
      if (!this.$refs.distributionChart) return
      if (!this.distributionChartIns) {
        this.distributionChartIns = echarts.init(this.$refs.distributionChart)
      }
      const data = (this.mediaItems || []).map(item => ({
        name: item.type === 'video' ? '视频' : '图片',
        value: Number(item.count || 0)
      }))
      this.distributionChartIns.setOption({
        tooltip: { trigger: 'item' },
        legend: { bottom: 0, left: 'center' },
        series: [
          {
            type: 'pie',
            radius: ['35%', '65%'],
            center: ['50%', '45%'],
            avoidLabelOverlap: false,
            label: {
              formatter: '{b}\n{d}%'
            },
            data
          }
        ]
      })
    },
    handleResize() {
      if (this.trendChartIns) this.trendChartIns.resize()
      if (this.distributionChartIns) this.distributionChartIns.resize()
    },
    statusText(status) {
      if (status === 'SUCCESS') return '成功'
      if (status === 'FAILED') return '失败'
      if (status === 'RUNNING') return '执行中'
      if (status === 'PENDING') return '待执行'
      return status || '-'
    },
    statusTagType(status) {
      if (status === 'SUCCESS') return 'success'
      if (status === 'FAILED') return 'danger'
      if (status === 'RUNNING') return 'warning'
      return 'info'
    },
    statusPercent(count) {
      const total = this.statusTotal
      if (!total) return 0
      return Number(((Number(count || 0) / total) * 100).toFixed(2))
    },
    formatDateTime(value) {
      if (!value) return '-'
      return parseTime(value, '{y}-{m}-{d} {h}:{i}:{s}')
    }
  }
}
</script>

<style scoped lang="scss">
.polyp-dashboard {
  .card-row {
    margin-bottom: 16px;
  }

  .metric-card {
    margin-bottom: 12px;
  }

  .metric-label {
    color: #606266;
    font-size: 13px;
    margin-bottom: 8px;
  }

  .metric-value {
    color: #303133;
    font-size: 24px;
    font-weight: 700;
    line-height: 1.2;
  }

  .chart-row {
    margin-bottom: 16px;
  }

  .chart-box {
    width: 100%;
    height: 300px;
  }

  .status-row {
    margin-bottom: 16px;
  }

  .status-wrap {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
    gap: 12px;
  }

  .status-item {
    border: 1px solid #ebeef5;
    border-radius: 6px;
    padding: 10px 12px;
    background: #fff;
  }

  .status-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    color: #303133;
    margin-bottom: 8px;
    font-size: 13px;
  }

  .table-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
}
</style>
