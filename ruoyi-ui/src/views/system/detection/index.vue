<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="患者姓名" prop="patiName">
        <el-input
          v-model="queryParams.patiName"
          placeholder="请输入患者姓名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="检测类型" prop="detectionType">
        <el-select v-model="queryParams.detectionType" placeholder="请选择检测类型" clearable>
          <el-option label="图片检测" value="0" />
          <el-option label="视频检测" value="1" />
          <el-option label="实时检测" value="2" />
        </el-select>
      </el-form-item>
      <el-form-item label="报告生成" prop="reportGenerated">
        <el-select v-model="queryParams.reportGenerated" placeholder="请选择" clearable>
          <el-option label="是" value="1" />
          <el-option label="否" value="0" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleUpload"
          v-hasPermi="['system:detection:upload']"
        >上传检测</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:detection:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:detection:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="detectionList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="检测 ID" align="center" prop="resultId" />
      <el-table-column label="患者 ID" align="center" prop="patiId" />
      <el-table-column label="患者姓名" align="center" prop="patiName" />
      <el-table-column label="检测类型" align="center" prop="detectionType">
        <template slot-scope="scope">
          <dict-tag :options="detectionTypeDict" :value="scope.row.detectionType"/>
        </template>
      </el-table-column>
      <el-table-column label="样本编号" align="center" prop="sampleNumber" />
      <el-table-column label="息肉数量" align="center" prop="polypCount" />
      <el-table-column label="平均置信度" align="center" prop="avgConfidence" />
      <el-table-column label="检测时间" align="center" prop="detectionTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.detectionTime, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="200">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-view"
            @click="handleView(scope.row)"
          >查看</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-download"
            @click="handleDownload(scope.row)"
          >下载</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:detection:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 检测结果详情对话框 -->
    <el-dialog :title="检测结果详情" :visible.sync="openView" width="900px" append-to-body>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="检测 ID">{{ viewForm.resultId }}</el-descriptions-item>
        <el-descriptions-item label="患者姓名">{{ viewForm.patiName }}</el-descriptions-item>
        <el-descriptions-item label="检测类型">
          <dict-tag :options="detectionTypeDict" :value="viewForm.detectionType"/>
        </el-descriptions-item>
        <el-descriptions-item label="样本编号">{{ viewForm.sampleNumber }}</el-descriptions-item>
        <el-descriptions-item label="息肉数量">{{ viewForm.polypCount }}</el-descriptions-item>
        <el-descriptions-item label="平均置信度">{{ viewForm.avgConfidence }}</el-descriptions-item>
        <el-descriptions-item label="最大尺寸">{{ viewForm.maxSize }} mm</el-descriptions-item>
        <el-descriptions-item label="最小尺寸">{{ viewForm.minSize }} mm</el-descriptions-item>
        <el-descriptions-item label="检测时间">
          {{ parseTime(viewForm.detectionTime, '{y}-{m}-{d} {h}:{i}:{s}') }}
        </el-descriptions-item>
      </el-descriptions>

      <el-divider content-position="left">检测结果图片</el-divider>
      <div style="text-align: center;">
        <img :src="imageUrl" alt="检测结果" style="max-width: 100%; max-height: 500px;" />
      </div>

      <el-divider content-position="left">息肉详情</el-divider>
      <el-table :data="polypDetails" size="small" max-height="300">
        <el-table-column label="序号" type="index" width="50" align="center" />
        <el-table-column label="置信度" align="center" prop="confidence" />
        <el-table-column label="尺寸 (mm)" align="center" prop="sizeMm" />
        <el-table-column label="位置" align="center" prop="position" />
        <el-table-column label="分类" align="center" prop="classification" />
      </el-table>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="openView = false">关 闭</el-button>
      </div>
    </el-dialog>

    <!-- 上传检测对话框 -->
    <el-dialog :title="上传检测" :visible.sync="openUpload" width="600px" append-to-body>
      <el-form ref="uploadForm" :model="uploadForm" label-width="80px">
        <el-form-item label="选择患者" prop="patiId">
          <el-select v-model="uploadForm.patiId" placeholder="请选择患者 (可选)" clearable style="width: 100%">
            <el-option
              v-for="patient in patientList"
              :key="patient.patiId"
              :label="patient.patiName + ' (' + patient.patiCode + ')'"
              :value="patient.patiId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="上传图片" prop="file">
          <el-upload
            ref="fileUpload"
            action="#"
            :http-request="handleFileUpload"
            :before-upload="beforeFileUpload"
            :on-success="handleFileSuccess"
            :on-error="handleFileError"
            :limit="1"
            :file-list="fileList"
            accept="image/jpg,image/jpeg,image/png,image/bmp"
          >
            <el-button type="primary">选择文件</el-button>
            <div slot="tip" class="el-upload__tip">
              只能上传 jpg/png/bmp 文件，且不超过 10MB
            </div>
          </el-upload>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitUpload">开始检测</el-button>
        <el-button @click="openUpload = false">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listDetection, getDetection, delDetection, uploadDetect } from "@/api/system/detection";
import { listPatient } from "@/api/system/patient";

export default {
  name: "Detection",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 检测结果表格数据
      detectionList: [],
      // 检测类型字典
      detectionTypeDict: [
        { label: '图片检测', value: '0' },
        { label: '视频检测', value: '1' },
        { label: '实时检测', value: '2' }
      ],
      // 患者列表
      patientList: [],
      // 弹出层标题
      openView: false,
      openUpload: false,
      // 查看详情表单
      viewForm: {},
      // 息肉详情列表
      polypDetails: [],
      // 图片 URL
      imageUrl: '',
      // 上传表单
      uploadForm: {
        patiId: null,
        file: null
      },
      // 文件列表
      fileList: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        patiName: null,
        detectionType: null,
        reportGenerated: null
      }
    };
  },
  created() {
    this.getList();
    this.getPatientList();
  },
  methods: {
    /** 查询检测结果列表 */
    getList() {
      this.loading = true;
      listDetection(this.queryParams).then(response => {
        this.detectionList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    /** 查询患者列表 */
    getPatientList() {
      listPatient({ pageSize: 1000 }).then(response => {
        this.patientList = response.rows;
      });
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.resultId)
      this.multiple = !selection.length
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    /** 上传检测按钮操作 */
    handleUpload() {
      this.reset();
      this.openUpload = true;
    },
    /** 查看按钮操作 */
    handleView(row) {
      getDetection(row.resultId).then(response => {
        this.viewForm = response.data;
        this.polypDetails = response.data.polypDetails || [];
        this.imageUrl = response.data.resultFile ? this.baseUrl + response.data.resultFile : '';
        this.openView = true;
      });
    },
    // 文件上传前校验
    beforeFileUpload(file) {
      const isImage = file.type === 'image/jpeg' || file.type === 'image/png' || file.type === 'image/bmp';
      const isLt10M = file.size / 1024 / 1024 < 10;
      if (!isImage) {
        this.$modal.msgError('只能上传 JPG/PNG/BMP 格式的图片!');
        return false;
      }
      if (!isLt10M) {
        this.$modal.msgError('图片大小不能超过 10MB!');
        return false;
      }
      this.uploadForm.file = file;
      return true;
    },
    // 文件上传
    handleFileUpload(options) {
      const { file } = options;
      this.uploadForm.file = file;
    },
    // 文件上传成功
    handleFileSuccess(response, file) {
      console.log('upload success', response);
    },
    // 文件上传失败
    handleFileError(error) {
      console.error('upload error', error);
    },
    // 提交上传
    submitUpload() {
      if (!this.uploadForm.file) {
        this.$modal.msgError('请选择要检测的图片');
        return;
      }
      const formData = new FormData();
      formData.append('file', this.uploadForm.file);
      if (this.uploadForm.patiId) {
        formData.append('patiId', this.uploadForm.patiId);
      }

      this.$modal.loading("正在检测，请稍候...");
      uploadDetect(formData).then(response => {
        this.$modal.closeLoading();
        this.$modal.msgSuccess(`检测完成，发现 ${response.data.polypCount} 个息肉`);
        this.openUpload = false;
        this.getList();
      }).catch(() => {
        this.$modal.closeLoading();
      });
    },
    // 表单重置
    reset() {
      this.uploadForm = {
        patiId: null,
        file: null
      };
      this.fileList = [];
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const resultIds = row.resultId || this.ids;
      this.$modal.confirm('是否确认删除检测编号为"' + resultIds + '"的数据项？').then(function() {
        return delDetection(resultIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.$modal.confirm('是否确认导出所有检测结果数据项？').then(() => {
        // return exportDetection(this.queryParams);
      }).catch(() => {});
    },
    /** 下载按钮操作 */
    handleDownload(row) {
      // 下载检测结果
      this.$modal.msgSuccess("开始下载检测结果");
    }
  }
};
</script>
