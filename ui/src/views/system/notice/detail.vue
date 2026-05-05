<template>
  <div class="app-container notice-detail">
    <div class="detail-toolbar">
      <el-page-header content="公告详情" @back="handleClose" />
      <el-button icon="el-icon-back" size="mini" @click="handleClose">返回列表</el-button>
    </div>

    <el-card v-loading="loading" shadow="never" class="detail-panel">
      <div class="notice-heading">
        <div>
          <div class="notice-id">公告编号：{{ notice.noticeId || '-' }}</div>
          <h2>{{ notice.noticeTitle || '未命名公告' }}</h2>
        </div>
        <div class="notice-tags">
          <dict-tag :options="dict.type.sys_notice_type" :value="notice.noticeType" />
          <dict-tag :options="dict.type.sys_notice_status" :value="notice.status" />
        </div>
      </div>

      <el-descriptions :column="3" border size="small" class="notice-meta">
        <el-descriptions-item label="公告类型">
          <dict-tag :options="dict.type.sys_notice_type" :value="notice.noticeType" />
        </el-descriptions-item>
        <el-descriptions-item label="状态">
          <dict-tag :options="dict.type.sys_notice_status" :value="notice.status" />
        </el-descriptions-item>
        <el-descriptions-item label="创建者">{{ notice.createBy || '-' }}</el-descriptions-item>
        <el-descriptions-item label="创建时间">{{ formatTime(notice.createTime) }}</el-descriptions-item>
        <el-descriptions-item label="更新者">{{ notice.updateBy || '-' }}</el-descriptions-item>
        <el-descriptions-item label="更新时间">{{ formatTime(notice.updateTime) }}</el-descriptions-item>
      </el-descriptions>

      <el-divider content-position="left">正文</el-divider>
      <div class="notice-content ql-editor" v-html="notice.noticeContent || emptyContent" />
    </el-card>
  </div>
</template>

<script>
import 'quill/dist/quill.core.css'
import { getNotice } from '@/api/system/notice'

export default {
  name: 'NoticeDetail',
  dicts: ['sys_notice_status', 'sys_notice_type'],
  data() {
    return {
      loading: false,
      notice: {},
      emptyContent: '<p>暂无正文</p>'
    }
  },
  computed: {
    noticeId() {
      return this.$route.params.noticeId
    }
  },
  created() {
    this.getDetail()
  },
  methods: {
    getDetail() {
      if (!this.noticeId) {
        this.notice = {}
        return
      }
      this.loading = true
      getNotice(this.noticeId).then(response => {
        this.notice = response.data || {}
      }).catch(() => {
        this.notice = {}
      }).finally(() => {
        this.loading = false
      })
    },
    formatTime(value) {
      return value ? this.parseTime(value) : '-'
    },
    handleClose() {
      this.$tab.closeOpenPage({ path: '/system/notice' })
    }
  }
}
</script>

<style scoped>
.notice-detail {
  background: #f5f7fb;
  min-height: calc(100vh - 84px);
}

.detail-toolbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 12px;
}

.detail-panel {
  border-radius: 4px;
}

.notice-heading {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 16px;
}

.notice-heading h2 {
  margin: 6px 0 0;
  font-size: 22px;
  font-weight: 600;
  line-height: 1.4;
  color: #1f2d3d;
}

.notice-id {
  font-size: 13px;
  color: #909399;
}

.notice-tags {
  display: flex;
  flex-wrap: wrap;
  justify-content: flex-end;
  gap: 8px;
  min-width: 160px;
}

.notice-meta {
  margin-top: 18px;
}

.notice-content {
  min-height: 220px;
  padding: 0;
  color: #303133;
  font-size: 14px;
  line-height: 1.8;
  word-break: break-word;
}

.notice-content img,
.notice-content video {
  max-width: 100%;
}

@media (max-width: 768px) {
  .detail-toolbar,
  .notice-heading {
    align-items: stretch;
    flex-direction: column;
  }

  .notice-tags {
    justify-content: flex-start;
  }
}
</style>
