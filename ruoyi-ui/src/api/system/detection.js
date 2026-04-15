import request from '@/utils/request'

// 查询检测结果列表
export function listDetection(query) {
  return request({
    url: '/system/detection/list',
    method: 'get',
    params: query
  })
}

// 查询检测结果详细
export function getDetection(resultId) {
  return request({
    url: '/system/detection/' + resultId,
    method: 'get'
  })
}

// 上传图片并检测
export function uploadDetect(file, patiId) {
  const formData = new FormData()
  formData.append('file', file)
  if (patiId) {
    formData.append('patiId', patiId)
  }
  return request({
    url: '/system/detection/upload',
    method: 'post',
    data: formData,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
}

// 删除检测结果
export function delDetection(resultId) {
  return request({
    url: '/system/detection/' + resultId,
    method: 'delete'
  })
}

// 导出检测结果
export function exportDetection(query) {
  return request({
    url: '/system/detection/export',
    method: 'post',
    params: query
  })
}
