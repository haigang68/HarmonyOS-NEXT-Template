@Builder
export function AdsBuilder() {
  Ads()
}

@Entry
@Component
struct Ads {
  pageInfos: NavPathStack = new NavPathStack()
  @State time: number = 5; // 倒计时时间
  private timerId: number | null = null;

  // 启动倒计时
  countDown() {
    this.timerId = setInterval(() => {
      if (this.time > 0) {
        this.time--;
      } else {
        clearInterval(this.timerId!); // 倒计时结束，清除定时器
        this.navigateToHome(); // 跳转到主页
      }
    }, 1000);
  }

  aboutToAppear() {
    // 获取广告
    this.countDown()
  }

  aboutToDisappear() {
    if (this.timerId !== null) {
      clearInterval(this.timerId);
    }
  }

  // 跳转到主页
  navigateToHome() {
    if (this.timerId !== null) {
      clearInterval(this.timerId);
    }
    this.pageInfos.replacePathByName("home", null, false)
  }

  build() {
    Navigation(this.pageInfos) {
      // 广告图片
      Image('https://i0.hdslb.com/bfs/mall/mall/e4/c8/e4c8d4bad5606373dc261fb4fcda28c6.png')
        .width('100%')
        .height('100%')

      // 跳过按钮
      Button(`跳过 ${this.time}s`, { type: ButtonType.Capsule })
        .width(100)
        .height(50)
        .position({ top: 50, right: 20 })
        .onClick(() => this.navigateToHome())
    }
    .width('100%')
    .height('100%')
    .hideNavBar(true)
    .onAppear(() => {
      // 进入开屏广告
      console.log('=>>>> 进入开屏广告')
    })

    // .onWillAppear | 挂载前执行
    // .onAppear | 挂载时执行
    // .onWillShow | 布局显示之前执行
    // .onShown | 布局显示之后执行
    // .onWillHide | 隐藏之前执行
    // .onHidden | 隐藏后执行
    // .onWillDisappear | 销毁之前执行
    // .onDisappear | 卸载时执行
  }
}
