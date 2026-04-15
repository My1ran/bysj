import request from '@/utils/request'

// 查询息肉详情列表
export function listPolyp(query) {
  return request({
    url: '/system/polyp/list',
    method: 'get',
    params: query
  })
}

// 查询息肉详情详细
export function getPolyp(polypId) {
  return request({
    url: '/system/polyp/' + polypId,
    method: 'get'
  })
}

// 新增息肉详情
export function addPolyp(data) {
  return request({
    url: '/system/polyp',
    method: 'post',
    data: data
  })
}

// 修改息肉详情
export function updatePolyp(data) {
  return request({
    url: '/system/polyp',
    method: 'put',
    data: data
  })
}

// 删除息肉详情
export function delPolyp(polypId) {
  return request({
    url: '/system/polyp/' + polypId,
    method: 'delete'
  })
}

// 根据检测结果ID查询息肉详情
export function listPolypByResultId(resultId) {
  return request({
    url: '/system/polyp/listByResult/' + resultId,
    method: 'get'
  })
}
