import mediaquery from '@ohos.mediaquery'
import logger from '../utils/logger'

@Builder
export function entryBuilder() {
  entry()
}

@Entry
@Component
struct entry {
  pageInfos: NavPathStack = new NavPathStack();
  listener = mediaquery.matchMediaSync('(orientation: landscape)')

  aboutToAppear() {
    this.listener.on('change', (mediaQueryResult) => {
      if (mediaQueryResult.matches) {
        logger.info('-->>>> ', '横屏')
      } else {
        logger.info('-->>>> ', '竖屏')
      }
    })
  }

  aboutToDisappear() {
    logger.info('-->>>> entry', '销毁')
  }

  build() {
    Navigation(this.pageInfos) {
      //* onReady 会在 onAppear 之前调用 *//

      // aboutToAppear 自定义组件析构销毁之前执行。
      // onAppear 组件挂载显示时触发此回调。
      // onReady 当NavDestination即将构建子组件之前会触发此回调。
      // onShown 当该NavDestination页面显示时触发此回调。
      // onHidden 当该NavDestination页面隐藏时触发此回调。
      // onDisAppear 组件卸载消失时触发此回调。
      // aboutToDisappear 在自定义组件析构销毁之前执行。
    }
    .title('entry')
    .onAppear(() => {
      // 进入首屏广告
      this.pageInfos.replacePathByName("ads", null, false)
    })
    .hideNavBar(true)
  }
}