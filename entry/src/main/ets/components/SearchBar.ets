@Preview
@Component
struct SearchBar {
  build() {
    Row() {
      Text("北京")
        .width(50)
        .fontSize(14)
        .fontColor(Color.Black)
      Stack() {
        TextInput({ placeholder: '公司/地铁/小区，马上搜索' })
          .width('70%')
      }

      Image($r('app.media.icon'))
        .width(20)
        .height(20)
    }
  }
}

export default SearchBar