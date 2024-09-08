import request from '../utils/request'

// * request.get(url, { params: {} })
// * request.post(url, params)

export const
  login = (params = {}) => request.get('/login', { params });

export const
  loginout = (params = {}) => request.post('/loginout', params);

export const
  getHomeData = (params = {}) => request.post('/getHomeData', params);