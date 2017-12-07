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
    
    var olineUserList:[Int]!
    
    var numberOlineUser:Int = 0
    
    var currentUser:BasicUserDTO!
    
    var getGameStatus:Bool = false
    var playGameGoStatus:Bool = false
    var isPlayAgain:Bool = true
    //麦克风权限
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
        self.stopGame()
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
        if cacheMeController.liveplayer != nil && cacheMeController.liveplayer.isPlaying() {
            cacheMeController.liveplayer.view.isHidden = false
            self.cacheMeController.view.sendSubview(toBack: cacheMeController.liveplayer.view)
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
            self.cacheMeController.view.sendSubview(toBack: cacheMeController.remoteGLView)
        }
        if self.cacheMeController.cacheMePlayUserView != nil {
            self.cacheMeController.view.bringSubview(toFront: self.cacheMeController.cacheMePlayUserView)
        }
    }

    //开始游戏成功
    func showGameView(){
        if self.prepareModel != nil {
            self.cacheMeController.gameToolsView.setCountLabelText(count: self.prepareModel.maxTime)
        }
        if cacheMeController.localPreView != nil {
            cacheMeController.localPreView.isHidden = true
            cacheMeController.liveplayer.view.isHidden = true
            self.cacheMeController.view.sendSubview(toBack: cacheMeController.liveplayer.view)
        }
        if cacheMeController.bottomToolsView != nil {
            cacheMeController.bottomToolsView.isHidden = true
        }
        if cacheMeController.gameToolsView != nil {
            cacheMeController.gameToolsView.isHidden = false
        }
        if cacheMeController.remoteGLView != nil {
            cacheMeController.remoteGLView.isHidden = false
            self.cacheMeController.view.bringSubview(toFront: cacheMeController.remoteGLView)
        }
        if self.cacheMeController.cacheMePlayUserView != nil {
            self.cacheMeController.view.bringSubview(toFront: self.cacheMeController.cacheMePlayUserView)
        }
    }
    
    func handUpConnect(){
        if self.cacheMeController.localPreView != nil {
            self.cacheMeController.localPreView.isHidden = false
        }
        if self.callID != nil {
            self.cacheMeController.setUpPlayer(url: self.catchMeModel.machineDTO.audiencePullAddressA)
            NIMAVChatSDK.shared().netCallManager.hangup(self.callID)
        }
        self.prepedPlay()
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
        param.preferredVideoQuality = .qualityMedium
        param.format = NIMNetCallVideoCaptureFormat.format420v
        param.videoCrop = NIMNetCallVideoCrop.cropNoCrop
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
                self.setUpRoomPalyUsers(currentUser: self.catchMeModel.currentPlayerDTO)
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
                self.cacheMeController.setUpPlayer(url: self.catchMeModel.machineDTO.audiencePullAddressA)
                self.playUrl = self.catchMeModel.machineDTO.audiencePullAddressA
                self.setUpRoomPalyUsers(currentUser: self.catchMeModel.currentPlayerDTO)
                self.cacheMeController.bottomToolsView.changePlayGameCoins(str: "\(self.catchMeModel.price!)")
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
                if resultDic.error != nil {
                    self.handUpConnect()
                    return
                }
                self.headerModel = HeartModel.init(fromDictionary: resultDic.value as! NSDictionary)
                self.setUpRoomPalyUsers(currentUser: self.headerModel.currentPlayerDTO)
            }
        }
    }
    
    //查看排队情况
    func gameStart(){
        if playGame {
            if UserInfoModel.shareInstance().coinAmount.int! < self.catchMeModel.price {
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
                                if resultDic.error != nil {
                                    self.handUpConnect()
                                    return
                                }
                                self.prepareModel = PrepareGameModel.init(fromDictionary: resultDic.value as! NSDictionary)
                                if self.prepareModel != nil && resultDic.value != nil{
                                    //建立点对点连接
                                    self.getGameStatus = false
                                    self.playGameGoStatus = false
                                    let coinAmount = UserInfoModel.shareInstance().coinAmount.int! - self.catchMeModel.price
                                    UserInfoModel.shareInstance().coinAmount = "\(coinAmount)"
                                    UserInfoModel.shareInstance().saveOrUpdate(byColumnName: "neteaseAccountId", andColumnValue: "'\(UserInfoModel.shareInstance().neteaseAccountId!)'")
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
                if resultDic.error != nil {
                    self.handUpConnect()
                    return
                }
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
        self.playGameGoStatus = true
        let parameters = ["machineId":self.catchMeModel.machineDTO.id,"userId":UserInfoModel.shareInstance().idField] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(ShootGame, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.cacheMeController.gameToolsView.setCountLabelText(count: -1)
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
                    self.shootFail()
                    self.getGameStatus = true
                    self.playGameGoStatus = false
                }else if self.gameStatus.status == 2 {
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

            }
        }
    }
    
    //在玩一次
    func playAgain(){
        if UserInfoModel.shareInstance().coinAmount.int! < self.catchMeModel.price {
            KWINDOWDS().addSubview(GloableAlertView.init(title: "当前余额不足支付一次游戏\n请先充值", btnTop: "去充值", btnBottom: "取消", image: UIImage.init(named: "pic_fail_1")!, type: GloableAlertViewType.topupfail, clickClouse: { (tag) in
                if tag == 100 {
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
                        self.handUpConnect()
                        return
                    }
                    let model = PlayGameAgain.init(fromDictionary: resultDic.value as! NSDictionary)
                    self.prepareModel.gameId = model.gameId
                    if self.prepareModel != nil {
                       self.getGameStatus = false
                       self.playGameGoStatus = false
                        self.cacheMeController.gameToolsView.setCountLabelText(count: self.prepareModel.maxTime)
                    }
                }
            }
        }
    }
    
    func setUpRoomPalyUsers(currentUser:BasicUserDTO?){
        //获取当前真正玩的用户
        self.getUserInfo(currentUser: currentUser)
        //获取用户列表
        self.getRoomUserListInfo()
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

        if self.cacheMeController.cacheMePlayUserView != nil {
            self.cacheMeController.view.bringSubview(toFront: self.cacheMeController.cacheMePlayUserView)
            self.cacheMeController.cacheMePlayUserView.setData(model: self.currentUser)
        }
    }
    
    func getRoomUserListInfo(){
        if self.olineUserList == nil {
            if self.catchMeModel != nil {
                self.olineUserList = self.catchMeModel.onlineUserList
            }else{
                self.olineUserList = self.headerModel.userList
            }
        }else{
            let count = self.headerModel.userList == nil ? self.catchMeModel.onlineUserList.count : self.headerModel.userList.count
            let olist:[Int] = self.headerModel.userList == nil ? self.catchMeModel.onlineUserList : self.headerModel.userList
            if self.numberOlineUser != olist.count {
                self.cacheMeController.cacheMeTopView.changeNumberUser(str: "\(olist.count)")
            }

            if count > 3 {
                if self.olineUserList.count > 3 {
                    var ret:Bool = false
                    for i in 0...2 {
                        if self.olineUserList.item(at: i) != olist.item(at: i) {
                            self.olineUserList.insert(olist.item(at: i)!, at: i)
                            ret = true
                        }
                    }
                    if ret {
                        return
                    }
                }else{
                    for i in 0...2 {
                        self.olineUserList.insert(olist.item(at: i)!, at: i)
                    }
                }
            }else{
                if self.olineUserList.count == olist.count {
                    self.olineUserList.removeAll()
                    for i in 0...olist.count - 1 {
                        self.olineUserList.insert(olist.item(at: i)!, at: i)
                    }
                }else{
                    var ret:Bool = false
                    for i in 0...olist.count - 1 {
                        if self.olineUserList.item(at: i) != olist.item(at: i) {
                            self.olineUserList.insert(olist.item(at: i)!, at: i)
                            ret = true
                        }
                    }
                    if ret {
                        return
                    }
                }
            }
        }
        var str:NSString = ""
        for userId in self.olineUserList {
            str = str.appending("\(userId),") as NSString
        }
        
        let parameters = ["userIdList":str]
        BaseNetWorke.sharedInstance.postUrlWithString(RoomUserList, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                let models:NSMutableArray = NSMutableArray.mj_objectArray(withKeyValuesArray: resultDic.value)
                self.numberOlineUser = models.count
                self.cacheMeController.cacheMeTopView.setUpData(models: models, count: "\(models.count)")
            }
        }
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
            }else if tag == 200{
                //断开点对点连接
                self.stopGame()
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

