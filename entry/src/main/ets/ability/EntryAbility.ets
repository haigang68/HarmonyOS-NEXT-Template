import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import notificationManager from '@ohos.notificationManager';
import logger from '../utils/logger';
import { window } from '@kit.ArkUI';
import Base from '@ohos.base';
import { JPush } from '../utils/jpush'

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    logger.info('Ability onCreate...');

    // 极光推送
    new JPush(want, this.context);

    // 申请打开通知开关 (如果没有打开通知开关，将收不到通知)
    notificationManager.requestEnableNotification().then(() => {
      logger.info('申请打开通知开关-success')
    }).catch((err: Base.BusinessError) => {
      logger.info('申请打开通知开关-err', `code:${err.code}, message:${err.message}`)
    });
  }

  onDestroy(): void {
    logger.info('Ability onDestroy...');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    logger.info('Ability onWindowStageCreate');

    windowStage.loadContent('pages/entry', (err) => {
      if (err.code) {
        logger.error('加载失败...', JSON.stringify(err) ?? '');
        return;
      }
      logger.info('加载成功...');

      // 获取应用主窗口
      // const windowClass: window.Window = windowStage.getMainWindowSync();
      // 1. 设置窗口全屏
      // windowClass.setWindowLayoutFullScreen(true);
      // 2. 缓存window窗口对象
      // AppStorage.setOrCreate('windowClass', windowClass);
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    logger.info('Ability onWindowStageDestroy...');
  }

  onForeground(): void {
    // Ability has brought to foreground
    logger.info('Ability onForeground...');
  }

  onBackground(): void {
    // Ability has back to background
    logger.info('Ability onBackground...');
  }
}
