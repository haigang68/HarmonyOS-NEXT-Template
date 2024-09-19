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

  build() {
    NavDestination() {
      Column() {
        Web({ src: 'www.example.com', controller: this.controller })
          .domStorageAccess(true)
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