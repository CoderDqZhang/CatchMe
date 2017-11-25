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
let BaseURL = "http://39.106.137.21:8201/"

//登录api
let LoginUrl = "\(BaseURL)user/login"
//验证码
let LoginCode = "\(BaseURL)captcha"
//首页房间
let HomeRooms = "\(BaseURL)rooms"
//进入房间
let EnterRooms = "\(BaseURL)room/enter"
//退出房间
let ExitRoom = "\(BaseURL)exit"
//心跳
let Heartbeat = "\(BaseURL)heartbeat"
//停止游戏
let StopGame = "\(BaseURL)stop"
//开始游戏
let StartGame = "\(BaseURL)start"
//游戏逻辑
let MoveGame = "\(BaseURL)move"
//游戏Go
let ShootGame = "\(BaseURL)shoot"
//游戏结果
let GameStatus = "\(BaseURL)status"

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

