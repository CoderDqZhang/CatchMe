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
    var remoteGLView:NTESGLView!

    var localPreView:LocalPreView!
    var bottomToolsView:CacheMeToolsView!
    var cacheMeTopView:CacheMeTopView!
    var gameToolsView:GameToolsView!
    var switchCamera:UIButton!
    
    var countDown:UILabel!
    
    var time:Timer!
    
    var cacheMeViewModel = CacheMeViewModel()
    var url:String = "rtmp://vbd0442e6.live.126.net/live/0567baeb9b0d4780a06ac394f2f26d9e"
    var addToCacth:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel(viewModel: cacheMeViewModel, controller: self)
        NIMAVChatSDK.shared().netCallManager.add(cacheMeViewModel)
        self.bindLogicViewModel()
        self.initRemoteGlView()
        self.setUpPlayer()
        self.doInitPlayerNotication()
        self.setUpPlayGameView()
        self.setUpToolsView()
        self.setUpCacheMeTopView()
        self.setUpCameraView()
        self.setUpGameView()
        
        // Do any additional setup after loading the view.
    }
    
    deinit {
        time.invalidate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    
    func bindLogicViewModel(){
        cacheMeViewModel.cacheMeController = self
    }
    
    func setUpPlayer(){
        NELivePlayerController.setLogLevel(NELPLogLevel.LOG_VERBOSE)
        do {
            try self.liveplayer = NELivePlayerController.init(contentURL: URL.init(string: self.url))
            self.liveplayer.setScalingMode(NELPMovieScalingMode.init(0))
            self.liveplayer.setHardwareDecoder(true)
            self.view.addSubview(self.liveplayer.view)
            self.liveplayer.view.snp.makeConstraints({ (make) in
                make.left.equalTo(self.view.snp.left).offset(0)
                make.right.equalTo(self.view.snp.right).offset(0)
                make.top.equalTo(self.view.snp.top).offset(0)
                make.bottom.equalTo(self.view.snp.bottom).offset(0)
            })
            self.view.autoresizesSubviews = true
            self.liveplayer.setBufferStrategy(NELPBufferStrategy.init(2))
            self.liveplayer.shouldAutoplay = true
            self.liveplayer.setPlaybackTimeout(15 * 1000)
            self.liveplayer.prepareToPlay()
        } catch {
            print("拉流失败")
            return
        }
        
    }
    
    func setUpCountDown(isPlay:Bool, text:String) {
        if self.countDown != nil {
            self.countDown.isHidden = !isPlay
            self.countDown.text = text
        }
    }
    
    //创建进来时本地加载界面 后期可能是显示自己的视频，前期显示加载
    func setUpPlayGameView(){
        localPreView = LocalPreView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
        self.view.addSubview(localPreView)
    }
    
    //创建游戏者视频界面
    func initRemoteGlView(){
        remoteGLView = NTESGLView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
        remoteGLView.backgroundColor = UIColor.init(hexString: App_Theme_000000_Color, andAlpha: 0.01)
        remoteGLView.isHidden = true
        self.view.addSubview(remoteGLView)
    }
    
    //创建底部工具界面
    func setUpToolsView() {
        bottomToolsView = CacheMeToolsView.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 78, width: SCREENWIDTH, height: 78))
        bottomToolsView.cacheMeToolsViewClouse = { tag in
            switch tag {
            case 1:
                NavigationPushView(self, toConroller: JoysDetailViewController())
            case 2:
                self.playGame()
            default:
                NavigationPushView(self, toConroller: TopUpViewController())
            }
        }
        self.view.addSubview(bottomToolsView)
    }
    
    //创建顶部导航栏
    func setUpCacheMeTopView(){
        cacheMeTopView = CacheMeTopView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 60), topViewBackButtonClouse: {
            self.cacheMeViewModel.handUpConnect()
            self.navigationController?.popViewController({
                
            })
        })
        self.view.addSubview(cacheMeTopView)
    }
    
    //创建游戏手柄
    func setUpGameView(){
        gameToolsView = GameToolsView.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 202, width: SCREENWIDTH, height: 202), gameToolsViewClouse: { (tag) in
            switch tag {
            case 1,2,3,4:
                //上//左//下//右
                self.cacheMeViewModel.playGameLogic(tag: tag)
                break
            default:
                //go
                self.cacheMeViewModel.playGameGo()
            }
        })
        self.gameToolsView.isHidden = true
        self.gameToolsView.backgroundColor = UIColor.clear
        self.view.addSubview(gameToolsView)
    }
    
    //倒计时
    func setUpCountDownView(){
        if countDown == nil {
            countDown = UILabel.init()
            countDown.isHidden = false
            countDown.backgroundColor = UIColor.clear
            countDown.layer.masksToBounds = true
            countDown.textAlignment = .center
            countDown.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            countDown.font = App_Theme_PinFan_M_28_Font
            self.countDown.text = "36"
            self.view.addSubview(countDown)
            countDown.snp.makeConstraints { (make) in
                make.right.equalTo(self.view.snp.right).offset(-61)
                make.bottom.equalTo(self.view.snp.bottom).offset(-141)
            }
            if #available(iOS 10.0, *) {
                if time == nil {
                    time = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (time) in
                        let count = (self.countDown.text! as NSString).integerValue
                        let now = count -  1
                        if now == 0 {
                            //执行go
                            return
                        }
                        self.countDown.text = "\(now)"
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        }
        
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
            
        }
        self.view.addSubview(switchCamera)
        switchCamera.snp.makeConstraints { (make) in
            make.right.equalTo(self.view.snp.right).offset(-10)
            make.size.equalTo(CGSize.init(width: 60, height: 60))
            make.centerY.equalTo(self.view.snp.centerY).offset(-20)
        }
    }
    
    @objc func playGame(){
        self.cacheMeViewModel.doDestroyPlay()
        self.setUpCountDownView()
        cacheMeViewModel.playGame()
//        let option = NIMNetCallOption.init()
//        NIMAVChatSDK.shared().netCallManager.start(["caiji"], type: NIMNetCallMediaType.video, option: option) { (error, ret) in
//            if error == nil {
//                self.cacheMeViewModel.doDestroyPlay()
//                self.setUpCountDownView()
//            }else{
//                print(error!)
//            }
//        }
    }
    
    func doInitPlayerNotication(){
//        NotificationCenter.default.addObserver(self, selector: #selector(NELivePlayerDidPreparedToPlay(notification:)), name: NELivePlayerDidPreparedToPlayNotification, object: self.liveplayer)
//
//
//        NotificationCenter.default.addObserver(self, selector: #selector(NELivePlayerDidPreparedToPlay(notification:)), name: NELivePlayerDidPreparedToPlayNotification, object: self.liveplayer)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(NELivePlayerDidPreparedToPlay(notification:)), name: NELivePlayerDidPreparedToPlayNotification, object: self.liveplayer)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(NELivePlayerDidPreparedToPlay(notification:)), name: NELivePlayerDidPreparedToPlayNotification, object: self.liveplayer)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(NELivePlayerDidPreparedToPlay(notification:)), name: NELivePlayerDidPreparedToPlayNotification, object: self.liveplayer)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(NELivePlayerDidPreparedToPlay(notification:)), name: NELivePlayerDidPreparedToPlayNotification, object: self.liveplayer)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(NELivePlayerDidPreparedToPlay(notification:)), name: NELivePlayerDidPreparedToPlayNotification, object: self.liveplayer)
//
//        [[NSNotificationCenter defaultCenter] addObserver:self
//            selector:@selector(NELivePlayerVideoParseError:)
//            name:NELivePlayerVideoParseErrorNotification
//            object:_player];
//
//        [[NSNotificationCenter defaultCenter] addObserver:self
//            selector:@selector(NELivePlayerSeekComplete:)
//            name:NELivePlayerMoviePlayerSeekCompletedNotification
//            object:_player];
    }
    
    func NELivePlayerDidPreparedToPlay(notification:Notification){
        
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
