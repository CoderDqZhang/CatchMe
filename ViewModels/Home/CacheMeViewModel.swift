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
    
    var currentUser:BasicUserDTO!
    
    var playGame:Bool = false
    
    override init() {
        super.init()
        NIMAVChatSDK.shared().netCallManager.add(self)
        self.getAVAuthorizationStatus()
    }
    
    deinit {
        if time != nil {
            time.invalidate()
        }
        if timeHeader != nil {
            timeHeader.invalidate()
        }
        NIMAVChatSDK.shared().netCallManager.remove(self)
    }
    
    func getAVAuthorizationStatus(){
        let authorizate = AVCaptureDevice.authorizationStatus(for: .audio)
        switch authorizate {
        case .denied:
            UIAlertController.shwoAlertControl(self.cacheMeController!, style: .alert, title: "请允许使用麦克风", message: "游戏需要麦克风权限", cancel: "取消", doneTitle: "确定", cancelAction: {
                
            }, doneAction: {
                SHARE_APPLICATION.openURL(URL.init(string: UIApplicationOpenSettingsURLString)!)
            })
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
        self.handUpConnect()
        if cacheMeController.liveplayer.isPlaying() {
            cacheMeController.liveplayer.shutdown()
        }
        if self.timeHeader != nil {
            self.timeHeader.invalidate()
        }
        if self.time != nil {
            self.time.invalidate()
        }
    }
    
    //断开点对点连接后调用
    func prepedPlay(){
        //拉流界面自动断开处理
        if cacheMeController.liveplayer.isPlaying() {
            cacheMeController.liveplayer.view.isHidden = false
            cacheMeController.localPreView.isHidden = false
        }else{
            self.cacheMeController.setUpPlayer(url: self.catchMeModel.machineDTO.audiencePullAddressA)
        }
        
        if cacheMeController.bottomToolsView != nil {
            cacheMeController.bottomToolsView.isHidden = false
        }
        
        if cacheMeController.gameToolsView != nil {
            cacheMeController.gameToolsView.isHidden = true
        }
        if cacheMeController.remoteGLView != nil {
            cacheMeController.remoteGLView.isHidden = true
        }
    }

    //开始游戏成功
    func showGameView(){
        if cacheMeController.localPreView != nil {
            cacheMeController.localPreView.isHidden = true
            cacheMeController.liveplayer.view.isHidden = true
        }
        
        if cacheMeController.bottomToolsView != nil {
            cacheMeController.bottomToolsView.isHidden = true
        }
        if cacheMeController.gameToolsView != nil {
            cacheMeController.gameToolsView.isHidden = false
        }
        if cacheMeController.remoteGLView != nil {
            cacheMeController.remoteGLView.isHidden = false
        }
    }
    
    func handUpConnect(){
        if self.cacheMeController.localPreView != nil {
            self.cacheMeController.localPreView.isHidden = false
        }
        if self.callID != nil {
            self.cacheMeController.setUpPlayer(url: self.catchMeModel.machineDTO.audiencePullAddressA)
            NIMAVChatSDK.shared().netCallManager.hangup(self.callID)
        }else{
            //断开点对点连接失败调用
            self.prepedPlay()
        }
    }
    
    //建立点对点连接
    func makeGameToUser(){
        //添加点对点连接的加载页面
        if self.cacheMeController.localPreView != nil {
            self.cacheMeController.localPreView.isHidden = false
        }
        self.fillUserSetting(option)
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
        param.preferredVideoQuality = .qualityLow
        param.format = NIMNetCallVideoCaptureFormat.format420v
        param.videoCrop = NIMNetCallVideoCrop.crop1x1
    }
    
    //改变摄像头
    func changeCamera(){
        if !cacheMeController.liveplayer.view.isHidden {
            //切换拉流地址
            let url = playUrl == self.catchMeModel.machineDTO.audiencePullAddressA ? self.catchMeModel.machineDTO.audiencePullAddressB : self.catchMeModel.machineDTO.audiencePullAddressA
            playUrl = url
            self.cacheMeController.liveplayer.switchContentUrl(URL.init(string: playUrl))
        }else{
            if self.cameraType == .Font {
                self.cameraType = .Back
            }else{
                self.cameraType = .Font
                
            }
            
            NIMAVChatSDK.shared().netCallManager.control(self.callID, type: NIMNetCallControlType.noCamera)
        }
    }
    //MARK: Networking
    //进入房间
    func requestEntRooms(){
        let parameters = ["roomId":model.id,"userId":UserInfoModel.shareInstance().idField] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(EnterRooms, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.catchMeModel = CatchMeModel.init(fromDictionary: resultDic.value as! NSDictionary)
                //设置拉流地址
                self.cacheMeController.setUpPlayer(url: self.catchMeModel.machineDTO.audiencePullAddressA)
                self.playUrl = self.catchMeModel.machineDTO.audiencePullAddressA
                self.getUserInfo(currentUser: self.catchMeModel.currentPlayerDTO)
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
                self.cacheMeController.setUpPlayer(url: self.catchMeModel.machineDTO.audiencePullAddressA)
                self.playUrl = self.catchMeModel.machineDTO.audiencePullAddressA
                self.getUserInfo(currentUser: self.catchMeModel.currentPlayerDTO)
                //心跳接口
                self.timeHeader = Timer.every(10, {
                    self.requestHeader()
                })
            }
        }
    }
    
    //退出房间
    func requestExitRooms(){
        let parameters = ["machineId":catchMeModel.machineDTO.id == nil ? "" : catchMeModel.machineDTO.id,"userId":UserInfoModel.shareInstance().idField] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(ExitRoom, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                //执行断开点对点连接
                self.exitRoom()
            }
        }
    }
    
    //心跳
    func requestHeader(){
        let parameters = ["machineId":catchMeModel.machineDTO.id,"userId":UserInfoModel.shareInstance().idField] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(Heartbeat, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.headerModel = HeartModel.init(fromDictionary: resultDic.value as! NSDictionary)
                self.getUserInfo(currentUser: self.headerModel.currentPlayerDTO)
            }
        }
    }
    
    //查看排队情况
    func gameStart(){
        if playGame {
            if ((UserInfoModel.shareInstance().coinAmount as NSString?)?.integerValue)! < self.catchMeModel.price {
                KWINDOWDS().addSubview(GloableAlertView.init(title: "当前余额不足支付一次游戏\n请先充值", btnTop: "去充值", btnBottom: "取消", image: UIImage.init(named: "pic_fail_1")!, type: GloableAlertViewType.topupfail, clickClouse: { (tag) in
                    if tag == 100 {
                        self.gotoTopUpVC()
                    }
                }))
                //4 xia
            }else{
                if NIMSDK.shared().loginManager.isLogined() {
                    if self.catchMeModel.currentPlayStatus == 0 {
                        let parameters = ["machineId":catchMeModel.machineDTO.id,"userId":UserInfoModel.shareInstance().idField,"roomId":self.catchMeModel.id] as [String : Any]
                        BaseNetWorke.sharedInstance.getUrlWithString(GamePrepa, parameters: parameters as AnyObject).observe { (resultDic) in
                            if !resultDic.isCompleted {
                                //排队成功调用
                                self.prepareModel = PrepareGameModel.init(fromDictionary: resultDic.value as! NSDictionary)
                                if self.prepareModel != nil {
                                    //建立点对点连接
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
                self.showGameView()
            }
        }
    }
    //         1上，2下，3左，4右Font
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
        let parameters = ["machineId":self.catchMeModel.machineDTO.id,"userId":UserInfoModel.shareInstance().idField] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(ShootGame, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
            }
        }
        //测试
        if time == nil {
            time = Timer.every(3, {
                self.timeCount = self.timeCount + 1
                self.getGameStaus()
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
                if self.gameStatus.status == 3 || self.timeCount > 30{
                    self.shootFail()
                    let coinAmount = UserInfoModel.shareInstance().coinAmount.int! - self.catchMeModel.price
                    UserInfoModel.shareInstance().coinAmount = "\(coinAmount)"
                    UserInfoModel.shareInstance().saveOrUpdate(byColumnName: "neteaseAccountId", andColumnValue: "'\(UserInfoModel.shareInstance().neteaseAccountId!)'")
                    self.time.invalidate()
                }else if self.gameStatus.status == 2 {
                    self.time.invalidate()
                    let coinAmount = UserInfoModel.shareInstance().coinAmount.int! - self.catchMeModel.price
                    UserInfoModel.shareInstance().coinAmount = "\(coinAmount)"
                    UserInfoModel.shareInstance().saveOrUpdate(byColumnName: "neteaseAccountId", andColumnValue: "'\(UserInfoModel.shareInstance().neteaseAccountId!)'")
                    self.shootSuccess()
                }else{
                    print(self.gameStatus.status)
                }
            }
        }
    }
    
    //在玩一次
    func playAgain(){
        let parameters = ["lastGameId":self.prepareModel.gameId,"userId":UserInfoModel.shareInstance().idField,"roomId":self.catchMeModel.id,"machineId":self.catchMeModel.machineDTO.id] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(PlayAgain, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                //抓取成功调用
                let model = PlayGameAgain.init(fromDictionary: resultDic.value as! NSDictionary)
                self.prepareModel.gameId = model.gameId
                self.cacheMeController.setUpCountDownView()
            }
        }
    }
    
    func getUserInfo(currentUser:BasicUserDTO?){
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
        
        self.cacheMeController.cacheMeTopView.setData(model: self.currentUser)
    }
    
    func gotoTopUpVC(){
        if !COFIGVALUE {
            NavigationPushView(self.cacheMeController, toConroller: InPurchaseViewController())
        }else{
            NavigationPushView(self.cacheMeController, toConroller: TopUpViewController())
        }
    }
    
    func shootSuccess(){
        KWINDOWDS().addSubview(GloableAlertView.init(title: "好棒，活捉一只娃娃", btnTop: "查看我的娃娃", btnBottom: "炫耀一下", image: UIImage.init(named: "pic_success")!, type: GloableAlertViewType.success, clickClouse: { (tag) in
            if tag == 100 {
                NavigationPushView(self.cacheMeController, toConroller: MyJoysViewController())
            }else{
                let toControllerVC = BaseWebViewController()
                toControllerVC.url = "\(ShareCatchDoll)\(self.gameStatus.id!)"
                NavigationPushView(self.cacheMeController, toConroller: toControllerVC)
            }
        }))
    }
    
    func shootFail(){
        //抓取失败
        KWINDOWDS().addSubview(GloableAlertView.init(title: "好可惜，就差一点了", btnTop: "再试一次5s", btnBottom: "无力再试", image: UIImage.init(named: "pic_fail_1")!, type: GloableAlertViewType.catchfail, clickClouse: { (tag) in
            if tag == 100 {
                self.playAgain()
            }else{
                //断开点对点连接
                self.handUpConnect()
            }
        }))
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
    
    func onRemoteImageReady(_ image: CGImage) {
        if cacheMeController.remoteGLView == nil {
            cacheMeController.initRemoteGlView()
        }
        self.cacheMeController.remoteGLView.image = UIImage.init(cgImage: image)
    }
    
    func onAudioMixTaskCompleted() {
        
    }
    
    //YUVdata数据直接渲染
    func onRemoteYUVReady(_ yuvData: Data, width: UInt, height: UInt, from user: String) {
//        if cacheMeController.remoteGLView == nil {
//            cacheMeController.initRemoteGlView()
//        }
//        cacheMeController.remoteGLView.render(yuvData, width: width, height: height)
    }
    
    func onControl(_ callID: UInt64, from user: String, type control: NIMNetCallControlType) {
        
    }
    
    func onCallEstablished(_ callID: UInt64) {
        print("连接成功\(callID)")
        self.callID = callID
        self.gameStarts()
    }
    
    func onCallDisconnected(_ callID: UInt64, withError error: Error?) {
        if error != nil {
            _ = Tools.shareInstance.showLoading(KWINDOWDS(), msg: error!.localizedDescription)
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
    
    func onHangup(_ callID: UInt64, by user: String) {
        self.callID = callID
        self.handUpConnect()
    }
}

