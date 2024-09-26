import http from '@ohos.net.http'
import { Auth } from '../models/Auth'

const BASE_URL = 'https://api-harmony-teach.itheima.net/hm/'
const req = http.createHttp()

const code: Record<number, string> = {
  200: '服务器成功返回请求的数据。',
  // 201: '新建或修改数据成功。',
  // 202: '一个请求已经进入后台排队（异步任务）。',
  // 204: '删除数据成功。',
  // 400: '发出的请求有错误，服务器没有进行新建或修改数据的操作。',
  // 401: '用户没有权限（令牌、用户名、密码错误）。',
  // 403: '用户得到授权，但是访问是被禁止的。',
  // 404: '发出的请求针对的是不存在的记录，服务器没有进行操作。',
  // 405: '请求方法不被允许。',
  // 406: '请求的格式不可得。',
  // 410: '请求的资源被永久删除，且不会再得到的。',
  // 422: '当创建一个对象时，发生一个验证错误。',
  // 500: '服务器发生错误，请检查服务器。',
  // 502: '网关错误。',
  // 503: '服务不可用，服务器暂时过载或维护。',
  // 504: '网关超时。',
}

const request = (
  url: string,
  method: http.RequestMethod = http.RequestMethod.GET,
  params: Record<string, string | number> = {}
) => {
  let fullUrl = BASE_URL + url
  const options: http.HttpRequestOptions = {
    header: {
      'Content-Type': 'application/json',
    },
    readTimeout: 30000,
    method,
  }

  // 如果是对象数据拼接URL，如果是其他则携带在 extraData
  if (method === http.RequestMethod.GET) {
    const urlParams = Object.keys(params).map(key => `${key}=${params[key]}`)
    fullUrl += `?${urlParams.join('&')}`
  } else {
    options.extraData = params
  }

  // 携带 token
  const user = Auth.getUser()
  if (user.token && options.header) {
    options.header['Authorization'] = `Bearer ${user.token}`
  }

  return req.request(fullUrl, options)
}

export class Request {
  static get(url: string, params?: Record<string, string>): Promise<http.HttpResponse> {
    return request(url, http.RequestMethod.GET, params)
  }

  static post(url: string, params?: Record<string, string>): Promise<http.HttpResponse> {
    return request(url, http.RequestMethod.POST, params)
  }

  static put(url: string, params?: Record<string, string>): Promise<http.HttpResponse> {
    return request(url, http.RequestMethod.PUT, params)
  }

  static delete(url: string, params?: Record<string, string>): Promise<http.HttpResponse> {
    return request(url, http.RequestMethod.DELETE, params)
  }
}