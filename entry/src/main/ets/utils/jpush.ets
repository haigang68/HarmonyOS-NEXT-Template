import { common, Want } from '@kit.AbilityKit';
import { AppKey } from '../config/env';
import logger from '../utils/logger';
import {
  CallBackMsg,
  JAliasMessage,
  JCmdMessage,
  JCustomMessage,
  JMessage,
  JMessageExtra,
  JMessageVoIP,
  JPushInterface,
  JTagMessage
} from '@jg/push';


// 极光推送 - 回调信息
class JPushCallBackMsg extends CallBackMsg {
  context: common.ApplicationContext

  constructor(co: common.ApplicationContext) {
    super();
    this.context = co
  }

  /**
   * 注册成功后回调rid
   * @param registrationId 注册成功后回调rid
   */
  onRegister(registrationId: string): void {
    logger.info('onRegister registrationId:', registrationId)
    this.context.eventHub.emit('jPush_event', "registrationId:" + registrationId);
  }

  /**
   * 长连接登陆 回调
   * @param isConnected true:成功，false：失败
   */
  onConnected(isConnected: boolean): void {
    logger.info('onConnected isConnected:', `${isConnected}`);
    this.context.eventHub.emit('jPush_event', "isConnected:" + isConnected);
  }

  /**
   * 操作 tag 接口回调
   * @param jTagMessage
   * export class JTagMessage {
   * sequence?: number //对应操作id，全局不要重复
   * code?: number //0成功，JTagMessage.CODE_TIME_OUT超时
   * op?: string
   * tags?: string[] //对应数据
   * curr?: number //数据当前页数，页数从1开始
   * total?: number //数据总页数
   * msg?: string
   * validated?:boolean //checkTagBindState 查询tag是否存在
   * }
   */
  onTagOperatorResult(jTagMessage: JTagMessage): void {
    logger.info('onTagOperatorResult JTagMessage:', JSON.stringify(jTagMessage));
    this.context.eventHub.emit('jPush_event', "onTagOperatorResult:" + JSON.stringify(jTagMessage));
  }

  /**
   * 操作 Alias 接口回调
   * @param jAliasMessage
   * export class JAliasMessage {
   * sequence?: number //对应操作id，全局不要重复
   * code?: number //0成功，JAliasMessage.CODE_TIME_OUT超时
   * op?: string
   * alias?: string //对应数据
   * curr?: number
   * total?: number
   * msg?: string
   * }
   */
  onAliasOperatorResult(jAliasMessage: JAliasMessage): void {
    logger.info('onAliasOperatorResult jAliasMessage:', JSON.stringify(jAliasMessage));
    this.context.eventHub.emit('jPush_event', "onAliasOperatorResult:" + JSON.stringify(jAliasMessage));
  }

  /**
   * 通知点击事件回调
   * @param jMessage
   *
   * export class JMessage {
   * msgId?: string //通知id
   * title?: string //通知标题
   * content?: string//通知内容
   * extras?: Record<string, Object>//自定义数据
   * }
   */
  onClickMessage(jMessage: JMessage) {
    logger.info('onClickMessage jMessage:', JSON.stringify(jMessage));
    // {"msgId":"18101721969430972","title":"重要推送","content":"我是推送内容我是推送内容我是推送内容我是推送内容我是推送内容","extras":{}}
    this.context.eventHub.emit('jPush_event', "onClickMessage:" + JSON.stringify(jMessage));
  }

  /**
   * 自定义信息通知回调
   *  回调一：冷启动调用sdk初始化后回调之前还没有回调的信息
   *  回调二：app存活时会直接回调信息
   *  想要有自定义信息回调，还需查看集成指南的自定义信息集成配置方式
   * @param jCustomMessage
   *
   * export class JCustomMessage {
   *  msgId?: string //通知id
   *  title?: string //通知标题
   *  content?: string //通知内容
   *  contentType?: string //通知内容类型
   *  extras?: Record<string, Object> //通知自定义键值对
   *  ttl?: number //后台下发的信息过期时间，单位秒
   *  stime?: number //后台下发时间，毫秒
   * }
   */
  onCustomMessage(jCustomMessage: JCustomMessage) {
    logger.info('onCustomMessage jCustomMessage:', JSON.stringify(jCustomMessage));
    this.context.eventHub.emit('jPush_event', "onCustomMessage:" + JSON.stringify(jCustomMessage));
  }

  /**
   * 通知扩展消息回调
   * @param jMessageExtra
   *
   * export class JMessageExtra {
   * msgId?: string //通知id
   * title?: string //通知标题
   * content?: string//通知内容
   * extras?: Record<string, Object>//自定义数据
   * extraData?: string//通知扩展消息的自定义数据
   * }
   */
  onJMessageExtra(jme: JMessageExtra) {
    logger.info('onJMessageExtra jme:', JSON.stringify(jme));
    this.context.eventHub.emit('jPush_event', "onJMessageExtra:" + JSON.stringify(jme));
  }

  /**
   * VoIP呼叫消息回调
   * export class JMessageVoIP {
   * msgId?: string //通知id
   * extraData?: string //VoIP自定义数据
   }
   * @param jmVoIP
   */
  onJMessageVoIP(jmVoIP: JMessageVoIP) {
    logger.info('JMessageVoIP jmVoIP:', JSON.stringify(jmVoIP));
    this.context.eventHub.emit('jPush_event', "JMessageVoIP:" + JSON.stringify(jmVoIP));
  }

  /**
   * export class JCmdMessage {
   * public static CMD_PUSH_STOP = 2007 //通知停止 设置回调
   * public static CMD_PUSH_RESUME = 2006 //    通知恢复 设置回调
   * cmd?: number //操作类型
   * errorCode?: number //状态码
   * msg?: string //内容
   * extra?: Record<string, Object>
   * }
   * @param cmdMessage
   */
  onCommandResult(cmdMessage: JCmdMessage) {
    logger.info('onCommandResult cmdMessage:', JSON.stringify(cmdMessage));
    this.context.eventHub.emit('jPush_event', "onCommandResult:" + JSON.stringify(cmdMessage));
  }
}

export class JPush {
  private want: Want | null = null;
  private context: Context | null = null;
  private appKey: string = AppKey;

  constructor(want: Want, context: Context) {
    this.context = context;
    this.want = want;
    this.init();
  }

  init(): void {
    if (!this.context) {
      console.error('Context is not initialized.');
      return;
    }

    // init 之前调用
    JPushInterface.setDebug(true); // 启用 debug
    JPushInterface.setAppKey(this.appKey); // 你的 appKey 在 init 之前调用
    JPushInterface.setClickWant(this.want); // 通知跳转数据接收
    // JPushInterface.setChannel("渠道名称"); // 配置下载渠道
    JPushInterface.setCallBackMsg(new JPushCallBackMsg(this.context.getApplicationContext())); // 接收回调信息
    JPushInterface.init(this.context.getApplicationContext()); // 开启推送业务功能

    // init 之后调用，否则调用无效
    // JPushInterface.setBadgeNumber(999); // 设置角标
    const rid = JPushInterface.getRegistrationId(); // 返回注册的 rid
    console.log(`Registration ID: ${rid}`);
  }
}
