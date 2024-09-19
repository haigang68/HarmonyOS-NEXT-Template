import { rvp } from '../utils/base'

interface ToolBarItem {
  defaultIcon: string | Resource
  activeIcon: string | Resource
  label: string
}

@Builder
export function indexBuilder() {
  // 这里大写 I：不能与内置属性'index'同名
  Index()
}

@Entry
@Component
struct Index {
  pageInfos: NavPathStack = new NavPathStack()
  @State activeIndex: number = 0
  @State isLandscape: boolean = false

  @Builder
  TabBuilder(item: ToolBarItem, index: number) {
    Column({ space: rvp(4) }) {
      Image(this.activeIndex === index ? item.activeIcon : item.defaultIcon)
        .width(rvp(24))
      Text(item.label)
        .fontSize(rvp(12))
        .fontColor(this.activeIndex === index ? '#000' : '#aaa')
    }
  }

  build() {
    NavDestination() {
      Tabs({ index: this.activeIndex, barPosition: BarPosition.End }) {
        TabContent() {
          Text('首页')
        }
        .tabBar(this.TabBuilder({
          label: '首页',
          defaultIcon: $r('app.media.app_icon'),
          activeIcon: $r('app.media.app_icon')
        }, 0))

        TabContent() {
          Text('看看')
        }
        .tabBar(this.TabBuilder({
          label: '看看',
          defaultIcon: $r('app.media.app_icon'),
          activeIcon: $r('app.media.app_icon')
        }, 1))

        TabContent() {
          Text('发现')
        }
        .tabBar(this.TabBuilder({
          label: '发现',
          defaultIcon: $r('app.media.app_icon'),
          activeIcon: $r('app.media.app_icon')
        }, 2))

        TabContent() {
          Text('我的')
        }
        .tabBar(this.TabBuilder({
          label: '我的',
          defaultIcon: $r('app.media.app_icon'),
          activeIcon: $r('app.media.app_icon')
        }, 3))
      }
      .barMode(BarMode.Fixed)
      .vertical(this.isLandscape)
      .onChange(index => this.activeIndex = index)
      .barHeight(this.isLandscape ? rvp(400) : rvp(50))
      .barPosition(this.isLandscape ? BarPosition.Start : BarPosition.End)
    }
    .title('index')
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack
    })
  }
}