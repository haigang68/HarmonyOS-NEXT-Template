import display from '@ohos.display';
import deviceInfo from '@ohos.deviceInfo';

// 手机端缩放vp
const designWidth = 375
const width = display.getDefaultDisplaySync().width

export const rvp = (origin: number): number => {
  if (deviceInfo.deviceType === 'default') {
    return rvp(width) / designWidth * origin
  }
  return origin
}