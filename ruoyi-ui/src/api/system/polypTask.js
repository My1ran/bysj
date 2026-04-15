import request from '@/utils/request'

export function uploadPolypFile(file) {
  const formData = new FormData()
  formData.append('file', file)
  return request({
    url: '/system/polyp/file/upload',
    method: 'post',
    headers: {
      'Content-Type': 'multipart/form-data'
    },
    data: formData
  })
}

export function createPolypTask(data) {
  return request({
    url: '/system/polyp/task',
    method: 'post',
    data
  })
}

export function getPolypTaskDetail(taskId) {
  return request({
    url: '/system/polyp/task/' + taskId,
    method: 'get'
  })
}

export function getPolypTaskDetailForView(taskId) {
  return request({
    url: '/system/polyp/task/' + taskId + '/view',
    method: 'get'
  })
}

export function listPolypTask(query) {
  return request({
    url: '/system/polyp/task/list',
    method: 'get',
    params: query
  })
}

export function deletePolypTask(taskIds) {
  return request({
    url: '/system/polyp/task/' + taskIds,
    method: 'delete'
  })
}

export function getCurrentPolypModel() {
  return request({
    url: '/system/polyp/model/current',
    method: 'get'
  })
}
