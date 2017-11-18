//
//  CacheMeViewController.swift
//  CatchMe
//
//  Created by Zhang on 18/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class CacheMeViewController: BaseViewController {

    var liveplayer:NELivePlayer!
    var player:NELivePlayerController!
    
    var url:String = "rtmp://vbd0442e6.live.126.net/live/0567baeb9b0d4780a06ac394f2f26d9e"
    var addToCacth:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpPlayer()
        self.doInitPlayerNotication()
        
        // Do any additional setup after loading the view.
    }
    
    func setUpPlayer(){
        NELivePlayerController.setLogLevel(NELPLogLevel.LOG_VERBOSE)
        do {
            try self.liveplayer = NELivePlayerController.init(contentURL: URL.init(string: self.url))
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
            print("创建失败")
            return
        }
        
    }
    
    override func setUpView(){
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 100, y: 100, width: 100, height: 40)
        button.backgroundColor = UIColor.red
        button.setTitle("播放", for: .normal)
        button.reactive.controlEvents(.touchUpInside).observe { (action) in
            
        }
        self.view.addSubview(button)
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
