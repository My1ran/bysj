import request from '@/utils/request'

// 查询患者信息列表
export function listPatient(query) {
  return request({
    url: '/system/patient/list',
    method: 'get',
    params: query
  })
}

// 查询患者信息详细
export function getPatient(patiId) {
  return request({
    url: '/system/patient/' + patiId,
    method: 'get'
  })
}

// 新增患者信息
export function addPatient(data) {
  return request({
    url: '/system/patient',
    method: 'post',
    data: data
  })
}

// 修改患者信息
export function updatePatient(data) {
  return request({
    url: '/system/patient',
    method: 'put',
    data: data
  })
}

// 删除患者信息
export function delPatient(patiId) {
  return request({
    url: '/system/patient/' + patiId,
    method: 'delete'
  })
}

// 导出患者信息
export function exportPatient(query) {
  return request({
    url: '/system/patient/export',
    method: 'post',
    params: query
  })
}
