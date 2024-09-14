import { webview } from '@kit.ArkWeb';

@Entry
@Component
struct WebView {
  controller: webview.WebviewController = new webview.WebviewController();

  build() {
    Row() {
      Column() {
        Web({ src: 'www.example.com', controller: this.controller })
          .domStorageAccess(true)
      }
      .width('100%')
    }
    .height('100%')
  }
}

export default WebView