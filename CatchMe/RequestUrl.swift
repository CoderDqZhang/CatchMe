//
//  RequestUrl.swift
//  LiangPiao
//
//  Created by Zhang on 28/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import Foundation

//https://itunes.apple.com/us/app/liang-piao-da-mai-yong-le/id1170039060?mt=8

// 接口地址
//DEVELOPMENT("http://test.zhuawo.com:8201"),
//ONLINE("http://backend.zhuawo.com");

// H5地址
//DEVELOPMENT("http://test.zhuawo.com/catch-me/#"),
//ONLINE("http://webfront.zhuawo.com/catch-me/#");

//测试服
//let BaseURL = "http://test.zhuawo.com:8201"
//let BaseH5URL = "http://test.zhuawo.com/catch-me/#"
//正式服
let BaseURL = "https://backend.zhuawo.com"
let BaseH5URL = "https://webfront.zhuawo.com/catch-me/#"

let ConsumptionUrl = "\(BaseH5URL)/consumption"

//登录api
let LoginUrl = "\(BaseURL)/user/login"
//登录微信
let LoginWeiChat = "\(BaseURL)/user/loginByWechat"
//验证码
let LoginCode = "\(BaseURL)/captcha"
//首页房间
let HomeRooms = "\(BaseURL)/rooms"
//首页Banner
let Banner = "\(BaseURL)/banners"
//进入房间
let EnterRooms = "\(BaseURL)/room/enter"
//退出房间
let ExitRoom = "\(BaseURL)/machine/exit"
//心跳
let Heartbeat = "\(BaseURL)/machine/heartbeat"
//内购验证
let ApplePay = "\(BaseURL)/recharge/applePay"
//停止游戏
let StopGame = "\(BaseURL)/machine/stop"
//开始游戏
let StartGame = "\(BaseURL)/machine/start"
//准备开始游戏
let GamePrepa = "\(BaseURL)/machine/prepare"
//游戏逻辑
let MoveGame = "\(BaseURL)/machine/move"
//游戏Go
let ShootGame = "\(BaseURL)/machine/shoot"
//游戏结果
let GameStatus = "\(BaseURL)/game/status"
//充值接口
let TopUp = "\(BaseURL)/recharge/findAllRechargeRateRuleDTOList"
//获取支付宝充值信息
let AliPayInfo = "\(BaseURL)/recharge/getRechargeAliPayInfo"
//获取内购订单编号接口
let InPurchase = "\(BaseURL)/recharge/getRechargePrepayOrderNo"
//微信支付充值信息
let WeChatPayUrl = "\(BaseURL)/recharge/getRechargeWxPayInfo"
//问题反馈
let FeedBack = "\(BaseURL)/feedback"
//我抓到的娃娃
let CatchedDolls = "\(BaseURL)/myCatchedDolls"
//申请发货
let ApplyShipments = "\(BaseURL)/apply/shipments"
//大神榜
let TopWeekly = "\(BaseURL)/top/weekly"
//全局配置
let Config = "\(BaseURL)/allConfig"
//快速进入
let QuictEnter = "\(BaseURL)/room/quick/enter"
//娃娃详情
let DollsDetail = "\(BaseH5URL)/toyDetail?skuSubId="
//抓到娃娃分享
let ShareCatchDoll = "\(BaseH5URL)/shareLanding?gameId="
//抓到娃娃详情
let CatchDolls = "\(BaseH5URL)/toyDetail?gameId="
//娃娃详情
let Dollsvariation = "\(BaseURL)/variation"
//邀请码
let InviteFriends = "\(BaseH5URL)/invite"
//修改用户信息
let ChangeUserInfo = "\(BaseURL)/user/updateInfo"
//上传文件
let UploadImage = "\(BaseURL)/uploadImage"
//添加地址
let AddressUrl = "\(BaseURL)/address/add"
//地址更新
let AddressUpdate = "\(BaseURL)/address/update"
//获取默认地址
let QueryDefault = "\(BaseURL)/address/queryDefault"
//获取用户信息
let UserInfoUrl = "\(BaseURL)/user/findUserDTOById"
//再玩一次
let PlayAgain = "\(BaseURL)/machine/again/start"
//退出
let LogOut = "\(BaseURL)/user/logout"
//兑换邀请码
let ShareCodeUrl = "\(BaseURL)/shareCode"
//获取用户列表
let RoomUserList = "\(BaseURL)/user/findUserDTOListByIdList"
//获取订单支付状态
let RecordByOrderNo = "\(BaseURL)/recharge/findRechargeRecordByOrderNo"
//分享接口
let Socialsharecard = "\(BaseURL)/socialsharecard/config"
//使用协议
let ProtocolUrl = "\(BaseURL)/agreement"
//发货状态控制
let TrackDollsURL = "\(BaseURL)/trackDolls"

//http://39.106.137.21:8201/machine/again/start?userId=1&machineId=1&lastGameId=357&roomId=1
//9.106.137.21:8201/rooms?offset=1&limit=20&userId=1
////首页房间李彪，offset从1开始
//http://39.106.137.21:8201/room/enter?roomId=1&userId=1
////用户进入房间
//http://39.106.137.21:8201/machine/exit?userId=1&machineId=1
////用户退出房间
//http://39.106.137.21:8201/machine/heartbeat?userId=1&machineId=1
////当前机器维护房间用户的心跳接口
//http://39.106.137.21:8201/machine/stop?userId=1&machineId=1
////用于调试，如果当前机器被其他用户占住，可以用这个接口清除
//http://39.106.137.21:8201/machine/start?userId=1&machineId=1
////开始游戏接口
//http://39.106.137.21:8201/machine/move?userId=1&machineId=1&type=4
////type 1上 2下 3左 4右
//http://39.106.137.21:8201/machine/shoot?userId=1&machineId=1
////抓取接口
//http://39.106.137.21:8201/game/status?gameId=6
//停止游戏
//http://39.106.137.21:8201/machine/stop?userId=1&machineId=1
//获取游戏结果的接口

