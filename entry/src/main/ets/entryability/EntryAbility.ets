import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
// import { logger } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import logger from '../utils/logger';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    logger.info('Ability onCreate');
  }

  onDestroy(): void {
    logger.info('Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    logger.info('Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        logger.error('Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      logger.info('Succeeded in loading the content.');

      // 获取应用主窗口
      const windowClass: window.Window = windowStage.getMainWindowSync();
      // 1. 设置窗口全屏
      windowClass.setWindowLayoutFullScreen(true);
      // 2. 缓存window窗口对象
      AppStorage.setOrCreate('windowClass', windowClass);
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    logger.info('Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    logger.info('Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    logger.info('Ability onBackground');
  }
}
