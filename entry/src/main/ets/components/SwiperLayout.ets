import { Obj } from '../models'

// @Preview
@Component
struct SwiperLayout {
  @Prop bannerList: Obj[]

  build() {
    Swiper() {
      ForEach(this.bannerList, (item: Obj) => {
        Image(item.imageURL as string)
          .width('100%')
          .height(175)
      }, (item: Record<string, string>) => item.id + '')
    }
    .loop(true)
    .autoPlay(true)
    .onChange((index: number) => {
      // console.info(index.toString())
    })
  }
}

export default SwiperLayout