//
//  CacheMeViewModel.swift
//  CatchMe
//
//  Created by Zhang on 20/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

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
    override init() {
        super.init()
    }
    
    deinit {
        if time != nil {
            time.invalidate()
        }
        if timeHeader != nil {
            timeHeader.invalidate()
        }
    }
    //MARK: GameTools
    //断开拉流
    func doDestroyPlay(){
        if cacheMeController.liveplayer.isPlaying() {
            cacheMeController.liveplayer.shutdown()
        }
    }
    
    //游戏前准备
    func prepedPlay(){
        cacheMeController.setUpCountDown(isPlay: false, text: "36")
        if !cacheMeController.liveplayer.isPlaying() {
            cacheMeController.liveplayer.prepareToPlay()
        }
        if cacheMeController.localPreView != nil {
            cacheMeController.localPreView.isHidden = false
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
    
    //游戏界面
    func playGame(){
        self.doDestroyPlay()
        cacheMeController.setUpCountDown(isPlay: true, text: "36")
        if cacheMeController.localPreView != nil {
            cacheMeController.localPreView.isHidden = true
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
        self.prepedPlay()
        if self.callID != nil {
            NIMAVChatSDK.shared().netCallManager.hangup(self.callID)
        }
    }
    //改变摄像头
    func changeCamera(){
        if cacheMeController.liveplayer.isPlaying(){
            //切换拉流地址
            NIMAVChatSDK.shared().netCallManager.switchBypassStreamingUrl("")
        }else{
            NIMAVChatSDK.shared().netCallManager.control(self.callID, type: NIMNetCallControlType.noCamera)
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
    //建立点对点连接
    func makeGameToUser(){
        let option = NIMNetCallOption.init()
        self.fillUserSetting(option)
        NIMAVChatSDK.shared().netCallManager.start([self.catchMeModel.machineDTO.playerAccountId], type: NIMNetCallMediaType.video, option: option) { (error, nil) in
            if error == nil {
                self.cacheMeController.setUpCountDownView()
                self.playGame()
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
                self.cacheMeController.cacheMeTopView.setData(model: self.catchMeModel.basicUserDTO)
                //心跳接口
                self.timeHeader = Timer.every(1, {
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
                self.cacheMeController.cacheMeTopView.setData(model: self.catchMeModel.basicUserDTO)
                //心跳接口
                self.timeHeader = Timer.every(1, {
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
                
            }
        }
    }
    
    //心跳
    func requestHeader(){
        let parameters = ["machineId":catchMeModel.machineDTO.id,"userId":UserInfoModel.shareInstance().idField] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(Heartbeat, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.headerModel = HeartModel.init(fromDictionary: resultDic.value as! NSDictionary)
                self.catchMeModel.basicUserDTO = self.headerModel.basicUserDTO
                self.cacheMeController.cacheMeTopView.setData(model: self.catchMeModel.basicUserDTO)
            }
        }
    }
    
    //查看排队情况
    func gameStart(){
        if NIMSDK.shared().loginManager.isLogined() {
            if self.catchMeModel.currentPlayStatus != 1 || self.headerModel.currentPlayerId != nil {
                let parameters = ["machineId":catchMeModel.machineDTO.id,"userId":UserInfoModel.shareInstance().idField,"roomId":self.model.id] as [String : Any]
                BaseNetWorke.sharedInstance.getUrlWithString(GamePrepa, parameters: parameters as AnyObject).observe { (resultDic) in
                    if !resultDic.isCompleted {
                        //排队成功调用
                        self.prepareModel = PrepareGameModel.init(fromDictionary: resultDic.value as! NSDictionary)
                        self.makeGameToUser()
                        self.doDestroyPlay()
                        self.gameStarts()
                    }
                }
            }
        }else{
            _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "用户未登录", autoHidder: true)
            NeteaseManager.shareInstance.setAutoLogin()
        }
    }
    
    //开始游戏
    func gameStarts(){
        let parameters = ["machineId":catchMeModel.machineDTO.id,"userId":UserInfoModel.shareInstance().idField] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(StartGame, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                //排队成功调用
                
            }
        }
    }
    
    //点击上下左右
    func playGameLogic(tag:Int){
        let parameters = ["machineId":catchMeModel.machineDTO.id,"userId":UserInfoModel.shareInstance().idField,"type":tag] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(MoveGame, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                
            }
        }
    }
    
    //抓取
    func playGameGo(){
        let parameters = ["machineId":self.catchMeModel.id,"userId":UserInfoModel.shareInstance().idField] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(ShootGame, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
            }
        }
        //测试
        
        time = Timer.every(3, {
            self.timeCount = self.timeCount + 1
            self.getGameStaus()
        })
    }
    
    //获取游戏结果
    func getGameStaus(){
        let parameters = ["gameId":self.prepareModel.gameId] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(GameStatus, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
               //抓取成功调用
                self.gameStatus = GameStatusModel.init(fromDictionary: resultDic.value as! NSDictionary)
                if self.gameStatus.status == 2 || self.timeCount > 30{
                    self.shootFail()
                    self.time.invalidate()
                }else if self.gameStatus.status == 3 {
                    self.time.invalidate()
                    self.shootSuccess()
                }
            }
        }
    }
    
    func shootSuccess(){
        KWINDOWDS().addSubview(GloableAlertView.init(title: "好棒，活捉一只娃娃", btnTop: "查看我的娃娃", btnBottom: "炫耀一下", image: UIImage.init(named: "pic_success")!, type: GloableAlertViewType.success, clickClouse: { (tag) in
            if tag == 100 {
                NavigationPushView(self.cacheMeController, toConroller: MyJoysViewController())
            }else{
                KWINDOWDS().addSubview(GloabelShareAndConnectUs.init(type: GloabelShareAndConnectUsType.share, clickClouse: { (type) in
                    switch type {
                    case .QQChat:
                        ShareTools.shareInstance.shareQQSessionWebUrl("测试", webTitle: "", imageUrl: "", webDescription: "", webUrl: "")
                    case .weChatChat:
                        ShareTools.shareInstance.shareWeChatSession("", description: "", image: UIImage.init(named: "pic_about")!, url: nil)
                    case .weChatSession:
                        ShareTools.shareInstance.shareWeChatTimeLine("", description: "", image: UIImage.init(named: "pic_about")!, url: nil)
                    default:
                        break
                    }
                }))
            }
        }))
    }
    
    func shootFail(){
        //抓取失败
        KWINDOWDS().addSubview(GloableAlertView.init(title: "好可惜，就差一点了", btnTop: "再试一次5s", btnBottom: "无力再试", image: UIImage.init(named: "pic_fail_1")!, type: GloableAlertViewType.catchfail, clickClouse: { (tag) in
            if tag == 100 {
                self.playGame()
            }else{
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
        self.playGame()
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

