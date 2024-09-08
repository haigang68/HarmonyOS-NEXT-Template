@Entry
@Component
struct See {
  @State message: string = '看看'

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

export default See