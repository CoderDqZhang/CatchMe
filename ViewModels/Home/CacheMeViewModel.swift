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
    var time:Timer!
    var timeHeader:Timer!
    
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
    
    //MARK: Networking

    //进入房间
    func requestEntRooms(){
        let parameters = ["roomId":model.id,"userId":UserInfoModel.shareInstance().idField] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(EnterRooms, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.catchMeModel = CatchMeModel.init(fromDictionary: resultDic.value as! NSDictionary)
                //心跳接口
                self.requestHeader()
            }
        }
    }
    
    //退出房间
    func requestExitRooms(){
        let parameters = ["machineId":model.id,"userId":UserInfoModel.shareInstance().idField] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(ExitRoom, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                
            }
        }
    }
    
    //心跳
    func requestHeader(){
        let parameters = ["machineId":model.id,"userId":UserInfoModel.shareInstance().idField] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(Heartbeat, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                
            }
        }
    }
    
    //查看排队情况
    func gameStart(){
        let parameters = ["machineId":model.id,"userId":UserInfoModel.shareInstance().idField] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(ExitRoom, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                //排队成功调用
//                self.doDestroyPlay()
//                self.cacheMeController.setUpCountDownView()
//                cacheMeViewModel.playGame()
            }
        }
    }
    
    //点击上下左右
    func playGameLogic(tag:Int){
        let parameters = ["roomId":self.catchMeModel.id,"userId":UserInfoModel.shareInstance().idField,"type":tag] as [String : Any]
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
        
        if #available(iOS 10.0, *) {
            time = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (time) in
                self.getGameStaus()
            })
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    //获取游戏结果
    func getGameStaus(){
        let parameters = ["gameId":model.id] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(GameStatus, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
               //抓取成功调用
                self.time.invalidate()
//                self.shootSuccess()
//                self.shootFail()
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
        
    }
    
    func onAudioMixTaskCompleted() {
        
    }
    
    func onRemoteYUVReady(_ yuvData: Data, width: UInt, height: UInt, from user: String) {
        if cacheMeController.remoteGLView == nil {
            cacheMeController.initRemoteGlView()
        }
        cacheMeController.remoteGLView.render(yuvData, width: width, height: height)
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

