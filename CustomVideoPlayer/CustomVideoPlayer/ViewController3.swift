//
//  ViewController3.swift
//  CustomVideoPlayer
//
//  Created by 황정현 on 2023/02/02.
//

import UIKit

class ViewController3: UIViewController {
    
    private var videoPlayerView: VideoPlayerView = VideoPlayerView()
    private var infoView: UIView = UIView()
    
    private var videoPlayerHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()
        delegateConfigure()
        notificationConfigure()
    }
    
    override var prefersStatusBarHidden: Bool {
        switch videoPlayerView.videoPlayerControlView.screenSizeControlButton.testScreenSizeStatus {
        case .full:
            return true
        case .normal:
            return false
        }
    }
    
    func setUpLayout() {
        
        // TEST
        view.backgroundColor = .black
        
        let safeArea = view.safeAreaLayoutGuide
        let screenWidth = UIScreen.main.bounds.width
        
        let videoPlayerViewHeight = screenWidth * 9/16
        
        
        let bottomView: UIView = UIView()
        view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            bottomView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: videoPlayerViewHeight)
        ])
        
        infoView.backgroundColor = .yellow
        view.addSubview(infoView)
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            infoView.topAnchor.constraint(equalTo: bottomView.bottomAnchor),
            infoView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        videoPlayerHeightConstraint = videoPlayerView.heightAnchor.constraint(equalToConstant: videoPlayerViewHeight)
        view.addSubview(videoPlayerView)
        videoPlayerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            videoPlayerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            videoPlayerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            videoPlayerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            videoPlayerHeightConstraint
        ])
    }
    
    func delegateConfigure() {
        videoPlayerView.videoPlayerControlView.screenSizeControlButton.delegate = self
        videoPlayerView.videoPlayerControlView.playStatusControlButton.delegate = self
    }
    
    func notificationConfigure() {
        let notificationCenter = NotificationCenter.default
        
        // CASE1: ToBackground 시 재생 버튼 이미지 전환
        notificationCenter.addObserver(self, selector: #selector(toBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
        // CASE2: ToForeground 시 다시 재생
        notificationCenter.addObserver(self, selector: #selector(toForeground),name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    // CASE1 objc func
    @objc private func toBackground() {
        if videoPlayerView.videoPlayerControlView.playStatusControlButton.testPlayStatus == .play {
            videoPlayerView.videoPlayerControlView.playStatusControlButton.changeButtonImage()
        }
    }
    
    // CASE2 objc func
    @objc private func toForeground() {
        if videoPlayerView.videoPlayerControlView.playStatusControlButton.testPlayStatus == .play {
            videoPlayerView.replay()
        }
    }
    
}

extension ViewController3: ScreenSizeControlButtonDelegate
{
    func changeScreenSize(screenSizeStatus: ScreenSizeStatus) {
        var infoViewAlphaValue: CGFloat = 0.0
        switch screenSizeStatus {
        case .normal:
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.orientationLock = .portrait
            }
            self.setNeedsUpdateOfSupportedInterfaceOrientations()
            
            let videoPlayerViewHeight = UIScreen.main.bounds.height * 9 / 16
            videoPlayerHeightConstraint.constant = videoPlayerViewHeight
            infoViewAlphaValue = 1.0
        case .full:
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.orientationLock = .landscapeRight
            }
            self.setNeedsUpdateOfSupportedInterfaceOrientations()
            
            let videoPlayerViewHeight = UIScreen.main.bounds.width
            videoPlayerHeightConstraint.constant = videoPlayerViewHeight
            infoViewAlphaValue = 0.0
        }
        UIView.animate(withDuration: 0.3, delay: TimeInterval(0.0), animations: { [self] in
            infoView.alpha = infoViewAlphaValue
            view.layoutIfNeeded()
        })
    }
}

extension ViewController3: PlayStatusControlButtonDelegate {
    func changePlayStatus(playStatus: PlayStatus) {
        switch playStatus {
        case .play:
            videoPlayerView.replay()
        case .pause:
            videoPlayerView.pause()
        }
    }
}
