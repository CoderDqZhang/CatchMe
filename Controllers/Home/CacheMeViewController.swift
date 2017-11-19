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

    var localPreView:UIView!
    
    var url:String = "rtmp://vbd0442e6.live.126.net/live/0567baeb9b0d4780a06ac394f2f26d9e"
    var addToCacth:UIButton!
    
    override func viewDidLoad() {
        NIMAVChatSDK.shared().netCallManager.add(self)
        super.viewDidLoad()
        self.setUpPlayer()
        self.doInitPlayerNotication()
        self.setUpPlayGameView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setUpPlayer(){
//        NELivePlayerController.setLogLevel(NELPLogLevel.LOG_VERBOSE)
//        do {
//            try self.liveplayer = NELivePlayerController.init(contentURL: URL.init(string: self.url))
//            self.liveplayer.setHardwareDecoder(true)
//            self.view.addSubview(self.liveplayer.view)
//            self.liveplayer.view.snp.makeConstraints({ (make) in
//                make.left.equalTo(self.view.snp.left).offset(0)
//                make.right.equalTo(self.view.snp.right).offset(0)
//                make.top.equalTo(self.view.snp.top).offset(0)
//                make.bottom.equalTo(self.view.snp.bottom).offset(0)
//            })
//            self.view.autoresizesSubviews = true
//            self.liveplayer.setBufferStrategy(NELPBufferStrategy.init(2))
//            self.liveplayer.shouldAutoplay = true
//            self.liveplayer.setPlaybackTimeout(15 * 1000)
//            self.liveplayer.prepareToPlay()
//        } catch {
//            print("创建失败")
//            return
//        }
        
    }
    
    func setUpPlayGameView(){
        localPreView = UIView.init()
        localPreView.backgroundColor = UIColor.red
        localPreView.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT)
//        localPreView = NIMAVChatSDK.shared().netCallManager.localPreview()
        self.view.addSubview(localPreView)
        
        
    }
    
    func videoCallingInterface(){
        let status = NIMAVChatSDK.shared().netCallManager.netStatus("lingwen")
        
    }
    
    func initRemoteGlView(){
        remoteGLView = NTESGLView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
//        remoteGLView.contentMode = NTESBundleSetting.s
//        [_remoteGLView setContentMode:[[NTESBundleSetting sharedConfig] videochatRemoteVideoContentMode]];
        remoteGLView.backgroundColor = UIColor.blue
        self.view.addSubview(remoteGLView)
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "点击", style: .plain, target: self, action: #selector(CacheMeViewController.rightButtonPress))
    }
    
    @objc func rightButtonPress(){
        let option = NIMNetCallOption.init()
//        let videoCaption = NIMNetCallVideoCaptureParam.init()
//        videoCaption.startWithBackCamera = true
//        option.videoCaptureParam = videoCaption
        
        NIMAVChatSDK.shared().netCallManager.start(["lingwen5"], type: NIMNetCallMediaType.video, option: option) { (error, ret) in
            if error == nil {
            }
        }
        
    }
    
    func doDestroyPlay(){
        self.liveplayer.shutdown()
        self.liveplayer.view.removeFromSuperview()
        self.liveplayer = nil
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

extension CacheMeViewController : NIMNetCallManagerDelegate {
    //本地摄像头
    func onLocalDisplayviewReady(_ displayView: UIView) {
        self.localPreView = displayView
        displayView.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT)
        displayView.backgroundColor = UIColor.blue
        self.localPreView.addSubview(displayView)
    }
    
    func onRemoteImageReady(_ image: CGImage) {
        
    }
    
    func onAudioMixTaskCompleted() {
        
    }
    
    func onRemoteYUVReady(_ yuvData: Data, width: UInt, height: UInt, from user: String) {
        if self.remoteGLView == nil {
            self.initRemoteGlView()
        }
        self.remoteGLView.render(yuvData, width: width, height: height)
    }
    
    func onControl(_ callID: UInt64, from user: String, type control: NIMNetCallControlType) {
        
    }
    
    func onCallEstablished(_ callID: UInt64) {
        print("连接成功\(callID)")
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
}
