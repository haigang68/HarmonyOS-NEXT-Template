import logger from '../utils/logger';

@Builder
function DiscoverBuilder() {
  Discover()
}

@Entry
@Component
export default struct Discover {
  pageInfos: NavPathStack = new NavPathStack();
  @State message: string = '发现'

  aboutToAppear(): void {
    // 获取数据
    // this.getServiceData()
  }

  build() {
    NavDestination() {
      Scroll() {
        Text(this.message)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .align(Alignment.TopStart)

      // .backgroundImageSize(ImageSize.Auto)
    }
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack;
      logger.info("current page config info is " + JSON.stringify(context.getConfigInRouteMap()));
    })
  }
}

