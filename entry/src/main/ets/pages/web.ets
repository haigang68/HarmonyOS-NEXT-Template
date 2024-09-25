import { webview } from '@kit.ArkWeb';

@Builder
export function webBuilder() {
  web()
}

@Entry
@Component
struct web {
  pageInfos: NavPathStack = new NavPathStack()
  controller: webview.WebviewController = new webview.WebviewController();

  aboutToAppear(): void {
    try {
      // 设置调试
      webview.WebviewController.setWebDebuggingAccess(true);
    } catch (error) {
      console.error(error);
    }
  }

  build() {
    NavDestination() {
      Column() {
        Web({ src: 'www.example.com', controller: this.controller })
          .domStorageAccess(true)
          .onControllerAttached(() => {
            // 注册 jsbridge，类，h5中的名字，注册的方法
            // this.controller.registerJavaScriptProxy('', "objTestName", ["webTest"]);
            // 这种注册必须调用refresh
            // this.controller.refresh()
          })
          .onLoadIntercept((event) => {
            if (event) {
              const url = event.data.getRequestUrl()
              if (url.startsWith('native:')) {
                // 处理原生交互逻辑
                return true
              }
            }
            // 返回 true 表示阻止此次加载，否则允许此次加载
            return false
          })
      }
      .width('100%')
    }
    .title('web')
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack
    })
  }
}