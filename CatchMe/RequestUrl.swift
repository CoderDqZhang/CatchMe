//
//  RequestUrl.swift
//  LiangPiao
//
//  Created by Zhang on 28/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import Foundation

//https://itunes.apple.com/us/app/liang-piao-da-mai-yong-le/id1170039060?mt=8

//测试服
//let BaseStr = "liangpiao.me/"
//正式服
let BaseURL = "\(BaseH5URL):8201/"
let BaseH5URL = "http://39.106.137.21"

//登录api
let LoginUrl = "\(BaseURL)user/login"
//验证码
let LoginCode = "\(BaseURL)captcha"
//首页房间
let HomeRooms = "\(BaseURL)rooms"
//首页Banner
let Banner = "\(BaseURL)banners"
//进入房间
let EnterRooms = "\(BaseURL)room/enter"
//退出房间
let ExitRoom = "\(BaseURL)machine/exit"
//心跳
let Heartbeat = "\(BaseURL)machine/heartbeat"
//停止游戏
let StopGame = "\(BaseURL)machine/stop"
//开始游戏
let StartGame = "\(BaseURL)machine/start"
//准备开始游戏
let GamePrepa = "\(BaseURL)machine/prepare"
//游戏逻辑
let MoveGame = "\(BaseURL)machine/move"
//游戏Go
let ShootGame = "\(BaseURL)machine/shoot"
//游戏结果
let GameStatus = "\(BaseURL)game/status"
//充值接口
let TopUp = "\(BaseURL)recharge/findRechargeRateRuleDTOList"
//获取支付宝充值信息
let AliPayInfo = "\(BaseURL)recharge/getRechargeAliPayInfo"
//问题反馈
let FeedBack = "\(BaseURL)feedback"
//兑换邀请码
let ShareCode = "\(BaseURL)shareCode"
//我抓到的娃娃
let CatchedDolls = "\(BaseURL)myCatchedDolls"
//申请发货
let ApplyShipments = "\(BaseURL)apply/shipments"
//大神榜
let TopWeekly = "\(BaseURL)top/weekly"
//全局配置
let Config = "\(BaseURL)config"
//快速进入
let QuictEnter = "\(BaseURL)room/quick/enter"
//娃娃详情
let DollsDetail = "\(BaseH5URL)/catch-me/#/toyDetail?skuSubId="
//抓到娃娃分享
let ShareCatchDoll = "\(BaseH5URL)/catch-me/#/shareLanding?gameId="
//修改用户信息
let ChangeUserInfo = "\(BaseURL)user/updateInfo"
//上传文件
let UploadImage = "\(BaseURL)uploadImage"
//添加地址
let AddressUrl = "\(BaseURL)address/add"
//获取默认地址
let QueryDefault = "\(BaseURL)address/queryDefault"

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
//获取游戏结果的接口

