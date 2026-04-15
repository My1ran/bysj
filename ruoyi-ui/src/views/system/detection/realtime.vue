<template>
  <div class="app-container">
    <el-row :gutter="20">
      <!-- 摄像头选择区域 -->
      <el-col :span="16">
        <el-card class="box-card">
          <div slot="header" class="clearfix">
            <span>实时检测</span>
            <el-button
              style="float: right; padding: 3px 10px"
              type="primary"
              size="small"
              @click="startDetection"
              v-if="!isDetecting"
            >
              开始检测
            </el-button>
            <el-button
              style="float: right; padding: 3px 10px"
              type="danger"
              size="small"
              @click="stopDetection"
              v-else
            >
              停止检测
            </el-button>
          </div>

          <div class="video-container">
            <video
              ref="video"
              autoplay
              playsinline
              style="width: 100%; max-width: 640px;"
            ></video>
            <canvas
              ref="canvas"
              style="display: none;"
            ></canvas>
          </div>

          <div class="detection-info" v-if="isDetecting">
            <el-tag type="success" effect="dark">检测中...</el-tag>
            <span style="margin-left: 10px;">检测到息肉数量：<strong>{{ currentPolypCount }}</strong></span>
          </div>
        </el-card>

        <!-- 检测结果叠加显示 -->
        <el-card class="box-card" style="margin-top: 20px;">
          <div slot="header" class="clearfix">
            <span>检测结果</span>
          </div>
          <div class="result-container">
            <canvas
              ref="resultCanvas"
              style="width: 100%; max-width: 640px;"
            ></canvas>
          </div>
        </el-card>
      </el-col>

      <!-- 检测统计区域 -->
      <el-col :span="8">
        <el-card class="box-card">
          <div slot="header" class="clearfix">
            <span>检测统计</span>
          </div>
          <el-descriptions :column="1" border>
            <el-descriptions-item label="检测时长">{{ detectionDuration }}s</el-descriptions-item>
            <el-descriptions-item label="检测帧数">{{ frameCount }}</el-descriptions-item>
            <el-descriptions-item label="息肉数量">{{ currentPolypCount }}</el-descriptions-item>
            <el-descriptions-item label="平均置信度">{{ avgConfidence }}%</el-descriptions-item>
          </el-descriptions>

          <el-divider content-position="left">当前检测结果</el-divider>
          <el-table :data="currentDetections" size="small" max-height="300">
            <el-table-column label="序号" type="index" width="50" align="center" />
            <el-table-column label="置信度" align="center" prop="confidence" />
            <el-table-column label="位置" align="center" prop="position" />
            <el-table-column label="尺寸" align="center" prop="size" />
          </el-table>

          <el-divider content-position="left">保存记录</el-divider>
          <el-form :model="saveForm" label-width="80px" size="small">
            <el-form-item label="选择患者">
              <el-select v-model="saveForm.patiId" placeholder="请选择患者" clearable style="width: 100%">
                <el-option
                  v-for="patient in patientList"
                  :key="patient.patiId"
                  :label="patient.patiName + ' (' + patient.patiCode + ')'"
                  :value="patient.patiId"
                />
              </el-select>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="saveResult" :disabled="!isDetecting">
                保存检测结果
              </el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { listPatient } from "@/api/system/patient";
import { uploadDetect } from "@/api/system/detection";

export default {
  name: "RealtimeDetection",
  data() {
    return {
      // 视频相关
      videoStream: null,
      isDetecting: false,
      detectionInterval: null,
      frameCount: 0,
      detectionStartTime: null,

      // 检测结果
      currentPolypCount: 0,
      currentDetections: [],
      avgConfidence: 0,

      // 患者列表
      patientList: [],

      // 保存表单
      saveForm: {
        patiId: null
      },

      // 检测时长
      detectionDuration: 0,
      durationTimer: null
    };
  },
  created() {
    this.getPatientList();
  },
  beforeDestroy() {
    this.stopDetection();
  },
  methods: {
    /** 查询患者列表 */
    getPatientList() {
      listPatient({ pageSize: 1000 }).then(response => {
        this.patientList = response.rows;
      });
    },

    /** 开始检测 */
    async startDetection() {
      try {
        // 请求摄像头权限
        this.videoStream = await navigator.mediaDevices.getUserMedia({
          video: {
            width: { ideal: 1280 },
            height: { ideal: 720 }
          }
        });

        this.$refs.video.srcObject = this.videoStream;
        this.isDetecting = true;
        this.frameCount = 0;
        this.detectionStartTime = Date.now();

        // 启动时长计时器
        this.durationTimer = setInterval(() => {
          this.detectionDuration = Math.floor((Date.now() - this.detectionStartTime) / 1000);
        }, 1000);

        // 开始定时检测（每 2 秒检测一帧）
        this.detectionInterval = setInterval(() => {
          this.captureAndDetect();
        }, 2000);

        this.$modal.msgSuccess("开始实时检测");
      } catch (err) {
        console.error('摄像头访问失败:', err);
        this.$modal.msgError("无法访问摄像头，请检查权限设置");
      }
    },

    /** 停止检测 */
    stopDetection() {
      if (this.detectionInterval) {
        clearInterval(this.detectionInterval);
        this.detectionInterval = null;
      }
      if (this.durationTimer) {
        clearInterval(this.durationTimer);
        this.durationTimer = null;
      }
      if (this.videoStream) {
        this.videoStream.getTracks().forEach(track => track.stop());
        this.videoStream = null;
      }
      if (this.$refs.video) {
        this.$refs.video.srcObject = null;
      }
      this.isDetecting = false;
      this.$modal.msgSuccess("停止检测");
    },

    /** 捕获帧并检测 */
    captureAndDetect() {
      const video = this.$refs.video;
      const canvas = this.$refs.canvas;
      const context = canvas.getContext('2d');

      // 设置 canvas 尺寸与视频一致
      canvas.width = video.videoWidth;
      canvas.height = video.videoHeight;

      // 绘制当前帧
      context.drawImage(video, 0, 0, canvas.width, canvas.height);

      // 将帧转换为 Blob 并发送检测
      canvas.toBlob(async (blob) => {
        if (!blob) return;

        this.frameCount++;

        // 创建 FormData 发送检测
        const formData = new FormData();
        formData.append('file', blob, 'frame.jpg');
        if (this.saveForm.patiId) {
          formData.append('patiId', this.saveForm.patiId);
        }

        try {
          const response = await uploadDetect(formData);
          this.updateDetectionResult(response.data);
        } catch (error) {
          console.error('检测失败:', error);
        }
      }, 'image/jpeg', 0.8);
    },

    /** 更新检测结果 */
    updateDetectionResult(data) {
      this.currentPolypCount = data.polypCount || 0;
      this.currentDetections = (data.detections || []).map((det, index) => ({
        index: index + 1,
        confidence: (parseFloat(det.confidence) * 100).toFixed(1) + '%',
        position: `${det.bbox.x}, ${det.bbox.y}`,
        size: `${det.bbox.width} x ${det.bbox.height}`
      }));

      // 计算平均置信度
      if (this.currentDetections.length > 0) {
        const sum = this.currentDetections.reduce((acc, cur) => {
          return acc + parseFloat(cur.confidence);
        }, 0);
        this.avgConfidence = (sum / this.currentDetections.length).toFixed(1);
      } else {
        this.avgConfidence = 0;
      }

      // 在 canvas 上绘制检测结果
      this.drawDetections(data.detections);
    },

    /** 绘制检测结果 */
    drawDetections(detections) {
      const resultCanvas = this.$refs.resultCanvas;
      const canvas = this.$refs.canvas;
      const context = resultCanvas.getContext('2d');

      // 设置结果 canvas 尺寸
      resultCanvas.width = canvas.width;
      resultCanvas.height = canvas.height;

      // 绘制原始帧
      context.drawImage(canvas, 0, 0);

      // 绘制检测框
      if (detections && detections.length > 0) {
        detections.forEach(det => {
          const { x, y, width, height } = det.bbox;
          const confidence = (parseFloat(det.confidence) * 100).toFixed(1);

          // 绘制边界框
          context.strokeStyle = '#00ff00';
          context.lineWidth = 3;
          context.strokeRect(x, y, width, height);

          // 绘制标签背景
          const label = `息肉 ${confidence}%`;
          context.font = '16px Arial';
          const textWidth = context.measureText(label).width;
          context.fillStyle = 'rgba(0, 255, 0, 0.7)';
          context.fillRect(x, y - 25, textWidth + 10, 25);

          // 绘制标签文字
          context.fillStyle = '#000000';
          context.fillText(label, x + 5, y - 7);
        });
      }
    },

    /** 保存检测结果 */
    saveResult() {
      if (!this.saveForm.patiId) {
        this.$modal.msgWarning("请选择患者");
        return;
      }

      // 捕获当前帧并保存
      const canvas = this.$refs.canvas;
      canvas.toBlob(async (blob) => {
        if (!blob) return;

        const formData = new FormData();
        formData.append('file', blob, 'result.jpg');
        formData.append('patiId', this.saveForm.patiId);

        this.$modal.loading("正在保存检测结果...");
        try {
          await uploadDetect(formData);
          this.$modal.closeLoading();
          this.$modal.msgSuccess("检测结果已保存");
        } catch (error) {
          this.$modal.closeLoading();
          this.$modal.msgError("保存失败");
        }
      }, 'image/jpeg', 0.9);
    }
  }
};
</script>

<style scoped>
.video-container, .result-container {
  text-align: center;
  background-color: #000;
  padding: 10px;
  border-radius: 4px;
}

.detection-info {
  margin-top: 10px;
  text-align: center;
}

.box-card {
  margin-bottom: 20px;
}
</style>
