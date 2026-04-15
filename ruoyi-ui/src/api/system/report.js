import request from '@/utils/request'

// 查询检测报告详情
export function getReport(resultId) {
  return request({
    url: '/system/report/' + resultId,
    method: 'get'
  })
}

// 导出 PDF 报告
export function exportPdf(resultId) {
  return request({
    url: '/system/report/' + resultId + '/pdf',
    method: 'get',
    responseType: 'blob'
  })
}
