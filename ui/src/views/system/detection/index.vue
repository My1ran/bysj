
<template>
  <div class="app-container">
    <el-card shadow="never">
      <div slot="header"><span>息肉检测中心</span></div>
      <el-row :gutter="16">
        <el-col :span="12">
          <div class="label">当前模型</div>
          <div v-if="currentModel">
            <el-tag type="success">{{ currentModel.modelName }}（ID: {{ currentModel.modelId }}）</el-tag>
            <span class="meta">阈值：{{ currentModel.confThreshold }}</span>
          </div>
          <el-tag v-else type="info">暂无启用模型</el-tag>
        </el-col>
        <el-col :span="12" class="align-right">
          <el-button v-hasPermi="['system:polyp:model:query']" type="primary" size="mini" icon="el-icon-refresh" @click="loadCurrentModel">刷新模型</el-button>
        </el-col>
      </el-row>
      <el-upload
        :key="uploadInputKey"
        ref="detectUpload"
        class="upload-block"
        action="#"
        drag
        :auto-upload="false"
        :show-file-list="false"
        :accept="acceptTypes"
        :before-upload="alwaysManualUpload"
        :on-change="handleFileChange"
      >
        <i class="el-icon-upload" />
        <div class="el-upload__text">将图片或视频拖到此处，或 <em>点击选择文件</em></div>
        <div slot="tip" class="el-upload__tip">支持：jpg/jpeg/png/bmp/mp4（可选：avi/mov/mkv）</div>
      </el-upload>
      <div v-if="selectedFileName" class="upload-selected-panel">
        <i class="el-icon-document upload-selected-icon" />
        <span class="upload-selected-name">{{ selectedFileName }}</span>
        <el-button type="text" class="upload-selected-remove" @click="handleRemoveFile">移除</el-button>
      </div>
      <div class="actions">
        <el-button v-hasPermi="['system:polyp:file:upload']" type="primary" icon="el-icon-video-play" :loading="detecting" @click="submitDetect">提交检查</el-button>
      </div>
    </el-card>

    <el-card v-if="currentDetail && currentDetail.task" shadow="never" class="block-gap">
      <div slot="header"><span>检查任务详情（ID: {{ currentDetail.task.taskId }}）</span></div>
      <el-descriptions :column="3" border>
        <el-descriptions-item label="检查任务编号">{{ currentDetail.task.taskNo }}</el-descriptions-item>
        <el-descriptions-item label="状态"><el-tag :type="statusTagType(currentDetail.task.status)">{{ statusText(currentDetail.task.status) }}</el-tag></el-descriptions-item>
        <el-descriptions-item label="推理耗时(ms)">{{ currentDetail.task.inferenceMs || '-' }}</el-descriptions-item>
        <el-descriptions-item label="媒体类型">{{ currentFileType === 'video' ? '视频' : '图片' }}</el-descriptions-item>
        <el-descriptions-item label="检测框数量">{{ Number(currentDetail.boxCount || 0) }}</el-descriptions-item>
        <el-descriptions-item label="最大置信度">{{ Number(currentDetail.maxConfidence || 0).toFixed(4) }}</el-descriptions-item>
        <el-descriptions-item label="总帧数">{{ Number(currentDetail.frameCount || 0) }}</el-descriptions-item>
        <el-descriptions-item label="命中帧数">{{ Number(currentDetail.detectedFrameCount || 0) }}</el-descriptions-item>
        <el-descriptions-item label="结果帧JSON">
          <span>{{ currentDetail.resultFramesUrl || '-' }}</span>
        </el-descriptions-item>
      </el-descriptions>

      <div v-if="currentFileType==='image' && currentImageUrl" class="block-gap">
        <div class="label">检查结果图</div>
        <img :src="currentImageUrl" class="preview" alt="image">
      </div>
      <div v-if="currentFileType==='video' && currentVideoUrl" class="block-gap">
        <div class="label">检查结果视频</div>
        <video ref="videoEl" :key="currentVideoKey" :src="currentVideoUrl" class="preview" preload="metadata" controls />
        <div class="video-toolbar">
          <span class="rate-label">播放速度：</span>
          <el-radio-group v-model="currentPlaybackRate" size="mini" @change="changePlaybackRate">
            <el-radio-button v-for="rate in playbackRates" :key="rate" :label="rate">{{ rate }}x</el-radio-button>
          </el-radio-group>
        </div>
      </div>

      <div class="block-gap">
        <div class="label">检查结果明细</div>
        <el-table v-if="currentFileType==='video'" v-loading="frameRowsLoading" :data="pagedVideoHitRows" size="small" border empty-text="暂无命中帧数据" @row-click="jumpToVideoTimestamp">
          <el-table-column label="#" type="index" width="60" align="center" />
          <el-table-column label="帧号" prop="frameIndex" width="90" />
          <el-table-column label="时间(秒)" prop="timestampSec" width="120"><template slot-scope="scope">{{ Number(scope.row.timestampSec || 0).toFixed(3) }}</template></el-table-column>
          <el-table-column label="框数量" prop="boxCount" width="90" />
          <el-table-column label="最大置信度" prop="maxConfidence" width="120"><template slot-scope="scope">{{ Number(scope.row.maxConfidence || 0).toFixed(4) }}</template></el-table-column>
          <el-table-column label="类别" prop="className" width="100" />
          <el-table-column label="坐标(x1,y1,x2,y2)" prop="position" min-width="220" />
        </el-table>
        <el-pagination
          v-if="currentFileType==='video' && videoHitRows.length > 0"
          class="video-box-pagination"
          background
          layout="total, sizes, prev, pager, next"
          :total="videoHitRows.length"
          :current-page="videoListPageNum"
          :page-size="videoListPageSize"
          :page-sizes="videoListPageSizes"
          @current-change="handleVideoPageChange"
          @size-change="handleVideoSizeChange"
        />
        <el-table v-else :data="imageBoxRows" size="small" border empty-text="暂无检测框数据">
          <el-table-column label="#" type="index" width="60" align="center" />
          <el-table-column label="类别" min-width="120"><template slot-scope="scope">{{ toClassZh(scope.row.classification) }}</template></el-table-column>
          <el-table-column label="置信度" min-width="100">
            <template slot-scope="scope">
              {{ scope.row.confidence === null || scope.row.confidence === undefined ? '-' : Number(scope.row.confidence).toFixed(3) }}
            </template>
          </el-table-column>
          <el-table-column label="坐标串" prop="position" min-width="220" />
        </el-table>
      </div>
    </el-card>

    <el-card v-else shadow="never" class="block-gap"><el-empty description="暂无任务详情，请先提交检查" /></el-card>
    <el-card shadow="never" class="block-gap">
      <div slot="header"><span>检查任务管理</span></div>
      <el-form ref="queryForm" :inline="true" size="small" :model="queryParams">
        <el-form-item label="检查任务编号"><el-input v-model="queryParams.taskNo" placeholder="请输入检查任务编号" clearable @keyup.enter.native="handleQuery" /></el-form-item>
        <el-form-item label="状态">
          <el-select v-model="queryParams.status" placeholder="全部状态" clearable>
            <el-option label="待处理" value="PENDING" />
            <el-option label="处理中" value="RUNNING" />
            <el-option label="成功" value="SUCCESS" />
            <el-option label="失败" value="FAILED" />
          </el-select>
        </el-form-item>
        <el-form-item label="媒体类型">
          <el-select v-model="queryParams.mediaType" placeholder="全部类型" clearable>
            <el-option label="图片" value="image" />
            <el-option label="视频" value="video" />
          </el-select>
        </el-form-item>
        <el-form-item label="创建时间">
          <el-date-picker
            v-model="dateRange"
            type="daterange"
            value-format="yyyy-MM-dd"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            clearable
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" @click="handleQuery">查询</el-button>
          <el-button icon="el-icon-refresh" @click="resetQuery">重置</el-button>
          <el-button v-hasPermi="['system:polyp:task:export']" type="warning" icon="el-icon-download" @click="handleExport">导出</el-button>
        </el-form-item>
      </el-form>
      <el-table v-loading="listLoading" :data="taskList" border empty-text="暂无检查任务">
        <el-table-column label="任务ID" prop="taskId" width="90" />
        <el-table-column label="检查任务编号" prop="taskNo" min-width="220" />
        <el-table-column label="媒体类型" min-width="100">
          <template slot-scope="scope">
            <el-tag size="mini">{{ scope.row.mediaType === 'video' ? '视频' : '图片' }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="状态" min-width="100"><template slot-scope="scope"><el-tag :type="statusTagType(scope.row.status)">{{ statusText(scope.row.status) }}</el-tag></template></el-table-column>
        <el-table-column label="推理耗时(ms)" prop="inferenceMs" min-width="120" />
        <el-table-column label="创建时间" prop="createTime" min-width="180" />
        <el-table-column label="操作" width="180" align="center">
          <template slot-scope="scope">
            <el-button size="mini" type="text" @click="showDetail(scope.row.taskId)">查看</el-button>
            <el-button v-hasPermi="['system:polyp:task:remove']" size="mini" type="text" @click="handleDelete(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getTaskList" />
    </el-card>
  </div>
</template>

<script>
import { uploadPolypFile, createPolypTask, getPolypTaskDetail, getPolypTaskDetailForView, getCurrentPolypModel, listPolypTask, deletePolypTask } from '@/api/system/polypTask'

export default {
  name: 'Detection',
  data() {
    return {
      detecting: false,
      uploadInputKey: 0,
      selectedFile: null,
      selectedFileName: '',
      currentModel: null,
      currentDetail: null,
      currentBoxes: [],
      imageBoxRows: [],
      currentImageUrl: '',
      currentVideoUrl: '',
      currentVideoKey: 0,
      currentFileType: '',
      resultFramesUrl: '',
      videoHitRows: [],
      videoListPageNum: 1,
      videoListPageSize: 10,
      videoListPageSizes: [10, 20, 50],
      frameRowsLoading: false,
      videoFps: 0,
      pollingTimer: null,
      pollingTaskId: null,
      pollingRequesting: false,
      framesLoadErrorNotified: false,
      playbackRates: [0.5, 1, 1.5, 2],
      currentPlaybackRate: 1,
      taskList: [],
      total: 0,
      listLoading: false,
      dateRange: [],
      acceptTypes: '.jpg,.jpeg,.png,.bmp,.mp4,.avi,.mov,.mkv',
      imageExts: ['jpg', 'jpeg', 'png', 'bmp'],
      videoExts: ['mp4', 'avi', 'mov', 'mkv'],
      maxImageBytes: 10 * 1024 * 1024,
      maxVideoBytes: 500 * 1024 * 1024,
      queryParams: { pageNum: 1, pageSize: 10, taskNo: undefined, status: undefined, mediaType: undefined }
    }
  },
  computed: {
    pagedVideoHitRows() {
      const start = (this.videoListPageNum - 1) * this.videoListPageSize
      const end = start + this.videoListPageSize
      return this.videoHitRows.slice(start, end)
    }
  },
  created() {
    this.loadCurrentModel()
    this.getTaskList()
  },
  beforeDestroy() {
    this.stopTaskPolling()
  },
  methods: {
    statusTagType(status) {
      if (status === 'SUCCESS') return 'success'
      if (status === 'FAILED') return 'danger'
      if (status === 'RUNNING') return 'warning'
      return 'info'
    },
    statusText(status) {
      if (status === 'SUCCESS') return '成功'
      if (status === 'FAILED') return '失败'
      if (status === 'RUNNING') return '处理中'
      if (status === 'PENDING') return '待处理'
      return status || '-'
    },
    alwaysManualUpload() { return false },
    resetUploadSelection() {
      this.selectedFile = null
      this.selectedFileName = ''
      if (this.$refs.detectUpload) {
        this.$refs.detectUpload.clearFiles()
      }
      this.uploadInputKey += 1
    },
    handleFileChange(uploadFile) {
      const rawFile = uploadFile && (uploadFile.raw || uploadFile)
      if (!rawFile) {
        this.resetUploadSelection()
        return
      }
      const validateResult = this.validateSelectedFile(rawFile)
      if (!validateResult.valid) {
        this.$modal.msgError(validateResult.message)
        this.resetUploadSelection()
        return
      }
      this.selectedFile = rawFile
      this.selectedFileName = rawFile.name || ''
    },
    validateSelectedFile(file) {
      const ext = (file.name.split('.').pop() || '').toLowerCase()
      if (this.imageExts.includes(ext)) return file.size <= this.maxImageBytes ? { valid: true } : { valid: false, message: '图片大小不能超过 10MB' }
      if (this.videoExts.includes(ext)) return file.size <= this.maxVideoBytes ? { valid: true } : { valid: false, message: '视频大小不能超过 500MB' }
      return { valid: false, message: '仅支持 jpg/jpeg/png/bmp/mp4（可选 avi/mov/mkv）格式' }
    },
    handleRemoveFile() {
      this.resetUploadSelection()
    },
    async loadCurrentModel() {
      try { this.currentModel = (await getCurrentPolypModel()).data || null } catch (e) { this.currentModel = null }
    },
    async submitDetect() {
      const selectedFile = this.selectedFile
      const selectedFileName = this.selectedFileName
      if (!selectedFile) {
        this.$modal.msgError('请先选择图片或视频文件')
        return
      }
      this.stopTaskPolling()
      this.detecting = true
      this.$modal.loading('正在提交任务，请稍候...')
      try {
        const uploadRes = await uploadPolypFile(selectedFile)
        const sourceFileId = uploadRes && uploadRes.data ? uploadRes.data.fileId : null
        if (!sourceFileId) throw new Error(`文件${selectedFileName || ''}上传成功，但未返回 fileId`)

        const req = { sourceFileId }
        if (this.currentModel && this.currentModel.modelId) {
          req.modelId = this.currentModel.modelId
          req.confThreshold = this.currentModel.confThreshold
        }
        const taskRes = await createPolypTask(req)
        const taskId = taskRes && taskRes.data ? taskRes.data.taskId : null
        if (!taskId) throw new Error('任务创建成功，但未返回 taskId')

        await this.showDetail(taskId)
        await this.getTaskList()
        this.$modal.msgSuccess(`检查任务已提交，任务ID=${taskId}，正在后台识别`)
        this.startTaskPolling(taskId)
      } catch (error) {
        const msg = (error && error.response && error.response.data && error.response.data.msg) || error.message || '检测失败'
        this.$modal.msgError(msg)
      } finally {
        this.resetUploadSelection()
        this.$modal.closeLoading()
        this.detecting = false
      }
    },
    startTaskPolling(taskId) {
      this.stopTaskPolling()
      if (!taskId) return
      this.pollingTaskId = taskId
      this.pollingTimer = window.setInterval(() => this.pollTaskStatus(), 2000)
      this.pollTaskStatus()
    },
    stopTaskPolling() {
      if (this.pollingTimer) {
        window.clearInterval(this.pollingTimer)
        this.pollingTimer = null
      }
      this.pollingTaskId = null
      this.pollingRequesting = false
    },
    async pollTaskStatus() {
      if (!this.pollingTaskId || this.pollingRequesting) return
      this.pollingRequesting = true
      try {
        const taskId = this.pollingTaskId
        const detail = (await getPolypTaskDetail(taskId)).data || {}
        const task = detail.task || {}
        if (this.currentDetail && this.currentDetail.task && this.currentDetail.task.taskId === taskId) {
          this.currentDetail.task.status = task.status
          this.currentDetail.task.errorMsg = task.errorMsg
          this.currentDetail.task.inferenceMs = task.inferenceMs
        }
        if (task.status === 'SUCCESS') {
          this.stopTaskPolling()
          await this.applyDetailData(detail)
          await this.getTaskList()
          this.$modal.msgSuccess(`检查任务ID=${taskId} 识别已完成`)
        } else if (task.status === 'FAILED') {
          this.stopTaskPolling()
          await this.applyDetailData(detail)
          await this.getTaskList()
          this.$modal.msgError(`检查任务ID=${taskId} 识别失败：${task.errorMsg || '后台推理失败'}`)
        }
      } catch (e) {
        // ignore transient polling error
      } finally {
        this.pollingRequesting = false
      }
    },
    async showDetail(taskId) {
      await this.applyDetailData((await getPolypTaskDetailForView(taskId)).data || {})
    },
    async applyDetailData(data) {
      const normalizedDetail = {
        ...data,
        frameCount: this.toNumber(data.frameCount, 0),
        detectedFrameCount: this.toNumber(data.detectedFrameCount, 0),
        boxCount: this.toNumber(data.boxCount, 0),
        maxConfidence: this.toNumber(data.maxConfidence, 0),
        resultImageUrl: this.normalizeFileUrl(data.resultImageUrl || ''),
        resultVideoUrl: this.normalizeFileUrl(data.resultVideoUrl || ''),
        resultFramesUrl: this.normalizeFileUrl(data.resultFramesUrl || '')
      }
      this.currentDetail = normalizedDetail
      this.currentBoxes = data.boxes || []
      this.imageBoxRows = []
      const sourceFile = data.sourceFile || {}
      this.currentFileType = data.mediaType || this.getFileTypeByName(sourceFile.originName || sourceFile.fileUrl || '')
      const sourceFileUrl = this.normalizeFileUrl(data.sourceFileUrl || sourceFile.fileUrl || '')
      const resultImageUrl = normalizedDetail.resultImageUrl
      const resultVideoUrl = normalizedDetail.resultVideoUrl
      this.resultFramesUrl = normalizedDetail.resultFramesUrl
      this.framesLoadErrorNotified = false
      this.currentImageUrl = this.currentFileType === 'image' ? (resultImageUrl || sourceFileUrl) : ''
      this.currentVideoUrl = this.currentFileType === 'video' ? (resultVideoUrl || sourceFileUrl) : ''
      this.currentVideoKey += this.currentFileType === 'video' ? 1 : 0
      this.videoHitRows = []
      this.videoListPageNum = 1
      if (this.currentFileType === 'video') {
        await this.loadVideoHitRows(data)
      } else if (this.currentFileType === 'image') {
        this.imageBoxRows = this.buildImageBoxRows(data)
      }
    },
    async loadVideoHitRows(detailData) {
      this.frameRowsLoading = true
      try {
        const frames = await this.fetchFrames(detailData)
        this.videoHitRows = this.flattenHitRows(frames)
        this.videoListPageNum = 1
      } finally {
        this.frameRowsLoading = false
      }
    },
    handleVideoPageChange(pageNum) {
      this.videoListPageNum = pageNum
    },
    handleVideoSizeChange(pageSize) {
      this.videoListPageSize = pageSize
      this.videoListPageNum = 1
    },
    async fetchFrames(detailData) {
      const summary = detailData.inferenceSummary || {}
      if (this.resultFramesUrl) {
        try {
          const fetchUrl = this.ensureHttpsForSeetaCloud(this.resultFramesUrl)
          const resp = await window.fetch(fetchUrl, {
            method: 'GET',
            mode: 'cors',
            credentials: 'omit',
            cache: 'no-store',
            headers: {
              Accept: 'application/json,text/plain,*/*'
            }
          })
          if (resp.ok) {
            const textPayload = await resp.text()
            const payload = JSON.parse(textPayload.replace(/^\uFEFF/, ''))
            this.videoFps = this.toNumber(payload.fps, detailData.fps, summary.fps, 0)
            return this.normalizeFrames(payload.frames || [])
          }
        } catch (e) {
          if (!this.framesLoadErrorNotified) {
            const err = e && e.message ? e.message : '未知错误'
            this.$modal.msgError(`读取命中帧失败：${err}`)
            this.framesLoadErrorNotified = true
          }
        }
      }
      const rawFrames = detailData.frames || summary.frames || []
      if (rawFrames.length) {
        this.videoFps = this.toNumber(detailData.fps, summary.fps, 0)
        return this.normalizeFrames(rawFrames)
      }
      return []
    },
    normalizeFrames(frames) {
      return (frames || []).map(item => ({
        frameIndex: this.toNumber(item.frameIndex, item.frame_index, 0),
        timestampSec: this.toNumber(item.timestampSec, item.timestamp_sec, 0),
        maxConfidence: this.toNumber(item.maxConfidence, item.max_confidence, 0),
        boxes: this.normalizeBoxes(item.boxes || [])
      }))
    },
    normalizeBoxes(boxes) {
      return (boxes || []).map(box => ({
        x1: this.toNumber(box.x1, box.bboxX, 0),
        y1: this.toNumber(box.y1, box.bboxY, 0),
        x2: this.toNumber(box.x2, this.toNumber(box.bboxX, 0) + this.toNumber(box.bboxWidth, 0), 0),
        y2: this.toNumber(box.y2, this.toNumber(box.bboxY, 0) + this.toNumber(box.bboxHeight, 0), 0),
        className: this.toClassZh(box.className || box.class_name || box.classification || 'polyp'),
        score: this.toNumber(box.score, box.confidence, 0)
      }))
    },
    flattenHitRows(frames) {
      const rows = []
      ;(frames || []).forEach(frame => {
        const frameBoxes = frame.boxes || []
        if (!frameBoxes.length) return
        const maxConfidence = frame.maxConfidence || Math.max(...frameBoxes.map(b => this.toNumber(b.score, 0)))
        frameBoxes.forEach((box, idx) => {
          rows.push({
            rowKey: `${frame.frameIndex}-${idx}`,
            frameIndex: frame.frameIndex,
            timestampSec: this.toNumber(frame.timestampSec, this.videoFps ? frame.frameIndex / this.videoFps : 0, 0),
            boxCount: frameBoxes.length,
            maxConfidence,
            className: box.className,
            position: `${box.x1},${box.y1},${box.x2},${box.y2}`
          })
        })
      })
      return rows
    },
    buildImageBoxRows(detailData) {
      const rawBoxes = detailData && Array.isArray(detailData.boxes) ? detailData.boxes : []
      const summary = detailData && detailData.inferenceSummary ? detailData.inferenceSummary : {}
      const representativeBoxes = Array.isArray(summary.representativeBoxes) ? summary.representativeBoxes : []

      if (rawBoxes.length) {
        return rawBoxes.map((box, index) => ({
          ...box,
          confidence: this.resolveImageConfidence(box, representativeBoxes[index]),
          classification: box.classification || box.className || box.class_name || 'polyp',
          position: box.position || this.resolveBoxPosition(box, representativeBoxes[index])
        }))
      }

      return representativeBoxes.map((box) => ({
        classification: box.classification || box.className || box.class_name || 'polyp',
        confidence: this.resolveImageConfidence({}, box),
        position: this.resolveBoxPosition({}, box)
      }))
    },
    resolveImageConfidence(detailBox, representativeBox) {
      if (this.hasValue(detailBox && detailBox.confidence)) {
        return this.toNumber(detailBox.confidence)
      }
      if (this.hasValue(detailBox && detailBox.score)) {
        return this.toNumber(detailBox.score)
      }
      if (this.hasValue(representativeBox && representativeBox.score)) {
        return this.toNumber(representativeBox.score)
      }
      if (this.hasValue(representativeBox && representativeBox.confidence)) {
        return this.toNumber(representativeBox.confidence)
      }
      return null
    },
    resolveBoxPosition(detailBox, representativeBox) {
      const x1 = this.toOptionalNumber(detailBox && detailBox.bboxX, detailBox && detailBox.x1, representativeBox && representativeBox.x1)
      const y1 = this.toOptionalNumber(detailBox && detailBox.bboxY, detailBox && detailBox.y1, representativeBox && representativeBox.y1)
      const width = this.toOptionalNumber(detailBox && detailBox.bboxWidth)
      const height = this.toOptionalNumber(detailBox && detailBox.bboxHeight)
      const x2 = this.toOptionalNumber(detailBox && detailBox.x2, this.hasValue(x1) && this.hasValue(width) ? x1 + width : null, representativeBox && representativeBox.x2)
      const y2 = this.toOptionalNumber(detailBox && detailBox.y2, this.hasValue(y1) && this.hasValue(height) ? y1 + height : null, representativeBox && representativeBox.y2)
      if (!this.hasValue(x1) || !this.hasValue(y1) || !this.hasValue(x2) || !this.hasValue(y2)) {
        return '-'
      }
      return `${x1},${y1},${x2},${y2}`
    },
    hasValue(value) {
      return value !== null && value !== undefined && value !== ''
    },
    jumpToVideoTimestamp(row) {
      if (!row || this.currentFileType !== 'video' || !this.$refs.videoEl) return
      this.$refs.videoEl.currentTime = this.toNumber(row.timestampSec, 0)
    },
    changePlaybackRate(rate) {
      if (this.$refs.videoEl) {
        const value = Number(rate)
        this.$refs.videoEl.playbackRate = Number.isNaN(value) ? 1 : value
      }
    },
    toClassZh(className) {
      const normalized = (className || '').toString().toLowerCase()
      if (!normalized || normalized === 'polyp') return '息肉'
      return className
    },
    normalizeFileUrl(fileUrl) {
      if (!fileUrl) return ''
      let normalized = String(fileUrl).replace(/\\/g, '/').trim()
      if (!normalized) return ''
      if (normalized.startsWith('http://') || normalized.startsWith('https://')) return this.ensureHttpsForSeetaCloud(normalized)
      normalized = normalized.replace(/^\/(dev-api|prod-api)(?=\/profile\/)/, '')
      if (normalized.startsWith('profile/')) normalized = '/' + normalized
      return normalized.startsWith('/') ? normalized : '/' + normalized
    },
    ensureHttpsForSeetaCloud(url) {
      if (!url || !/^http:\/\//i.test(url)) {
        return url
      }
      try {
        const parsed = new URL(url)
        if (parsed.hostname && parsed.hostname.endsWith('.westc.seetacloud.com')) {
          parsed.protocol = 'https:'
          return parsed.toString()
        }
      } catch (e) {
        return url
      }
      return url
    },
    toNumber() {
      for (let i = 0; i < arguments.length; i++) {
        const value = arguments[i]
        if (value === null || value === undefined || value === '') continue
        const num = Number(value)
        if (!Number.isNaN(num)) return num
      }
      return 0
    },
    toOptionalNumber() {
      for (let i = 0; i < arguments.length; i++) {
        const value = arguments[i]
        if (value === null || value === undefined || value === '') continue
        const num = Number(value)
        if (!Number.isNaN(num)) return num
      }
      return null
    },
    getFileTypeByName(name) {
      const ext = (name.split('.').pop() || '').toLowerCase()
      if (this.videoExts.includes(ext)) return 'video'
      if (this.imageExts.includes(ext)) return 'image'
      return ''
    },
    async getTaskList() {
      this.listLoading = true
      try {
        const query = this.addDateRange({ ...this.queryParams }, this.dateRange)
        const res = await listPolypTask(query)
        this.taskList = res.rows || []
        this.total = res.total || 0
      } finally {
        this.listLoading = false
      }
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getTaskList()
    },
    resetQuery() {
      this.resetForm('queryForm')
      this.dateRange = []
      this.handleQuery()
    },
    handleDelete(row) {
      const taskIds = row && row.taskId ? [row.taskId] : []
      if (!taskIds.length) {
        return
      }
      this.$modal.confirm(`确认删除任务ID为“${taskIds.join(',')}”的数据项吗？`).then(() => {
        return deletePolypTask(taskIds.join(','))
      }).then(() => {
        if (this.currentDetail && this.currentDetail.task && taskIds.indexOf(this.currentDetail.task.taskId) >= 0) {
          this.currentDetail = null
          this.currentImageUrl = ''
          this.currentVideoUrl = ''
          this.videoHitRows = []
        }
        this.$modal.msgSuccess('删除成功')
        this.getTaskList()
      }).catch(() => {})
    },
    handleExport() {
      const query = this.addDateRange({ ...this.queryParams }, this.dateRange)
      this.download('system/polyp/task/export', query, `polyp_task_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>

<style scoped>
.block-gap { margin-top: 16px; }
.upload-block { margin-top: 16px; }
.actions { margin-top: 12px; }
.upload-selected-panel { margin-top: 8px; padding: 8px 12px; border: 1px solid #ebeef5; border-radius: 4px; background: #fafafa; display: flex; align-items: center; gap: 8px; }
.upload-selected-icon { color: #909399; font-size: 16px; }
.upload-selected-name { color: #606266; font-size: 13px; flex: 1; min-width: 0; word-break: break-all; }
.upload-selected-remove { padding: 0; }
.label { font-weight: 600; margin-bottom: 8px; }
.meta { margin-left: 12px; color: #606266; }
.align-right { text-align: right; }
.preview { max-width: 100%; max-height: 420px; border: 1px solid #ebeef5; border-radius: 4px; display: block; }
.video-toolbar { margin-top: 10px; display: flex; align-items: center; }
.rate-label { color: #606266; font-size: 13px; margin-right: 8px; }
.video-box-pagination { margin-top: 10px; text-align: right; }
</style>

