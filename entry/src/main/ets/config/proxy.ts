export default {
  test: {
    BASE_URL: 'https://ama.internal.manulife-sinochem.com/adpms',
    AMA_URL: 'https://amasit01.manulife-sinochem.com',
    BLOB_URL: 'https://amasit01.manulife-sinochem.com/ama-gateway/ama-cloud-sys/api/file/containerSas'
  },
  pre: {
    BASE_URL: 'https://amauat.manulife-sinochem.com/adpmsphase2',
    AMA_URL: 'https://amaclouduat.manulife-sinochem.com',
    BLOB_URL: 'https://amaclouduat.manulife-sinochem.com/ama-gateway/ama-cloud-sys/api/file/containerSas'
  },
  prd: {
    BASE_URL: ''
  }
};