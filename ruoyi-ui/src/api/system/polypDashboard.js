import request from '@/utils/request'

export function getPolypDashboardOverview() {
  return request({
    url: '/system/polyp/dashboard/overview',
    method: 'get'
  })
}

export function getPolypDashboardTrend() {
  return request({
    url: '/system/polyp/dashboard/trend',
    method: 'get'
  })
}

export function getPolypDashboardDistribution() {
  return request({
    url: '/system/polyp/dashboard/distribution',
    method: 'get'
  })
}

export function getPolypDashboardRecent(limit = 10) {
  return request({
    url: '/system/polyp/dashboard/recent',
    method: 'get',
    params: { limit }
  })
}
