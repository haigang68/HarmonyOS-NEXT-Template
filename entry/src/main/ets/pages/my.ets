@Entry
@Component
export default struct My {
  @State message: string = '我的'

  aboutToAppear(): void {
    // 获取数据
    // this.getServiceData()
  }

  build() {
    Scroll() {
      Text(this.message)
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .align(Alignment.TopStart)

    // .backgroundImageSize(ImageSize.Auto)
  }
}