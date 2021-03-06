//
//  CacheMeViewModel.swift
//  CatchMe
//
//  Created by Zhang on 20/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import AVFoundation

enum CameraType {
    case Font
    case Back
}

class CacheMeViewModel: BaseViewModel {

    var cacheMeController:CacheMeViewController!
    var callID:UInt64!
    var model:Labels!
    var catchMeModel:CatchMeModel!
    var headerModel:HeartModel!
    var gameStatus:GameStatusModel!
    var prepareModel:PrepareGameModel!
    var time:Timer!
    var timeHeader:Timer!
    var timeCount:Int = 0
    
    var playUrl:String!
    var currentUserId = 0
    var cameraType = CameraType.Font
    var option = NIMNetCallOption.init()
    
    var olineUserList:[BasicUserDTO]!
    
    var numberOlineUser:Int = 0
    
    var currentUser:CurrentPlayerDTO!
    
    var getGameStatus:Bool = false
    var playGameGoStatus:Bool = false
    var isPlayAgain:Bool = true
    //麦克风权限
    var playGame:Bool = false
    
    var shareCodelModel:SessionShareModel!
    
    var canTouch:Bool = true
    
    //网易出现1005出现重现连接2次
    var numberConnect:Int = 0
    
    override init() {
        super.init()
        NIMAVChatSDK.shared().netCallManager.add(self)
        NotificationCenter.default.addObserver(self, selector: #selector(CacheMeViewModel.musicPlayAgain), name: NSNotification.Name(rawValue: NotificationPlayMusic), object: nil)
    }
    
    @objc func musicPlayAgain(){
        if ((UserDefaultsGetSynchronize(MUISCCOGIF) as! String == "true") && (KWINDOWDS().rootViewController as! MainTabBarViewController).currentViewController!.isKind(of: HomeViewController.self)){
            if !AudioPlayManager.shareInstance.isPlaying() {
                AudioPlayManager.shareInstance.playBgMusic(name: "\(ConfigModel.shanreInstance.musicName!)")
            }
        }
    }
    
    deinit {
        if time != nil {
            time.invalidate()
        }
        if timeHeader != nil {
            timeHeader.invalidate()
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: NotificationPlayMusic), object: nil)
        NIMAVChatSDK.shared().netCallManager.remove(self)
    }
    
    func getAVAuthorizationStatus(){
        let authorizate = AVCaptureDevice.authorizationStatus(for: .audio)
        switch authorizate {
        case .denied:
            UIAlertController.shwoAlertControl(KWINDOWDS().currentViewController()!, style: .alert, title: "请允许使用麦克风", message: "游戏需要麦克风权限", cancel: "取消", doneTitle: "确定", cancelAction: {

            }, doneAction: {
                SHARE_APPLICATION.openURL(URL.init(string: UIApplicationOpenSettingsURLString)!)
            })
            break;
        case .authorized:
            self.playGame = true
        case .notDetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { (ret) in
                self.playGame = ret
            }
        default:
            break;
        }
        
    }
    
    //退出房间后调用拉流停止
    func exitRoom(){
        if !self.cacheMeController.remoteGLView.isHidden {
            self.handUpConnect()
        }
        if cacheMeController.liveplayerA.isPlaying() {
            cacheMeController.liveplayerA.shutdown()
        }
        if cacheMeController.liveplayerB.isPlaying() {
            cacheMeController.liveplayerB.shutdown()
        }
        
        if self.timeHeader != nil {
            self.timeHeader.invalidate()
        }
        if self.time != nil {
            self.time.invalidate()
        }
        if UserDefaultsGetSynchronize(MUISCCOGIF) as! String == "true" {
            AudioPlayManager.shareInstance.pause()
        }
    }
    
    @objc func otherModel(){
        
    }
    
    //断开点对点连接后调用
    func prepedPlay(){
        //拉流界面自动断开处理
        if self.cacheMeController.liveplayerView != nil {
            self.cacheMeController.liveplayerView.isHidden = false
            if (self.cacheMeController.liveplayerA.isPlaying() && !self.cacheMeController.liveplayerA.view.isHidden) || (self.cacheMeController.liveplayerB.isPlaying() && !self.cacheMeController.liveplayerB.view.isHidden) {
                cacheMeController.localPreView.isHidden = true
            }else{
                cacheMeController.localPreView.isHidden = false
            }
        }else{
            self.setUpStreamData()
        }
        
        if cacheMeController.bottomToolsView != nil {
            cacheMeController.bottomToolsView.isHidden = false
        }
        
        if cacheMeController.gameToolsView != nil {
            cacheMeController.gameToolsView.isHidden = true
            cacheMeController.cacheMePlayUserView.countDownLabel.isHidden = true
        }
        
        if cacheMeController.remoteGLView != nil {
            cacheMeController.remoteGLView.isHidden = true
            self.cacheMeController.view.sendSubview(toBack: cacheMeController.remoteGLView)
        }
        
        if self.cacheMeController.cacheMePlayUserView != nil {
            self.cacheMeController.view.bringSubview(toFront: self.cacheMeController.cacheMePlayUserView)
        }
        
        if self.cacheMeController.switchCamera != nil {
            self.cacheMeController.view.bringSubview(toFront: self.cacheMeController.switchCamera)
        }
        //2.0
        if self.cacheMeController.showDollsDetail != nil {
            self.cacheMeController.view.bringSubview(toFront: self.cacheMeController.showDollsDetail)
        }
    }

    //开始游戏成功
    func showGameView(){
        if self.prepareModel != nil {
            self.cacheMeController.cacheMePlayUserView.setCountLabelText(count: self.prepareModel.maxTime)
        }
        if cacheMeController.localPreView != nil {
            cacheMeController.localPreView.isHidden = true
            cacheMeController.liveplayerView.isHidden = true
            self.cacheMeController.view.sendSubview(toBack: cacheMeController.liveplayerView)
        }
        
        if cacheMeController.bottomToolsView != nil {
            cacheMeController.bottomToolsView.isHidden = true
        }
        
        if cacheMeController.remoteGLView != nil {
            cacheMeController.remoteGLView.isHidden = false
            self.cacheMeController.view.bringSubview(toFront: cacheMeController.remoteGLView)
        }
        
        if self.cacheMeController.cacheMePlayUserView != nil {
            self.cacheMeController.view.bringSubview(toFront: self.cacheMeController.cacheMePlayUserView)
        }
        
        if self.cacheMeController.switchCamera != nil {
            self.cacheMeController.view.bringSubview(toFront: self.cacheMeController.switchCamera)
        }
        //2.0
        if self.cacheMeController.showDollsDetail != nil {
            self.cacheMeController.view.bringSubview(toFront: self.cacheMeController.showDollsDetail)
        }

        if cacheMeController.gameToolsView != nil {
            cacheMeController.cacheMePlayUserView.countDownLabel.isHidden = false
            cacheMeController.gameToolsView.isHidden = false
            self.cacheMeController.view.bringSubview(toFront: self.cacheMeController.gameToolsView)
        }
    }
    
    func setUpStreamData(){
        self.cacheMeController.setUpPlayer(url: [self.catchMeModel.machineDTO.audiencePullAddressA,self.catchMeModel.machineDTO.audiencePullAddressB])

    }
    
    func handUpConnect(){
        //避免网易SDK关闭音乐跟自己本地播放音乐冲突
        if AudioPlayManager.shareInstance.audioPlayer != nil {
            AudioPlayManager.shareInstance.audioPlayer.stop()
            AudioPlayManager.shareInstance.audioPlayer = nil
        }
        
        if self.callID != nil {
            self.setUpStreamData()
            NIMAVChatSDK.shared().netCallManager.hangup(self.callID)
        }
        self.prepedPlay()
        if UserDefaultsGetSynchronize(MUISCCOGIF) as! String == "true" {
            AudioPlayManager.shareInstance.playBgMusic(name: "\(ConfigModel.shanreInstance.musicName!)")
        }
        self.cameraType = .Font
    }
    
    //建立点对点连接
    func makeGameToUser(){
        //添加点对点连接的加载页面
        if self.cacheMeController.localPreView != nil {
            self.cacheMeController.localPreView.isHidden = false
        }
        self.fillUserSetting(option)
        if AudioPlayManager.shareInstance.audioPlayer != nil {
            AudioPlayManager.shareInstance.audioPlayer.stop()
            AudioPlayManager.shareInstance.audioPlayer = nil
        }
        NIMAVChatSDK.shared().netCallManager.start([self.catchMeModel.machineDTO.playerAccountId], type: .video, option: self.option) { (error, callId) in
            if error == nil {
                print("建立点对点成功")

            }
        }
    }
    
    
    //配置属性
    func fillUserSetting(_ options:NIMNetCallOption) {
        options.preferredVideoEncoder = NIMNetCallVideoCodec.default
        options.preferredVideoDecoder = NIMNetCallVideoCodec.default
    }
    //配置属性
    func fillVideoCaptureSetting(_ param:NIMNetCallVideoCaptureParam) {
        param.preferredVideoQuality = .qualityMedium
        param.format = NIMNetCallVideoCaptureFormat.format420v
        param.videoCrop = NIMNetCallVideoCrop.cropNoCrop
    }
    
    //改变摄像头
    func changeCamera(){
        if !cacheMeController.liveplayerView.isHidden {
            //切换拉流地址
            if self.cacheMeController.liveplayerA.view.isHidden {
                self.cacheMeController.liveplayerA.view.isHidden = false
                self.cacheMeController.liveplayerB.view.isHidden = true
                self.cacheMeController.changeCameraType(type: .Font)
            }else{
                self.cacheMeController.liveplayerA.view.isHidden = true
                self.cacheMeController.liveplayerB.view.isHidden = false
                self.cacheMeController.changeCameraType(type: .Back)
            }
        }else{
            if canTouch {
                canTouch = false
                _ = Timer.after(2, {
                    self.canTouch = true
                })
                if self.cameraType == .Font {
                    self.cameraType = .Back
                }else{
                    self.cameraType = .Font
                }
                NIMAVChatSDK.shared().netCallManager.control(self.callID, type: NIMNetCallControlType.noCamera)
            }
        }
    }
    //MARK: Networking
    //进入房间
    func requestEntRooms(){
        let parameters = ["roomId":model.id,"userId":UserInfoModel.shareInstance().idField] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(EnterRooms, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.catchMeModel = CatchMeModel.init(fromDictionary: resultDic.value as! NSDictionary)
                if self.cacheMeController.bottomToolsView != nil {
                    self.cacheMeController.bottomToolsView.changePlayType(type: self.catchMeModel.currentPlayStatus == 1 ? .canNotPlay : .canPlay)
                }
                //查看娃娃详情界面
                self.reuqestDollsDetail()
                //设置拉流地址
                self.setUpStreamData()
                self.cacheMeController.setUpShowDollsDetail(model:self.catchMeModel)
                self.playUrl = self.catchMeModel.machineDTO.audiencePullAddressA
                self.setUpRoomPalyUsers(currentUser: self.catchMeModel.currentPlayerDTO)
                self.getRoomUserListInfo()
                self.cacheMeController.bottomToolsView.changePlayGameCoins(str: "\(self.catchMeModel.price!)")
                //心跳接口
                self.timeHeader = Timer.every(10, {
                    self.requestHeader()
                })
            }
        }
    }
    
    //快速进入房间
    func requestQuickEntRooms(){
        let parameters = ["userId":UserInfoModel.shareInstance().idField] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(QuictEnter, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.catchMeModel = CatchMeModel.init(fromDictionary: resultDic.value as! NSDictionary)
                //查看娃娃详情界面
                self.reuqestDollsDetail()
                self.setUpStreamData()
                self.cacheMeController.setUpShowDollsDetail(model:self.catchMeModel)
                if KWINDOWDS().viewWithTag(10000) != nil {
                    KWINDOWDS().viewWithTag(10000)?.removeFromSuperview()
                }
                if self.cacheMeController.bottomToolsView != nil {
                    self.cacheMeController.bottomToolsView.changePlayType(type: self.catchMeModel.currentPlayStatus == 1 ? .canNotPlay : .canPlay)
                }
                self.playUrl = self.catchMeModel.machineDTO.audiencePullAddressA
                self.setUpRoomPalyUsers(currentUser: self.catchMeModel.currentPlayerDTO)
                self.getRoomUserListInfo()
                self.cacheMeController.bottomToolsView.changePlayGameCoins(str: "\(self.catchMeModel.price!)")
                //心跳接口
                self.timeHeader = Timer.every(3, {
                    self.requestHeader()
                })
            }
        }
    }
    
    //退出房间
    func requestExitRooms(){
        if catchMeModel != nil {
            let parameters = ["machineId":catchMeModel.machineDTO.id == nil ? "" : catchMeModel.machineDTO.id,"userId":UserInfoModel.shareInstance().idField] as [String : Any]
            BaseNetWorke.sharedInstance.getUrlWithString(ExitRoom, parameters: parameters as AnyObject).observe { (resultDic) in
                if !resultDic.isCompleted {
                    //执行断开点对点连接
                    self.exitRoom()
                }
            }
        }
    }
    
    //心跳
    func requestHeader(){
        let parameters = ["machineId":catchMeModel.machineDTO.id,"userId":UserInfoModel.shareInstance().idField] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(Heartbeat, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if resultDic.error != nil {
                    return
                }
                if resultDic.value != nil && resultDic.value is NSDictionary {
                    self.headerModel = HeartModel.init(fromDictionary: resultDic.value as! NSDictionary)
                    self.catchMeModel.currentPlayStatus = self.headerModel.currentPlayStatus
                    self.cacheMeController.bottomToolsView.changePlayType(type: self.headerModel.currentPlayStatus == 1 ? .canNotPlay : .canPlay)
                    if self.headerModel.currentPlayerDTO is NSDictionary {
                        self.setUpRoomPalyUsers(currentUser: self.headerModel.currentPlayerDTO)
                    }
                    self.getRoomUserListInfo()
                }
                
            }
        }
    }
    
    //查看排队情况
    func gameStart(){
        if playGame {
            LoginViewModel.shareInstance.getUserInfoCoins(uerInfoUpdateClouse: { (userInfo) in
                //设置账户余额
                self.cacheMeController.cacheMeTopView.setUpCoinsData()
                
                if userInfo.coinAmount.int! < self.catchMeModel.price {
                    KWINDOWDS().addSubview(GloableAlertView.init(title: "余额不足，主人请先充值\n赶紧回来抓我哟", desc: nil, btnTop: "去充值", btnBottom: "取消", image: UIImage.init(named: "pic_fail_1")!, topImageUrl: nil, type: GloableAlertViewType.topupfail, clickClouse: { (tag) in
                        if tag == 100 {
                            //正价代码
                            self.gotoTopUpVC()
                        }
                    }))
                    //4 xia
                }else{
                    if NIMSDK.shared().loginManager.isLogined() {
                        if self.catchMeModel.currentPlayStatus == 0 {
                            let parameters = ["machineId":self.catchMeModel.machineDTO.id,"userId":UserInfoModel.shareInstance().idField,"roomId":self.catchMeModel.id] as [String : Any]
                            BaseNetWorke.sharedInstance.getUrlWithString(GamePrepa, parameters: parameters as AnyObject).observe { (resultDic) in
                                if !resultDic.isCompleted {
                                    //排队成功调用
                                    if resultDic.error != nil {
                                        return
                                    }
                                    self.prepareModel = PrepareGameModel.init(fromDictionary: resultDic.value as! NSDictionary)
                                    if self.prepareModel != nil && resultDic.value != nil{
                                        //建立点对点连接
                                        self.getGameStatus = false
                                        self.playGameGoStatus = false
                                        LoginViewModel.shareInstance.getUserInfoCoins(uerInfoUpdateClouse: { (userInfo) in
                                        })
                                        self.makeGameToUser()
                                    }
                                }
                            }
                        }else{
                            _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "当前机器有人在使用", autoHidder: true)
                        }
                    }else{
                        _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "用户未登录", autoHidder: true)
                        NeteaseManager.shareInstance.setAutoLogin()
                    }
                }
            })
        }else{
            UIAlertController.shwoAlertControl(self.cacheMeController!, style: .alert, title: "请允许使用麦克风", message: "游戏需要麦克风权限", cancel: "取消", doneTitle: "确定", cancelAction: {
                
            }, doneAction: {
                SHARE_APPLICATION.openURL(URL.init(string: UIApplicationOpenSettingsURLString)!)
            })
        }
    }
    
    //开始游戏
    func gameStarts(){
        let parameters = ["machineId":catchMeModel.machineDTO.id,"userId":UserInfoModel.shareInstance().idField] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(StartGame, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                //点对点连接成功&&开始游戏成功后创建游戏界面
                if resultDic.error != nil {
                    return
                }
                self.getUserInfo(currentUser: CurrentPlayerDTO.init(fromDictionary: ["photo":UserInfoModel.shareInstance().photo == nil ? "" : UserInfoModel.shareInstance().photo, "userName":UserInfoModel.shareInstance().userName]))
                self.showGameView()
                self.cacheMeController.setUpreadyGogameTipView()
            }
        }
    }
    //1上，2下，3左，4右Font
    //1右  2左，3上  4下Back
    //点击上下左右
    func playGameLogic(tag:GameToolsLogic){
        var temp = tag
        if self.cameraType == .Back {
            if tag == .moveTop {
                temp = .moveLeft
            }else if tag == .moveDown {
                temp = .moveRight
            }else if tag == .moveLeft {
                temp = .moveDown
            }else if tag == .moveRight{
                temp = .moveTop
            }
        }
        let parameters = ["machineId":catchMeModel.machineDTO.id,"userId":UserInfoModel.shareInstance().idField,"type":temp.rawValue] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(MoveGame, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                
            }
        }
    }
    
    //抓取
    func playGameGo(){
        self.playGameGoStatus = true
        let parameters = ["machineId":self.catchMeModel.machineDTO.id,"userId":UserInfoModel.shareInstance().idField] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(ShootGame, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.cacheMeController.cacheMePlayUserView.setCountLabelText(count: -1)
                self.cacheMeController.gameToolsView.setGameToolsType(type: .isWaitGameStatus)
            }
        }
        //测试
        if time == nil {
            time = Timer.every(1, {
                if !self.getGameStatus && self.playGameGoStatus {
                    self.timeCount = self.timeCount + 1
                    self.getGameStaus()
                }
            })
        }
    }
    
    //获取游戏结果
    func getGameStaus(){
        let parameters = ["gameId":self.prepareModel.gameId] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(GameStatus, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
               //抓取成功调用
                self.gameStatus = GameStatusModel.init(fromDictionary: resultDic.value as! NSDictionary)
                if self.gameStatus.status == 3 || self.gameStatus.status == 4 || self.timeCount > 30{
                    self.timeCount = 0
                    self.cacheMeController.gameToolsView.setGameToolsType(type: .isPlaying)
                    self.shootFail()
                    self.getGameStatus = true
                    self.playGameGoStatus = false
                }else if self.gameStatus.status == 2 {
                    self.cacheMeController.gameToolsView.setGameToolsType(type: .isPlaying)
                    self.getGameStatus = true
                    self.playGameGoStatus = false
                    self.shootSuccess()
                }else{
                    print(self.gameStatus.status)
                }
            }
        }
    }
    
    func stopGame(){
        let parameters = ["userId":UserInfoModel.shareInstance().idField,"machineId":self.catchMeModel.machineDTO.id] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(StopGame, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.getUserInfo(currentUser: nil)
                self.cacheMeController.bottomToolsView.changePlayType(type: .canPlay)
            }
        }
    }
    
    //在玩一次
    func playAgain(){
        if UserInfoModel.shareInstance().coinAmount.int! < self.catchMeModel.price {
            //余额不足断开端对点连接
            self.stopGame()
            self.handUpConnect()
            KWINDOWDS().addSubview(GloableAlertView.init(title: "余额不足，主人请先充值\n赶紧回来抓我哟", desc: nil, btnTop: "去充值", btnBottom: "取消", image: UIImage.init(named: "pic_fail_1")!, topImageUrl: nil, type: GloableAlertViewType.topupfail, clickClouse: { (tag) in
                if tag == 100 {
                    //增加代码
                    self.gotoTopUpVC()
                }
            }))
            //4 xia
        }else{
            let parameters = ["lastGameId":self.prepareModel.gameId,"userId":UserInfoModel.shareInstance().idField,"roomId":self.catchMeModel.id,"machineId":self.catchMeModel.machineDTO.id] as [String : Any]
            BaseNetWorke.sharedInstance.getUrlWithString(PlayAgain, parameters: parameters as AnyObject).observe { (resultDic) in
                if !resultDic.isCompleted {
                    //抓取成功调用
                    if resultDic.error != nil {
                        return
                    }
                    let model = PlayGameAgain.init(fromDictionary: resultDic.value as! NSDictionary)
                    self.prepareModel.gameId = model.gameId
                    if self.prepareModel != nil {
                       self.cacheMeController.setUpreadyGogameTipView()
                       self.getGameStatus = false
                       self.playGameGoStatus = false
                        self.cacheMeController.cacheMePlayUserView.setCountLabelText(count: self.prepareModel.maxTime)
                    }
                }
            }
        }
    }
    
    func reuqestDollsDetail(){
        BaseNetWorke.sharedInstance.getUrlWithString("\(Dollsvariation)/\(self.catchMeModel.skuSubId!)", parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                if resultDic.value != nil {
                    let model = DollsDetailModel.init(fromDictionary: resultDic.value as! NSDictionary)
                    self.cacheMeController.setUpDollDetailView(model:model)
                }
                
            }
        }
    }
    
    func setUpRoomPalyUsers(currentUser:CurrentPlayerDTO?){
        //获取当前真正玩的用户
        self.getUserInfo(currentUser: currentUser)
        //获取用户列表
    }
    
    func getUserInfo(currentUser:CurrentPlayerDTO?){
        if self.currentUser == nil {
            self.currentUser = currentUser
        }else{
            if currentUser == nil {
                self.currentUser = currentUser
            }else{
                if self.currentUser.id == currentUser?.id {
                    return
                }else{
                    self.currentUser = currentUser
                }
            }
        }

        if self.cacheMeController.cacheMePlayUserView != nil {
            self.cacheMeController.view.bringSubview(toFront: self.cacheMeController.cacheMePlayUserView)
            self.cacheMeController.cacheMePlayUserView.setData(model: self.currentUser)
        }
    }
    
    func getRoomUserListInfo(){
        if self.catchMeModel != nil {
            self.olineUserList = self.catchMeModel.onlineUserDTOs
        }else if self.headerModel != nil {
            self.olineUserList = self.headerModel.userDTOs
        }
        if self.olineUserList != nil {
            self.cacheMeController.cacheMeTopView.setUpData(models: self.olineUserList, count: "\(self.olineUserList.count)")
        }
    }
    
    func gotoTopUpVC(){
        NavigationPushView(self.cacheMeController, toConroller: TopUpViewController())
    }
    
    func shootSuccess(){
        self.getShareCodeInfo(gameId: "\(self.prepareModel.gameId!)")
        KWINDOWDS().addSubview(GloableAlertView.init(title: "好棒，活捉一只娃娃", desc: nil, btnTop: "再试一次5s", btnBottom: "炫耀一下", image: UIImage.init(named: "pic_success")!, topImageUrl: nil, type: GloableAlertViewType.success, clickClouse: { (tag) in
            if tag == 100 {
                self.playAgain()
            }else if tag == 200{
                //炫耀一下
                self.stopGame()
                self.handUpConnect()
                //
                self.showShareView()
                //成功5秒倒计时连接
            }else if tag == 1000 {
                self.stopGame()
                self.handUpConnect()
            }
        }))
    }
    
    func shootFail(){
        //抓取失败
        KWINDOWDS().addSubview(GloableAlertView.init(title: "再来一次, 带我回家吧", desc: nil, btnTop: "再试一次5s", btnBottom: "无力再试", image: UIImage.init(named: "pic_fail")!, topImageUrl: nil, type: GloableAlertViewType.catchfail, clickClouse: { (tag) in
            if tag == 100 {
                self.playAgain()
            }else if tag == 200{
                //断开点对点连接
                self.stopGame()
                self.handUpConnect()
            }
        }))
    }
    
    func showShareView(){
        if self.shareCodelModel != nil {
            KWINDOWDS().addSubview(GloabelShareAndConnectUs.init(type: GloabelShareAndConnectUsType.share, title: "成功活抓！快邀请朋友们来围观吧~", clickClouse: { (type) in
                if UserDefaultsGetSynchronize(MUISCCOGIF) as! String == "true" {
                    AudioPlayManager.shareInstance.stop()
                }
                switch type {
                case .QQChat:
                    ShareTools.shareInstance.shareQQSessionWebUrl(self.shareCodelModel.title, webTitle: self.shareCodelModel.descriptionField, imageUrl: self.shareCodelModel.thumbnailAddress, webDescription: "", webUrl: self.shareCodelModel.url)
                case .weChatChat:
                    ShareTools.shareInstance.shareWeChatSession(self.shareCodelModel.title, description: self.shareCodelModel.descriptionField, image: UIImage.getFromURL(self.shareCodelModel.thumbnailAddress), url: self.shareCodelModel.url)
                case .weChatSession:
                    ShareTools.shareInstance.shareWeChatTimeLine(self.shareCodelModel.title, description: self.shareCodelModel.descriptionField, image: UIImage.getFromURL(self.shareCodelModel.thumbnailAddress), url: self.shareCodelModel.url)
                default:
                    break
                }
            }))
        }
    }
    
    func getShareCodeInfo(gameId:String){
        let parameters = ["type":"1","gameId":gameId]
        BaseNetWorke.sharedInstance.getUrlWithString(Socialsharecard, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.shareCodelModel = SessionShareModel.init(fromDictionary: resultDic.value as! NSDictionary)
            }
        }
    }
}

extension CacheMeViewModel : NIMNetCallManagerDelegate {
    //本地摄像头
    func onLocalDisplayviewReady(_ displayView: UIView) {
//        let  = displayView
//        displayView.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT)
//        displayView.backgroundColor = UIColor.blue
//        cacheMeController.localPreView.addSubview(displayView)
    }
    
//    func onRemoteImageReady(_ image: CGImage) {
////        if cacheMeController != nil {
////            if cacheMeController.remoteGLView == nil {
////                cacheMeController.initRemoteGlView()
////            }
////            self.cacheMeController.remoteGLView.image = UIImage.init(cgImage: image)
////        }
//    }
    
    func onMyVolumeUpdate(_ volume: UInt16) {
        
    }
    
    func onAudioMixTaskCompleted() {
        
    }
    
    //YUVdata数据直接渲染
    func onRemoteYUVReady(_ yuvData: Data, width: UInt, height: UInt, from user: String) {
        if cacheMeController.remoteGLView == nil {
            cacheMeController.initRemoteGlView()
        }
//        cacheMeController.remoteGLView.imageView.image = UIImage.init(fromYData: yuvData, width: uint(width), height: uint(height))
        DispatchQueue.main.async(execute: {
            self.cacheMeController.remoteGLView.render(yuvData, width: width, height: height)
        })
    }
    
    func onControl(_ callID: UInt64, from user: String, type control: NIMNetCallControlType) {
        
    }
    
    func onCallEstablished(_ callID: UInt64) {
        print("连接成功\(callID)")
        self.callID = callID
//        self.gameStarts()
    }
    
    func onCallDisconnected(_ callID: UInt64, withError error: Error?) {
        if error != nil {
            if numberConnect < 2 {
                numberConnect = numberConnect + 1
                self.makeGameToUser()
            }
        }
        self.prepedPlay()
        
    }
    
    func onNetStatus(_ status: NIMNetCallNetStatus, user: String) {
        
    }
    
    func onRecordStarted(_ callID: UInt64, fileURL: URL, uid userId: String) {
        
    }
    
    func onRecordError(_ error: Error, callID: UInt64, uid userId: String) {
        
    }
    
    func onRecordStopped(_ callID: UInt64, fileURL: URL, uid userId: String) {
        
    }
    
    func onResponsed(byOther callID: UInt64, accepted: Bool) {
        
    }
    
    func onResponse(_ callID: UInt64, from callee: String, accepted: Bool) {
        if !accepted {
            if numberConnect == 0 {
                self.makeGameToUser()
            }
        }else{
            NIMAVChatSDK.shared().netCallManager.setMute(true)
            self.gameStarts()
            if UserDefaultsGetSynchronize(MUISCCOGIF) as! String == "true" {
                AudioPlayManager.shareInstance.playBgMusic(name: "\(ConfigModel.shanreInstance.musicName!)")
            }
            numberConnect = 0
        }
    }

    func onHangup(_ callID: UInt64, by user: String) {
        self.callID = callID
        self.handUpConnect()
    }
}

