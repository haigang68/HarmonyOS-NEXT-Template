import SwiperLayout from '../components/SwiperLayout'
import SearchBar from '../components/SearchBar'
import NavList from '../components/NavList'
import { Obj } from '../models'
import logger from '../utils/logger'

@Builder
export function homeBuilder() {
  home()
}

@Entry
@Component
struct home {
  pageInfos: NavPathStack = new NavPathStack()
  @State bannerList: Obj [] = [
    {
      "id": 1,
      "name": "banner1",
      "imageURL": "https://i0.hdslb.com/bfs/mall/mall/44/9d/449d140b7ccc7c19e0d27998a5017629.png@.jpg"
    },
    {
      "id": 2,
      "name": "banner2",
      "imageURL": "https://i0.hdslb.com/bfs/mall/mall/c6/7c/c67c67d5207730fb0055473ef636a8df.png@.jpg"
    },
    {
      "id": 3,
      "name": "banner3",
      "imageURL": "https://i0.hdslb.com/bfs/mall/mall/72/e6/72e6309e4dbdfb8ed6b2257f0ad2ee33.png@.jpg"
    },
    {
      "id": 4,
      "name": "banner4",
      "imageURL": "https://i0.hdslb.com/bfs/mall/mall/93/da/93da12e8407ac295dc526ebf385905dd.png@.jpg"
    }
  ]
  @State navList: Obj[] = [
    {
      "name": "手办",
      "jumpUrl": "https://www.biligo.com/list.html?noTitleBar=1&from=category_sb&category=1_107&scene=figure",
      "jumpUrlH5": "https://www.biligo.com/list.html?noTitleBar=1&from=category_sb&category=1_107&scene=figure",
      "imageUrl": "https://i0.hdslb.com/bfs/mall/mall/1e/32/1e3279abc97c8581bdc8be16cb5589d7.png",
      "nightImageUrl": "",
      "index": 1481
    },
    {
      "name": "周边",
      "jumpUrl": "https://mall.bilibili.com/list.html?noTitleBar=1&from=category_zb&category=1_109&scene=zhoubian",
      "jumpUrlH5": "https://mall.bilibili.com/list.html?noTitleBar=1&from=category_zb&category=1_109&scene=zhoubian",
      "imageUrl": "https://i0.hdslb.com/bfs/mall/mall/59/28/5928f9dec0928bf4c92fbbb224582573.png",
      "nightImageUrl": "",
      "index": 1482
    },
    {
      "name": "漫展演出",
      "jumpUrl": "https://mall.bilibili.com/neul/index.html?page=ticket_home&noTitleBar=1&from=category_mz",
      "jumpUrlH5": "https://mall.bilibili.com/neul/index.html?page=ticket_home&noTitleBar=1&from=category_mz",
      "imageUrl": "https://i0.hdslb.com/bfs/mall/mall/ab/e9/abe96a2023b5a4773004ff8f1b9542d9.png",
      "nightImageUrl": "",
      "index": 1483
    },
    {
      "name": "今日上新",
      "jumpUrl": "https://mall.bilibili.com/newdate.html?noTitleBar=1&from=new_product&page=new",
      "jumpUrlH5": "https://mall.bilibili.com/newdate.html?noTitleBar=1&from=new_product&page=new",
      "imageUrl": "https://i0.hdslb.com/bfs/mall/mall/17/bf/17bf0936d7ba30ff968740f43e094b7e.png",
      "nightImageUrl": "",
      "index": 1487
    },
    {
      "name": "潮玩扭蛋",
      "jumpUrl": "https://www.biligo.com/list.html?noTitleBar=1&from=category_cwnd&category=2_681&scene=cwnd",
      "jumpUrlH5": "https://www.biligo.com/list.html?noTitleBar=1&from=category_cwnd&category=2_681&scene=cwnd",
      "imageUrl": "https://i0.hdslb.com/bfs/mall/mall/a5/9a/a59a438ee66f088e71d949a886cbbc7d.png",
      "nightImageUrl": "",
      "index": 1497
    },
    {
      "name": "游戏相关",
      "jumpUrl": "https://mall.bilibili.com/list.html?noTitleBar=1&category=1_716&scene=game&from=category_game",
      "jumpUrlH5": "https://mall.bilibili.com/list.html?noTitleBar=1&category=1_716&scene=game&from=category_game",
      "imageUrl": "https://i0.hdslb.com/bfs/mall/mall/18/dd/18dd66fbc02143fd504adf1408b394f7.png",
      "nightImageUrl": "",
      "index": 1485
    },
    {
      "name": "图书漫画",
      "jumpUrl": "https://mall.bilibili.com/list.html?noTitleBar=1&category=1_735&scene=book&from=category_book",
      "jumpUrlH5": "https://mall.bilibili.com/list.html?noTitleBar=1&category=1_735&scene=book&from=category_book",
      "imageUrl": "https://i0.hdslb.com/bfs/mall/mall/e4/c8/e4c8d4bad5606373dc261fb4fcda28c6.png",
      "nightImageUrl": "",
      "index": 1486
    },
    {
      "name": "全部分类",
      "jumpUrl": "https://mall.bilibili.com/category.html?noTitleBar=1&from=homepage_category",
      "jumpUrlH5": "https://mall.bilibili.com/category.html?noTitleBar=1&from=homepage_category",
      "imageUrl": "https://i0.hdslb.com/bfs/mall/mall/5e/81/5e81407b4c75a330deead13addc4ebda.png",
      "nightImageUrl": "",
      "index": 1488
    }
  ]

  build() {
    NavDestination() {
      Stack() {
        Scroll() {
          Column() {
            SwiperLayout({ bannerList: this.bannerList })
            Column() {
              NavList({ navList: this.navList })
            }
            .padding({ left: 20, right: 20 })
          }
          .justifyContent(FlexAlign.Start)
        }
        .height('100%')
        .align(Alignment.TopStart)

        SearchBar()
      }
      .height('100%')
      .alignContent(Alignment.TopStart)
    }
    .title('home')
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack
    })
  }
}