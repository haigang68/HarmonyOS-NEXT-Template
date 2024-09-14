import mediaquery from '@ohos.mediaquery'
import logger from '../utils/logger'
import { rvp } from '../utils/base'
import Home from './home'
import See from './see'
import Discover from './discover'
import My from './my'

interface ToolBarItem {
  defaultIcon: string | Resource
  activeIcon: string | Resource
  label: string
}

@Entry
@Component
struct Index {
  @State activeIndex: number = 0
  @State isLandscape: boolean = false
  listener = mediaquery.matchMediaSync('(orientation: landscape)')

  aboutToAppear() {
    this.listener.on('change', (mediaQueryResult) => {
      if (mediaQueryResult.matches) {
        logger.info('-->>>> ', '横屏')
      } else {
        logger.info('-->>>> ', '竖屏')
      }
      this.isLandscape = mediaQueryResult.matches
    })
  }

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
    Tabs({ index: this.activeIndex, barPosition: BarPosition.End }) {
      TabContent() {
        Home()
      }
      .tabBar(this.TabBuilder({
        label: '首页',
        defaultIcon: $r('app.media.app_icon'),
        activeIcon: $r('app.media.app_icon')
      }, 0))

      TabContent() {
        See()
      }
      .tabBar(this.TabBuilder({
        label: '看看',
        defaultIcon: $r('app.media.app_icon'),
        activeIcon: $r('app.media.app_icon')
      }, 1))

      TabContent() {
        Discover()
      }
      .tabBar(this.TabBuilder({
        label: '发现',
        defaultIcon: $r('app.media.app_icon'),
        activeIcon: $r('app.media.app_icon')
      }, 2))

      TabContent() {
        My()
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
}