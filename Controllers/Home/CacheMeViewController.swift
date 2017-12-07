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

class CacheMeViewController: BaseViewController {

    var liveplayer:NELivePlayer!
    var player:NELivePlayerController!

    var localPreView:LocalPreView!
    var bottomToolsView:CacheMeToolsView!
    var cacheMeTopView:CacheMeTopView!
    var cacheMePlayUserView:CacheMePlayUserView!
    var gameToolsView:GameToolsView!
    var switchCamera:UIButton!
    
    var remoteGLView:UIImageView!
    
    var roomModel:Labels!
    
    var countDown:UILabel!
    
    var time:Timer!
    
    var cacheMeViewModel = CacheMeViewModel()
    var url:String = ""
    var addToCacth:UIButton!
    
    var isQuickEnter:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        self.bindViewModel(viewModel: cacheMeViewModel, controller: self)
        self.setUpFontToolsView()
        self.bindLogicViewModel()
        self.doInitPlayerNotication()
        self.initRemoteGlView()
        // Do any additional setup after loading the view.
    }
    
    deinit {
        if time != nil {
            time.invalidate()
        }
        // 播放器媒体流初始化完成后触发，收到该通知表示可以开始播放
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NELivePlayerDidPreparedToPlay, object: self.liveplayer)
        // 播放器加载状态发生变化时触发，如开始缓冲，缓冲结束
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NELivePlayerLoadStateChanged, object: self.liveplayer)
        //
        // 正常播放结束或播放过程中发生错误导致播放结束时触发的通知
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NELivePlayerPlaybackFinished, object: self.liveplayer)
        //
        // 第一帧视频图像显示时触发的通知
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NELivePlayerFirstVideoDisplayed, object: self.liveplayer)
        //
        // 第一帧音频播放时触发的通知
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NELivePlayerFirstAudioDisplayed, object: self.liveplayer)
        // 资源释放成功后触发的通知
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NELivePlayerReleaseSueecss, object: self.liveplayer)
        // 视频码流解析失败时触发的通知
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NELivePlayerVideoParseError, object: self.liveplayer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func bindLogicViewModel(){
        cacheMeViewModel.cacheMeController = self
        cacheMeViewModel.model = self.roomModel
        if isQuickEnter {
            cacheMeViewModel.requestQuickEntRooms()
        }else{
            cacheMeViewModel.requestEntRooms()
        }
    }
    
    //拉流地址
    func setUpPlayer(url:String){
        NELivePlayerController.setLogLevel(NELPLogLevel.LOG_VERBOSE)
        do {
            try self.liveplayer = NELivePlayerController.init(contentURL: URL.init(string: url))

            self.liveplayer.setScalingMode(NELPMovieScalingMode.init(0))
            self.liveplayer.setHardwareDecoder(true)
            self.view.addSubview(self.liveplayer.view)
            self.liveplayer.view.layer.borderWidth = 0.0001
            self.liveplayer.view.layer.borderColor = UIColor.clear.cgColor
            self.liveplayer.view.layer.cornerRadius = 10
            self.liveplayer.view.layer.masksToBounds = true
            self.liveplayer.view.snp.makeConstraints({ (make) in
                make.centerX.equalTo(self.view.snp.centerX).offset(0)
                make.top.equalTo(self.view.snp.top).offset(64)
                make.bottom.equalTo(self.view.snp.bottom).offset(-122)
                make.size.equalTo(CGSize.init(width: (SCREENHEIGHT - 122 - 64) * 3 / 4, height: SCREENHEIGHT - 122 - 64))
            })
            
            self.view.autoresizesSubviews = true
            self.liveplayer.view.isUserInteractionEnabled = true
            self.liveplayer.setBufferStrategy(NELPBufferStrategy.init(2))
            self.liveplayer.shouldAutoplay = true
            self.liveplayer.setPlaybackTimeout(15 * 1000)
            self.liveplayer.prepareToPlay()
            
            self.setUpPlayUserView()
            self.setUpCameraView()
            self.view.bringSubview(toFront: cacheMeTopView)
            //拉流地址设置成功后执行拉流的一些界面创建
            //根据通知的状态来隐藏和显示视图
            
        } catch {
            print("拉流失败")
            return
        }
        
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
    
    //创建进来时本地加载界面 后期可能是显示自己的视频，前期显示加载
    func setUpPlayGameView(){
        localPreView = LocalPreView.init()
        localPreView.layer.masksToBounds = true
        localPreView.layer.cornerRadius = 10
        self.view.addSubview(localPreView)
        self.localPreView.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(self.view.snp.top).offset(64)
            make.bottom.equalTo(self.view.snp.bottom).offset(-122)
            make.size.equalTo(CGSize.init(width: (SCREENHEIGHT - 122 - 64) * 3 / 4, height: SCREENHEIGHT - 122 - 64))
        })
    }
    
    //创建游戏者视频界面
    func initRemoteGlView(){
        remoteGLView = UIImageView.init()
        remoteGLView.isHidden = true
        remoteGLView.layer.cornerRadius = 10
        remoteGLView.layer.masksToBounds = true
        self.view.addSubview(remoteGLView)
        self.remoteGLView.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(self.view.snp.top).offset(64)
            make.bottom.equalTo(self.view.snp.bottom).offset(-122)
            make.size.equalTo(CGSize.init(width: (SCREENHEIGHT - 122 - 64) * 3 / 4, height: SCREENHEIGHT - 122 - 64))
        })
    }
    
    //创建底部工具界面
    func setUpToolsView() {
        bottomToolsView = CacheMeToolsView.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 122, width: SCREENWIDTH, height: 122))
        bottomToolsView.cacheMeToolsViewClouse = { tag in
            switch tag {
            case 1:
                let toViewController = JoysDetailViewController()
                toViewController.url = "\(DollsDetail)\(self.roomModel.skuId)"
                NavigationPushView(self, toConroller: toViewController)
            case 2:
                self.playGame()
            default:
                self.cacheMeViewModel.gotoTopUpVC()
            }
        }
        self.view.addSubview(bottomToolsView)
    }
    
    //创建顶部导航栏
    func setUpCacheMeTopView(){
        cacheMeTopView = CacheMeTopView.init(frame: CGRect.init(x: 0, y: 20, width: SCREENWIDTH, height: 44), topViewBackButtonClouse: {
            self.cacheMeViewModel.requestExitRooms()
            self.navigationController?.popViewController({
                
            })
        })
        self.view.addSubview(cacheMeTopView)
        self.view.bringSubview(toFront: cacheMeTopView)
    }
    
    //创建正在玩用户视图
    func setUpPlayUserView(){
        if cacheMePlayUserView == nil {
            self.cacheMePlayUserView = CacheMePlayUserView.init(frame: CGRect.init(x: self.liveplayer.view.frame.minX, y: self.liveplayer.view.frame.minY + 11, width: 200, height: 57))
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
            default:
                //go
                self.cacheMeViewModel.playGameGo()
            }
        })
        self.gameToolsView.timeDownClouse = {
            self.cacheMeViewModel.playGameGo()
        }
        self.gameToolsView.isHidden = true
        self.view.addSubview(gameToolsView)
    }
    //切换摄像头
    func setUpCameraView(){
        switchCamera = UIButton.init(type: .custom)
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
            make.right.equalTo(self.view.snp.right).offset(-10)
            make.size.equalTo(CGSize.init(width: 60, height: 60))
            make.centerY.equalTo(self.view.snp.centerY).offset(-20)
        }
    }
    
    @objc func playGame(){
        cacheMeViewModel.gameStart()
    }
    
    func doInitPlayerNotication(){
        // 播放器媒体流初始化完成后触发，收到该通知表示可以开始播放
        NotificationCenter.default.addObserver(self, selector: #selector(self.NELivePlayerDidPreparedToPlay(notification:)), name: NSNotification.Name.NELivePlayerDidPreparedToPlay, object: self.liveplayer)

        // 播放器加载状态发生变化时触发，如开始缓冲，缓冲结束
        NotificationCenter.default.addObserver(self,
            selector:#selector(self.NeLivePlayerloadStateChanged(notification:)),
            name:NSNotification.Name.NELivePlayerLoadStateChanged ,
            object:self.liveplayer)
//
        // 正常播放结束或播放过程中发生错误导致播放结束时触发的通知
        NotificationCenter.default.addObserver(self,
            selector:#selector(self.NELivePlayerPlayBackFinished(notification:)),
            name:NSNotification.Name.NELivePlayerPlaybackFinished,
            object:self.liveplayer)
//
        // 第一帧视频图像显示时触发的通知
        NotificationCenter.default.addObserver(self,
            selector:#selector(self.NELivePlayerFirstVideoDisplayed(notification:)),
            name:NSNotification.Name.NELivePlayerFirstVideoDisplayed,
            object:self.liveplayer)
//
        // 第一帧音频播放时触发的通知
        NotificationCenter.default.addObserver(self,
            selector:#selector(self.NELivePlayerFirstAudioDisplayed(notification:)),
            name:NSNotification.Name.NELivePlayerFirstAudioDisplayed,
            object:self.liveplayer)
        // 资源释放成功后触发的通知
        NotificationCenter.default.addObserver(self,
            selector:#selector(self.NELivePlayerReleaseSuccess(notification:)),
            name:NSNotification.Name.NELivePlayerReleaseSueecss,
            object:self.liveplayer)
//        // 视频码流解析失败时触发的通知

        NotificationCenter.default.addObserver(self,
            selector:#selector(self.NELivePlayerVideoParseError(notification:)),
            name:NSNotification.Name.NELivePlayerVideoParseError,
            object:self.liveplayer)
    }
    
    @objc func NELivePlayerDidPreparedToPlay(notification:Notification){
        self.liveplayer.play()
    }
    
    @objc func NeLivePlayerloadStateChanged(notification:Notification){
        
    }
    
    @objc func NELivePlayerPlayBackFinished(notification:Notification){
        
    }
    
    @objc func NELivePlayerFirstVideoDisplayed(notification:Notification) {
        if self.localPreView != nil {
            self.localPreView.isHidden = true
        }
    }
    
    @objc func NELivePlayerFirstAudioDisplayed(notification:Notification) {
        
    }
        
    @objc func NELivePlayerReleaseSuccess(notification:Notification){
        
    }
    
    @objc func NELivePlayerVideoParseError(notification:Notification){
        
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
