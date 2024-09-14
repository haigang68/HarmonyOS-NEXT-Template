import { Obj } from '../models'

@Component
struct NavList {
  @Prop navList: Obj[]

  build() {
    Grid() {
      ForEach(this.navList, (nav: Obj) => {
        GridItem() {
          Column({ space: 8 }) {
            Image(nav.imageUrl as string)
              .width('100%')
              .height(56)
              .objectFit(ImageFit.Fill)
            Text(nav.name as string)
              .fontSize(12)
          }
        }.width(58)
      }, (nav: Obj) => nav.index + '')
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