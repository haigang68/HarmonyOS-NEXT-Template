// @Preview
@Component
struct SwiperLayout {
  @Prop bannerList: any[]

  build() {
    Swiper() {
      ForEach(this.bannerList, (item) => {
        Image(item.imageURL)
          .width('100%')
          .height(175)
      }, (item) => item.id + '')
    }
    .loop(true)
    .autoPlay(true)
    .onChange((index: number) => {
      // console.info(index.toString())
    })
  }
}

export default SwiperLayout