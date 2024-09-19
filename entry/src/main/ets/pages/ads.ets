@Builder
export function adsBuilder() {
  ads()
}

@Entry
@Component
struct ads {
  pageInfos: NavPathStack = new NavPathStack();
  @State @Watch('skip') time: number = 5; // 倒计时时间
  private timerId: number | null = null;

  // 启动倒计时
  countDown() {
    this.timerId = setInterval(() => {
      if (this.time > 0) {
        this.time--;
      } else {
        clearInterval(this.timerId!); // 倒计时结束，清除定时器
        this.goTo(); // 跳转到主页
      }
    }, 1000);
  }

  // 自动跳过
  skip() {
    console.log('time--', this.time)
    if (this.time <= 0) {
      this.pageInfos.replacePathByName("index", null, false)
    }
  }

  aboutToAppear() {
    this.countDown()
  }

  aboutToDisappear() {
    if (this.timerId !== null) {
      clearInterval(this.timerId);
    }
  }

  // 跳转到主页
  goTo() {
    if (this.timerId !== null) {
      clearInterval(this.timerId);
    }
    this.pageInfos.replacePathByName("index", null, false)
  }

  build() {
    NavDestination() {
      // 广告图片
      Image('https://i0.hdslb.com/bfs/mall/mall/e4/c8/e4c8d4bad5606373dc261fb4fcda28c6.png')
        .width('100%')
        .height('100%')

      // 跳过按钮
      Button(`跳过 ${this.time}s`, { type: ButtonType.Capsule })
        .width(100)
        .height(50)
        .position({ top: 50, right: 20 })
        .onClick(() => this.goTo())
    }
    .title('ads')
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack
    })
  }
}