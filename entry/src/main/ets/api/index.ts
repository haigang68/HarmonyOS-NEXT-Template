import request from '../utils/request';
import { ENV } from '../config/env';
import proxy from '../config/proxy';

/**
 * get｜post
 * request.post(url, params)
 * request.get(url, { params: {} })
 */
const { AMA_URL } = proxy[ENV]

export const
  login = (params = {}) => request.get(`${AMA_URL}/login`, { params });

export const
  loginout = (params = {}) => request.post(`${AMA_URL}/loginout`, params);

export const
  getHomeData = (params = {}) => request.post(`${AMA_URL}/getHomeData`, params);