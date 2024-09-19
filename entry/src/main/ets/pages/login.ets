@Builder
export function loginBuilder() {
  login()
}

@Entry
@Component
struct login {
  pathStack: NavPathStack = new NavPathStack()
  @State @Watch('isLogin') account: string = '' // 账户
  @State @Watch('isLogin') password: string = '' // 密码
  @State @Watch('isLogin') confirmPassword: string = '' // 确认密码
  // @State isLogin: boolean = false //是否登陆
  @State isCodeLogin: boolean = false // 是否短信登陆
  @State isFace: boolean = true // 面部登陆
  @State isFingerprint: boolean = true // 指纹登陆
  @State isCountDown: boolean = false // 倒计时开始
  @State isRegister: boolean = false // 注册账号
  @State time: number = 60; // 倒计时时间
  private timerId: number | null = null;

  isLogin(): boolean {
    console.log('-----isLogin')
    if (this.isRegister) {
      return this.account.length > 0 && this.password.length > 0 && this.confirmPassword.length > 0
    }
    return this.account.length > 0 && this.password.length > 0
  }

  // 启动倒计时
  countDown() {
    this.timerId = setInterval(() => {
      if (this.time > 0) {
        this.time--;
      } else {
        clearInterval(this.timerId!); // 倒计时结束，清除定时器
        this.isCountDown = false;
      }
    }, 1000);
  }

  build() {
    NavDestination() {
      Column() {
        Image($r('app.media.app_icon'))
          .width(78)
          .height(78)
          .margin({ top: 80, bottom: 8 })
        Text('登陆')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#182431')
        Text('登录账号以使用更多服务')
          .fontSize(16)
          .fontColor('#99182431')
          .margin({ top: 8, bottom: 28 })

        Column() {
          TextInput({ placeholder: '账号' })
            .height(48)
            .fontSize(18)
            .maxLength(15)
            .type(InputType.USER_NAME)
            .backgroundColor(Color.White)
            .onChange((value: string) => {
              this.account = value;
              // this.isLoginAvailable();
            })

          Line().width('100%').height(1).backgroundColor('#888888')

          // 短信验证码登录
          if (this.isCodeLogin) {
            Row() {
              TextInput({ placeholder: '短信验证码' })
                .width('55%')
                .type(InputType.Number)
              Blank()
              Button(this.isCountDown ? `${this.time}s后重新获取` : `获取验证码`)
                .buttonStyle(ButtonStyleMode.NORMAL)
                .onClick(() => {
                  this.time = 10;
                  this.isCountDown = true;
                  this.countDown()
                })
            }
            .height(48)
            .width('100%')
            .margin({ top: 10, bottom: 10 })
          } else {
            TextInput({ placeholder: '密码' })
              .height(48)
              .fontSize(18)
              .maxLength(15)
              .type(InputType.Password)
              .backgroundColor(Color.White)
              .onChange((value: string) => {
                this.password = value;
                // this.isLoginAvailable();
              })
          }
          // 短信注册账号不用二次确认
          if (this.isRegister && !this.isCodeLogin) {
            TextInput({ placeholder: '确认密码' })
              .height(48)
              .fontSize(18)
              .maxLength(15)
              .type(InputType.Password)
              .backgroundColor(Color.White)
              .onChange((value: string) => {
                this.confirmPassword = value;
                // this.isLoginAvailable();
              })
          }
        }
        .borderRadius(24)
        .backgroundColor(Color.White)
        .padding({
          top: 4,
          bottom: 4,
          left: 12,
          right: 12
        })

        Row() {
          Text(!this.isCodeLogin ?
            `短信验证码${this.isRegister ? '注册' : '登陆'}` :
            `密码${this.isRegister ? '注册' : '登陆'}`
          )
            .fontColor('#0A59F7')
            .onClick(() => {
              this.isCodeLogin = !this.isCodeLogin
            })
          Text('忘记密码')
            .fontColor('#0A59F7')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ top: 12, left: 24, right: 12 })

        Button(this.isRegister ? '注册' : '登陆', { type: ButtonType.Capsule })
          .width('50%')
          .height(40)
          .fontSize(16)
          .enabled(this.isLogin())
          .fontWeight(FontWeight.Medium)
          .margin({ top: 87, bottom: 12 })
          .backgroundColor(this.isLogin() ? '#0A59F7' : '#66007DFF')
          .onClick(() => {
            // this.login();
          })
        Text(this.isRegister ? '登陆账号' : '注册账号')
          .fontSize(16)
          .fontColor('#0A59F7')
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.isRegister = !this.isRegister
            // this.pageInfos.pushPathByName('register', null);
          })

        Blank()

        if (this.isFace || this.isFingerprint) {
          Text('其他登陆方式')
            .fontSize(12)
            .fontColor('#838D97')
            .fontWeight(FontWeight.Medium)
            .margin({ top: 50, bottom: 12 })
          Row({ space: 44 }) {
            if (this.isFace) {
              Button({ type: ButtonType.Circle, stateEffect: true }) {
                Image($r('app.media.face'))
              }
              .width(48)
              .height(48)
              .backgroundColor('#F1F3F5')
              .onClick(() => {
                // UserAuthModel.getFaceAuth(this.userAuthResult);
                // UserAuthModel.start();
              })
            }

            if (this.isFingerprint) {
              Button({ type: ButtonType.Circle, stateEffect: true }) {
                Image($r('app.media.touchid'))
              }
              .width(48)
              .height(48)
              .backgroundColor('#F1F3F5')
              .onClick(() => {
                // UserAuthModel.getFingerprintAuth(this.userAuthResult);
                // UserAuthModel.start();
              })
            }
          }
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F1F3F5')
      .padding({ left: 12, right: 12, bottom: 24 })
    }
    .title('login')
    .hideTitleBar(true)
    .backgroundColor('#F1F3F5')
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}