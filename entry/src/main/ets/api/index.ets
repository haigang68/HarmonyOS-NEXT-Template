import request from '../utils/request';
import proxy from '../config/proxy';

const BASE_URL = proxy.BASE_URL;
const AMA_URL = proxy.AMA_URL;
const BLOB_URL = proxy.BLOB_URL;

interface PARAMS {}

/**
 * get｜post
 * request.post(url, params)
 * request.get(url, { params: {} })
 */
export const
  login = (params: PARAMS = {}) => request.get(`${AMA_URL}/login`, { params });

export const
  loginout = (params: PARAMS = {}) => request.post(`${AMA_URL}/loginout`, params);

export const
  getHomeData = (params: PARAMS = {}) => request.post(`${AMA_URL}/getHomeData`, params);