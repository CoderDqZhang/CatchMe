//
//  CacheMeViewController.swift
//  CatchMe
//
//  Created by Zhang on 18/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import NIMSDK
import NIMAVChat


typealias CacheMeViewControllerPopViewClouse = () ->Void

class CacheMeViewController: BaseViewController {

    var backImage:UIImageView!
    
    var liveplayerA:NELivePlayer!
    var liveplayerB:NELivePlayer!
    var liveplayerView:UIView!
    var player:NELivePlayerController!

    var localPreView:LocalPreView!
    var quictEnterLocalPreView:QuictEnterLocalPreView!
    var nELivePlayerLoadFailView:NELivePlayerLoadFailView!

    var bottomToolsView:CacheMeToolsView!
    var cacheMeTopView:CacheMeTopView!
    var cacheMePlayUserView:CacheMePlayUserView!
    var gameToolsView:GameToolsView!
    var gameTipView:GameTipView!
    var readyGogameTipView:GameTipView!
    var dollDetailView:DollDetailView!
    var switchCamera:UIButton!
    var showDollsDetail:UIButton!
    
    var remoteGLView:NTESGLView!
    
    var roomModel:Labels!
    
    var countDown:UILabel!
    
    var time:Timer!
    
    var cacheMeViewModel = CacheMeViewModel()
    var url:String = ""
    var addToCacth:UIButton!
    
    var isQuickEnter:Bool = false
    
    var numberCatch:Int = 0
    
    var nElivePlayLoadFailATime:Timer!
    var nElivePlayLoadFailBTime:Timer!
    
    var isHaveLiverAData:Bool = false
    var isHaveLiverBData:Bool = false
    
    var numberACount:Int = 0
    var numberBCount:Int = 0
    
    var cacheMeViewControllerPopViewClouse:CacheMeViewControllerPopViewClouse!
    override func viewDidLoad() {
        self.umengPageName = "游戏界面"
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        self.getNumberEnter()
        self.setUpBgImageView()
        self.bindViewModel(viewModel: cacheMeViewModel, controller: self)
        self.setUpFontToolsView()
        self.bindLogicViewModel()
        self.doInitPlayerNotication()
        self.initRemoteGlView()
        // Do any additional setup after loading the view.
    }
    
    func getNumberEnter(){
        let str = "Number_\(UserInfoModel.shareInstance().idField!)"
        let number = UserDefaultsGetSynchronize(str)
        if number as! String == "nil" {
            self.numberCatch = 1
            UserDefaultsSetSynchronize("1" as AnyObject, key: str)
        }else{
            self.numberCatch = (number as! NSString).integerValue + 1
            UserDefaultsSetSynchronize("\(self.numberCatch)" as AnyObject, key: str)
        }
    }
    
    deinit {
        if time != nil {
            time.invalidate()
        }
        // 播放器媒体流初始化完成后触发，收到该通知表示可以开始播放
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NELivePlayerDidPreparedToPlay, object: self.liveplayerA)
         NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NELivePlayerDidPreparedToPlay, object: self.liveplayerB)
        // 播放器加载状态发生变化时触发，如开始缓冲，缓冲结束
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NELivePlayerLoadStateChanged, object: self.liveplayerA)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NELivePlayerLoadStateChanged, object: self.liveplayerB)
        //
        // 正常播放结束或播放过程中发生错误导致播放结束时触发的通知
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NELivePlayerPlaybackFinished, object: self.liveplayerA)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NELivePlayerPlaybackFinished, object: self.liveplayerB)
        //
        // 第一帧视频图像显示时触发的通知
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NELivePlayerFirstVideoDisplayed, object: self.liveplayerA)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NELivePlayerFirstVideoDisplayed, object: self.liveplayerB)
        //
        // 第一帧音频播放时触发的通知
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NELivePlayerFirstAudioDisplayed, object: self.liveplayerA)
         NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NELivePlayerFirstAudioDisplayed, object: self.liveplayerB)
        // 资源释放成功后触发的通知
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NELivePlayerReleaseSueecss, object: self.liveplayerA)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NELivePlayerReleaseSueecss, object: self.liveplayerB)
        // 视频码流解析失败时触发的通知
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NELivePlayerVideoParseError, object: self.liveplayerA)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NELivePlayerVideoParseError, object: self.liveplayerB)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        self.navigationController?.fd_fullscreenPopGestureRecognizer.isEnabled = false
        if UserDefaultsGetSynchronize(MUISCCOGIF) as! String == "true" {
            AudioPlayManager.shareInstance.playBgMusic(name: "\(ConfigModel.shanreInstance.musicName!)")
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        self.navigationController?.fd_fullscreenPopGestureRecognizer.isEnabled = true
        if UserDefaultsGetSynchronize(MUISCCOGIF) as! String == "true" {
            AudioPlayManager.shareInstance.pause()
        }
    }
    
    func setUpBgImageView(){
        backImage = UIImageView.init()
        backImage.image = UIImage.init(named: "bg_game")
        self.view.addSubview(backImage)
        backImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    func bindLogicViewModel(){
        cacheMeViewModel.cacheMeController = self
        cacheMeViewModel.model = self.roomModel
        cacheMeViewModel.getAVAuthorizationStatus()
        if isQuickEnter {
            self.setUpQuitEntRoom()
            self.view.bringSubview(toFront: cacheMeTopView)
            cacheMeViewModel.requestQuickEntRooms()
        }else{
            cacheMeViewModel.requestEntRooms()
        }
    }
    
    func setUpNELivePlayerLoadFailView(){
        if nELivePlayerLoadFailView == nil {
            nELivePlayerLoadFailView = NELivePlayerLoadFailView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
            nELivePlayerLoadFailView.nELivePlayerLoadFailViewClouse = {
                self.nELivePlayerLoadFailView.isHidden = true
                self.numberACount = 0
                self.numberBCount = 0
                self.localPreView.isHidden = false
                if self.liveplayerA.view.isHidden {
                    if self.liveplayerB.isPlaying() {
                        self.localPreView.isHidden = true
                        self.nElivePlayLoadFailBTime.invalidate()
                    }else{
                        self.localPreView.isHidden = false
                    }
                }else if self.liveplayerB.view.isHidden {
                    if self.liveplayerA.isPlaying() {
                        self.localPreView.isHidden = true
                        self.nElivePlayLoadFailATime.invalidate()
                    }else{
                        self.localPreView.isHidden = false

                    }
                }
            }
            nELivePlayerLoadFailView.layer.cornerRadius = 10
            nELivePlayerLoadFailView.layer.masksToBounds = true
            self.view.addSubview(nELivePlayerLoadFailView)
            self.nELivePlayerLoadFailView.snp.makeConstraints({ (make) in
                make.centerX.equalTo(self.view.snp.centerX).offset(0)
                make.top.equalTo(self.view.snp.top).offset(64 + IPHONEXFRAMEHEIGHT)
                make.bottom.equalTo(self.view.snp.bottom).offset(-122)
                make.size.equalTo(CGSize.init(width: (SCREENWIDTH - 16), height: SCREENHEIGHT - 122 - 64 - IPHONEXFRAMEHEIGHT))
            })
            self.view.bringSubview(toFront: self.switchCamera)
            //2.0
//            self.view.bringSubview(toFront: self.showDollsDetail)
        }else{
            self.view.bringSubview(toFront: self.nELivePlayerLoadFailView)
            self.view.bringSubview(toFront: self.switchCamera)
            //2.0
//            self.view.bringSubview(toFront: self.showDollsDetail)
            self.nELivePlayerLoadFailView.isHidden = false
        }
    }
    
    //拉流地址
    func setUpPlayer(url:[String]){
        liveplayerView = UIView.init()
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "")
        liveplayerView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(liveplayerView.snp.top).offset(0)
            make.left.equalTo(liveplayerView.snp.left).offset(0)
            make.bottom.equalTo(liveplayerView.snp.bottom).offset(0)
            make.right.equalTo(liveplayerView.snp.right).offset(0)
        }
        liveplayerView.layer.cornerRadius = 10
        liveplayerView.layer.masksToBounds = true
        self.view.addSubview(liveplayerView)
        liveplayerView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(self.view.snp.top).offset(64 + IPHONEXFRAMEHEIGHT)
            make.bottom.equalTo(self.view.snp.bottom).offset(-122)
            make.size.equalTo(CGSize.init(width: (SCREENWIDTH - 16), height: SCREENHEIGHT - 122 - 64 - IPHONEXFRAMEHEIGHT))
        }
        NELivePlayerController.setLogLevel(NELPLogLevel.LOG_ERROR)
        do {
            try self.liveplayerA = NELivePlayerController.init(contentURL: URL.init(string: url[0]))
            self.setUpPlayerB(url: url[1])
            self.liveplayerA.setPlaybackTimeout(30000)
            self.configLiveLayer(liveplayer: self.liveplayerA)
            
            self.setUpPlayUserView()
            self.setUpCameraView()
//            self.setUpShowDollsDetail()
            self.setUpSwiperGesture(view: self.liveplayerA.view, type: .left)
            self.view.bringSubview(toFront: cacheMeTopView)
            
            if nElivePlayLoadFailATime == nil {
                nElivePlayLoadFailATime = Timer.every(1, {
                    self.numberACount = self.numberACount + 1
                    //点对点连接成功后3秒获取拉流失败提示禁止
                    if self.remoteGLView.isHidden {
                        self.isHaveAStreamData(waitingTime: self.numberACount)
                    }
                })
            }
            //拉流地址设置成功后执行拉流的一些界面创建
            //根据通知的状态来隐藏和显示视图
            
        } catch {
            self.setUpNELivePlayerLoadFailView()
            print("拉流失败")
            return
        }
    }
    
    func isHaveAStreamData(waitingTime:Int){
        if self.liveplayerA != nil && !self.liveplayerA.view.isHidden {
            if isHaveLiverAData { // 只有在第一帧回调的时候触发
                self.nElivePlayLoadFailATime.invalidate()
                if self.localPreView != nil{
                    self.localPreView.isHidden = true
                }
                if waitingTime > 3 && self.nELivePlayerLoadFailView != nil {
                    self.nELivePlayerLoadFailView.isHidden = true
                }
            }else{
                if waitingTime >= 3 {
                    self.setUpNELivePlayerLoadFailView()
                }
//                if self.liveplayerA.isPlaying() {
//                    if self.localPreView != nil{
//                        self.localPreView.isHidden = true
//                    }
//                }
            }
        }
    }
    
    func setUpPlayerB(url:String) {
        do {
            try self.liveplayerB = NELivePlayerController.init(contentURL: URL.init(string: url))
            self.configLiveLayer(liveplayer: self.liveplayerB)
            self.liveplayerB.view.isHidden = true
            self.setUpSwiperGesture(view: self.liveplayerB.view, type: .left)
            self.liveplayerB.setPlaybackTimeout(30000)
            if nElivePlayLoadFailBTime == nil {
                nElivePlayLoadFailBTime = Timer.every(1, {
                    self.numberBCount = self.numberBCount + 1
                    //点对点连接成功后3秒获取拉流失败提示禁止
                    if self.remoteGLView.isHidden {
                        self.isHaveBStreamData(waitingTime: self.numberACount)
                    }
                })
            }
            //拉流地址设置成功后执行拉流的一些界面创建
            //根据通知的状态来隐藏和显示视图
        } catch {
            print("拉流失败")
            return
        }
    }
    
    func isHaveBStreamData(waitingTime: Int) {
        if self.liveplayerB != nil && !self.liveplayerB.view.isHidden {
            if isHaveLiverBData {
                self.nElivePlayLoadFailBTime.invalidate()
                if waitingTime > 3 && self.nELivePlayerLoadFailView != nil {
                    self.nELivePlayerLoadFailView.isHidden = true
                }
            }else{
                if waitingTime >= 3 {
                    self.setUpNELivePlayerLoadFailView()
                }
            }
        }
    }
    
    func configLiveLayer(liveplayer:NELivePlayer){
        liveplayer.setScalingMode(NELPMovieScalingMode.init(3))
        liveplayer.setHardwareDecoder(true)
        liveplayerView.addSubview(liveplayer.view)
        liveplayer.view.layer.borderWidth = 0.0001
        liveplayer.view.layer.borderColor = UIColor.clear.cgColor
        liveplayer.view.layer.cornerRadius = 10
        liveplayer.view.layer.masksToBounds = true
        liveplayer.view.snp.makeConstraints({ (make) in
            make.left.equalTo(self.liveplayerView.snp.left).offset(0)
            make.top.equalTo(self.liveplayerView.snp.top).offset(0)
            make.bottom.equalTo(self.liveplayerView.snp.bottom).offset(0)
            make.right.equalTo(self.liveplayerView.snp.right).offset(0)
        })
        
        liveplayer.view.isUserInteractionEnabled = true
        liveplayer.setBufferStrategy(NELPBufferStrategy.init(3))
        liveplayer.shouldAutoplay = true
        liveplayer.setPlaybackTimeout(15 * 1000)
        liveplayer.prepareToPlay()
    }
    
    func setUpFontToolsView(){
        self.setUpPlayGameView()
        self.setUpToolsView()
        self.setUpCacheMeTopView()
        self.setUpGameView()
    }
    
    func setUpCountDown(isPlay:Bool, text:String) {
        if self.countDown != nil {
            self.countDown.isHidden = !isPlay
            self.countDown.text = text
        }
    }
    
    func setUpGameTipView(){
        if gameTipView == nil && self.numberCatch <= 5{
            let str = TipString
            let witdh = (str as NSString).width(with: App_Theme_PinFan_M_17_Font, constrainedToHeight: 20) + 100
           gameTipView = GameTipView.init(frame: CGRect.init(x: (SCREENWIDTH - witdh)/2, y: SCREENHEIGHT - 90 - 122 - 64, width: witdh, height: 87), tipStr: str)
            self.view.addSubview(gameTipView)
        }
    }
    //开始游戏readyGo
    func setUpreadyGogameTipView(){
        let str = "Ready...GO!"
        let witdh = (str as NSString).width(with: App_Theme_PinFan_M_17_Font, constrainedToHeight: 20) + 100
        readyGogameTipView = GameTipView.init(frame: CGRect.init(x: (SCREENWIDTH - witdh)/2, y: SCREENHEIGHT - 90 - 122 - 64, width: witdh, height: 87), tipStr: str)
        readyGogameTipView.alpha = 0.1
        self.view.addSubview(readyGogameTipView)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.readyGogameTipView.alpha = 1
        }, completion: { (ret) in
            _ = Timer.after(1, {
                UIView.animate(withDuration: 1, animations: {
                    self.readyGogameTipView.alpha = 0.1
                }, completion: { (ret) in
                    self.readyGogameTipView.removeFromSuperview()
                })
            })
        })
    }
    
    //
    //创建进来时本地加载界面 后期可能是显示自己的视频，前期显示加载
    func setUpPlayGameView(){
        localPreView = LocalPreView.init()
        localPreView.layer.masksToBounds = true
        localPreView.layer.cornerRadius = 10
        self.view.addSubview(localPreView)
        self.localPreView.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(self.view.snp.top).offset(64 + IPHONEXFRAMEHEIGHT)
            make.bottom.equalTo(self.view.snp.bottom).offset(-122)
            make.size.equalTo(CGSize.init(width: (SCREENWIDTH - 16), height: SCREENHEIGHT - 122 - 64 - IPHONEXFRAMEHEIGHT))
        })
    }
    
    //快速进入房间
    func setUpQuitEntRoom(){
//        quictEnterLocalPreView = QuictEnterLocalPreView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
//        self.view.addSubview(quictEnterLocalPreView)
    }
    
    //创建游戏者视频界面
    func initRemoteGlView(){
        remoteGLView = NTESGLView.init()
        remoteGLView.isHidden = true
        remoteGLView.clipsToBounds = true
        remoteGLView.layer.cornerRadius = 10
        remoteGLView.layer.masksToBounds = true
        self.view.addSubview(remoteGLView)
        self.remoteGLView.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(self.view.snp.top).offset(64 + IPHONEXFRAMEHEIGHT)
            make.bottom.equalTo(self.view.snp.bottom).offset(-122)
            make.size.equalTo(CGSize.init(width: (SCREENWIDTH - 16), height: SCREENHEIGHT - 122 - 64 - IPHONEXFRAMEHEIGHT))
        })
    }
    
    //创建向左滑动
    func setUpSwiperGesture(view:UIView?,type:SwipeGestureRecognizerType){
        if type == .left {
            GestureRecognizerManager.shareInstance.setUpSwipeGestureRecognizerLeft(view: view)
        }
        GestureRecognizerManager.shareInstance.gestureRecognizerManagerClouse = { type in
            self.cacheMeViewModel.changeCamera()
        }
    }
    
    //创建底部工具界面
    func setUpToolsView() {
        bottomToolsView = CacheMeToolsView.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 122, width: SCREENWIDTH, height: 122))
        bottomToolsView.cacheMeToolsViewClouse = { tag in
            switch tag {
            case 1:
                if self.cacheMeViewModel.catchMeModel != nil {
                    let toViewController = JoysDetailViewController()
                    toViewController.url = "\(DollsDetail)\(self.cacheMeViewModel.catchMeModel.skuSubId!)"
                    NavigationPushView(self, toConroller: toViewController)
                }
            case 2:
                self.playGame()
            default:
                self.cacheMeViewModel.gotoTopUpVC()
            }
        }
        self.view.addSubview(bottomToolsView)
    }
    
    //创建娃娃详情界面
    func setUpDollDetailView(model:DollsDetailModel){
        dollDetailView = DollDetailView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT), closeClouse: {
            self.setUpGameTipView()
            //2.0
//            AnimationTools.shareInstance.hiddenViewAnimation(view: self.dollDetailView, frame: self.showDollsDetail.frame, finish: { (ret) in
//                self.dollDetailView.isHidden = true
//            })
        })
        dollDetailView.setUpSubViews(model: model)
        KWINDOWDS().addSubview(dollDetailView)
    }
    
    //创建顶部导航栏
    func setUpCacheMeTopView(){
        cacheMeTopView = CacheMeTopView.init(frame: CGRect.init(x: 0, y: 20 + IPHONEXFRAMEHEIGHT, width: SCREENWIDTH, height: 44), topViewBackButtonClouse: {
            self.cacheMeViewModel.requestExitRooms()
            
            if self.isQuickEnter {
                self.dismiss(animated: true, completion: {
                })
            }else{
                self.dismiss(animated: false, completion: {
                })
            }
        })
        self.view.addSubview(cacheMeTopView)
        self.view.bringSubview(toFront: cacheMeTopView)
    }
    
    //创建正在玩用户视图
    func setUpPlayUserView(){
        if cacheMePlayUserView == nil {
            self.cacheMePlayUserView = CacheMePlayUserView.init(frame: CGRect.init(x: 8, y: 75 + IPHONEXFRAMEHEIGHT, width: (SCREENWIDTH - 16), height: 54))
            self.cacheMePlayUserView.timeDownClouse = {
                self.cacheMeViewModel.playGameGo()
            }
            self.view.addSubview(self.cacheMePlayUserView)
        }
    }
    
    //创建游戏手柄
    func setUpGameView(){
        gameToolsView = GameToolsView.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 122, width: SCREENWIDTH, height: 122), gameToolsViewClouse: { (tag) in
            switch tag {
            case .moveLeft,.moveRight,.moveTop,.moveDown:
                //上//下//左//右
                self.cacheMeViewModel.playGameLogic(tag: tag)
                break;
            case .moveGO:
                self.cacheMeViewModel.playGameGo()
                break;
            default:
                break;
            }
        })
        
        self.gameToolsView.isHidden = true
        self.view.addSubview(gameToolsView)
    }
    //切换摄像头
    func setUpCameraView(){
        switchCamera = AnimationButton.init(type: .custom)
        switchCamera.setImage(UIImage.init(named: "camera"), for: .normal)
        switchCamera.backgroundColor = UIColor.init(hexString: App_Theme_000000_Color, andAlpha: 0.3)
        switchCamera.layer.cornerRadius = 30
        switchCamera.layer.masksToBounds = true
        switchCamera.titleLabel?.textAlignment = .center
        switchCamera.reactive.controlEvents(.touchUpInside).observe { (action) in
            self.cacheMeViewModel.changeCamera()
        }
        self.view.addSubview(switchCamera)
        switchCamera.snp.makeConstraints { (make) in
            make.right.equalTo(self.view.snp.right).offset(-18)
            make.size.equalTo(CGSize.init(width: 60, height: 60))
            make.centerY.equalTo(self.view.snp.centerY).offset(-36)
        }
    }
    
    //娃娃详情 2.0
    func setUpShowDollsDetail(){
        showDollsDetail = AnimationButton.init(type: .custom)
        showDollsDetail.setImage(UIImage.init(named: "camera"), for: .normal)
        showDollsDetail.backgroundColor = UIColor.init(hexString: App_Theme_000000_Color, andAlpha: 0.3)
        showDollsDetail.layer.cornerRadius = 30
        showDollsDetail.layer.masksToBounds = true
        showDollsDetail.titleLabel?.textAlignment = .center
        showDollsDetail.reactive.controlEvents(.touchUpInside).observe { (action) in
            self.dollDetailView.isHidden = false
            AnimationTools.shareInstance.showViewAnimation(view: self.dollDetailView, frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT), finish: { (ret) in
                AnimationTools.shareInstance.scalBigToNormalAnimation(view: self.dollDetailView.dollDetailView)
            })
        }
        self.view.addSubview(showDollsDetail)
        showDollsDetail.snp.makeConstraints { (make) in
            make.right.equalTo(self.view.snp.right).offset(-18)
            make.size.equalTo(CGSize.init(width: 60, height: 60))
            make.centerY.equalTo(self.view.snp.centerY).offset(36)
        }
    }
    
    func changeCameraType(type:CameraType) {
        self.localPreView.isHidden = false
        if type == .Font {
            if !self.liveplayerA.isPlaying(){
                self.localPreView.isHidden = false
                if self.nELivePlayerLoadFailView != nil {
                    self.nELivePlayerLoadFailView.isHidden = false
                }
            }else{
                self.localPreView.isHidden = true
                if self.nELivePlayerLoadFailView != nil {
                    self.nELivePlayerLoadFailView.isHidden = true
                }
            }
        }else{
            if !self.liveplayerB.isPlaying(){
                self.localPreView.isHidden = false
                if self.nELivePlayerLoadFailView != nil {
                    self.nELivePlayerLoadFailView.isHidden = false
                }
            }else{
                self.localPreView.isHidden = true
                if self.nELivePlayerLoadFailView != nil {
                    self.nELivePlayerLoadFailView.isHidden = true
                }
            }
        }
    }
    
    @objc func playGame(){
        cacheMeViewModel.gameStart()
    }
    
    func doInitPlayerNotication(){
        // 播放器媒体流初始化完成后触发，收到该通知表示可以开始播放
        NotificationCenter.default.addObserver(self, selector: #selector(self.NELivePlayerDidPreparedToPlay(notification:)), name: NSNotification.Name.NELivePlayerDidPreparedToPlay, object: self.liveplayerA)

         NotificationCenter.default.addObserver(self, selector: #selector(self.NELivePlayerDidPreparedToPlay(notification:)), name: NSNotification.Name.NELivePlayerDidPreparedToPlay, object: self.liveplayerB)
        // 播放器加载状态发生变化时触发，如开始缓冲，缓冲结束
        NotificationCenter.default.addObserver(self,
            selector:#selector(self.NeLivePlayerloadStateChanged(notification:)),
            name:NSNotification.Name.NELivePlayerLoadStateChanged ,
            object:self.liveplayerA)
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(self.NeLivePlayerloadStateChanged(notification:)),
                                               name:NSNotification.Name.NELivePlayerLoadStateChanged ,
                                               object:self.liveplayerB)
//
        // 正常播放结束或播放过程中发生错误导致播放结束时触发的通知
        NotificationCenter.default.addObserver(self,
            selector:#selector(self.NELivePlayerPlayBackFinished(notification:)),
            name:NSNotification.Name.NELivePlayerPlaybackFinished,
            object:self.liveplayerA)
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(self.NELivePlayerPlayBackFinished(notification:)),
                                               name:NSNotification.Name.NELivePlayerPlaybackFinished,
                                               object:self.liveplayerB)
//
        // 第一帧视频图像显示时触发的通知
        NotificationCenter.default.addObserver(self,
            selector:#selector(self.NELivePlayerFirstVideoDisplayed(notification:)),
            name:NSNotification.Name.NELivePlayerFirstVideoDisplayed,
            object:self.liveplayerA)
        
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(self.NELivePlayerFirstVideoDisplayedB(notification:)),
                                               name:NSNotification.Name.NELivePlayerFirstVideoDisplayed,
                                               object:self.liveplayerB)
        // 资源释放成功后触发的通知
        NotificationCenter.default.addObserver(self,
            selector:#selector(self.NELivePlayerReleaseSuccess(notification:)),
            name:NSNotification.Name.NELivePlayerReleaseSueecss,
            object:self.liveplayerA)
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(self.NELivePlayerReleaseSuccess(notification:)),
                                               name:NSNotification.Name.NELivePlayerReleaseSueecss,
                                               object:self.liveplayerB)
//        // 视频码流解析失败时触发的通知

        NotificationCenter.default.addObserver(self,
            selector:#selector(self.NELivePlayerVideoParseError(notification:)),
            name:NSNotification.Name.NELivePlayerVideoParseError,
            object:self.liveplayerA)
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(self.NELivePlayerVideoParseError(notification:)),
                                               name:NSNotification.Name.NELivePlayerVideoParseError,
                                               object:self.liveplayerB)
    }
    
    @objc func NELivePlayerDidPreparedToPlay(notification:Notification){
//        self.liveplayerA.play()
    }
    
    @objc func NeLivePlayerloadStateChanged(notification:Notification){
        
    }
    
    @objc func NELivePlayerPlayBackFinished(notification:Notification){
//        if (notification.userInfo! as NSDictionary).object(forKey: "NELivePlayerPlaybackDidFinishErrorUserInfoKey")! as! Int == -1002 {
//            self.setUpNELivePlayerLoadFailView()
//        }
    }
    
    @objc func NELivePlayerFirstVideoDisplayed(notification:Notification) {
        if self.liveplayerA != nil && self.liveplayerA.isPlaying() {
            isHaveLiverAData = true
            self.isHaveAStreamData(waitingTime: -1)
        }
    }
    
    @objc func NELivePlayerFirstVideoDisplayedB(notification:Notification) {
        if self.liveplayerB != nil && self.liveplayerB.isPlaying() {
            isHaveLiverBData = true
            self.isHaveBStreamData(waitingTime: -1)
        }
    }
    
    @objc func NELivePlayerFirstAudioDisplayed(notification:Notification) {
        
    }
        
    @objc func NELivePlayerReleaseSuccess(notification:Notification){
        
    }
    
    @objc func NELivePlayerVideoParseError(notification:Notification){
        self.cacheMeViewModel.setUpStreamData()
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
