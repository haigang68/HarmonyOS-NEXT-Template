import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';
import router from '@ohos.router'
import { Auth } from '../models/Auth'
import logger from './logger'

// const code = {
//   200: '服务器成功返回请求的数据。',
//   400: '发出的请求有错误，服务器没有进行新建或修改数据的操作。',
//   503: '服务不可用，服务器暂时过载或维护。',
//   504: '网关超时。',
// }

const user = Auth.getUser()

/**
 * request 请求封装
 * request.post(url, params)
 * request.get(url, { params: {} })
 */
const request = axios.create({
  timeout: 20000,
});

// 添加请求拦截器
request.interceptors.request.use(
  (config: InternalAxiosRequestConfig) => {
    // 对请求数据做点什么
    if (user.token) {
      // 携带 token
      config.headers['token'] = user.token;
    }
    return config;
  },
  (error: AxiosError) => {
    // 对请求错误做些什么
    return Promise.reject(error.message);
  }
);

// 添加响应拦截器
request.interceptors.response.use(
  (response: AxiosResponse) => {
    // 对响应数据做点什么
    const { url, method } = response.config;
    logger.info(`响应→${url}→${method}`, JSON.stringify(response.data));

    if (response.data.code === 200) {
      return response.data.data;
    }
    // 处理 token 失效
    if (response.data.code === 401) {
      Auth.delUser();
      return router.pushUrl({
        url: 'pages/Login'
      }, router.RouterMode.Single);
    }
    return Promise.reject(response);
  },
  (error: AxiosError) => {
    // 对响应错误做些什么
    return Promise.reject(error.message);
  }
);

export default request;
