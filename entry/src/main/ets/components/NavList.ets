@Component
struct NavList {
  @Prop navList: any[]

  build() {
    Grid() {
      ForEach(this.navList, (nav) => {
        GridItem() {
          Column({ space: 8 }) {
            Image(nav.imageUrl)
              .width('100%')
              .height(56)
              .objectFit(ImageFit.Fill)
            Text(nav.name)
              .fontSize(12)
          }
        }.width(58)
      }, (nav) => nav.index + '')
    }
    .height(170)
    .width('100%')
    .columnsGap(33)
    .rowsGap(14)
    .margin({ top: 24 })
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .rowsTemplate('1fr 1fr')
  }
}

export default NavList