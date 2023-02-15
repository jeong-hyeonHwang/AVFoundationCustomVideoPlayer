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
    
    private var liveMarkLeadingConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var liveMarkTopConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var videoPlayerWidthConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var videoPlayerHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    private var liveMarkView: LiveMarkView = LiveMarkView()
    
    private var screenWidth: CGFloat = CGFloat()
    private var firstAttempt: Bool = true
    
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
    
    override var prefersHomeIndicatorAutoHidden: Bool {
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
        screenWidth = UIScreen.main.bounds.width
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
        
        videoPlayerWidthConstraint = videoPlayerView.widthAnchor.constraint(equalToConstant: screenWidth)
        videoPlayerHeightConstraint = videoPlayerView.heightAnchor.constraint(equalToConstant: videoPlayerViewHeight)
        
        view.addSubview(videoPlayerView)
        videoPlayerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            videoPlayerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            videoPlayerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            videoPlayerWidthConstraint,
            videoPlayerHeightConstraint
        ])
        
        
        liveMarkLeadingConstraint = liveMarkView.leadingAnchor.constraint(equalTo: videoPlayerView.leadingAnchor, constant: 8)
        liveMarkTopConstraint = liveMarkView.topAnchor.constraint(equalTo: videoPlayerView.topAnchor, constant: 8)
        
        view.addSubview(liveMarkView)
        liveMarkView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            liveMarkLeadingConstraint,
            liveMarkTopConstraint,
            liveMarkView.widthAnchor.constraint(equalToConstant: screenWidth / 8),
            liveMarkView.heightAnchor.constraint(equalToConstant: screenWidth / 18)
        ])
        
        liveMarkView.setUpLiveLabelRadius(to: screenWidth / 36)
    }
    
    func delegateConfigure() {
        videoPlayerView.videoPlayerControlView.screenSizeControlButton.delegate = self
        videoPlayerView.videoPlayerControlView.playStatusControlButton.delegate = self
    }
    
    func notificationConfigure() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(toBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(toForeground),name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc private func toBackground() {
        firstAttempt = false
    }
    
    @objc private func toForeground() {
        if !firstAttempt {
            videoPlayerView.playVideo()
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
            
            let videoPlayerViewHeight = screenWidth * 9 / 16
            
            videoPlayerWidthConstraint.constant = screenWidth
            videoPlayerHeightConstraint.constant = videoPlayerViewHeight
            
            videoPlayerView.videoPlayerControlView.screenSizeControlButtonTrailingConstraint.constant = -4
            videoPlayerView.videoPlayerControlView.screenSizeControlButtonBottomConstraint.constant = -4
            liveMarkLeadingConstraint.constant = 8
            liveMarkTopConstraint.constant = 8
            infoViewAlphaValue = 1.0
        case .full:
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.orientationLock = .landscapeRight
            }
            self.setNeedsUpdateOfSupportedInterfaceOrientations()
            
            let videoPlayerViewHeight = UIScreen.main.bounds.width
            let videoPlayerViewWidth = videoPlayerViewHeight * 16 / 9
            
            videoPlayerWidthConstraint.constant = videoPlayerViewWidth
            videoPlayerHeightConstraint.constant = videoPlayerViewHeight
            liveMarkLeadingConstraint.constant = 16
            liveMarkTopConstraint.constant = 16
            videoPlayerView.videoPlayerControlView.screenSizeControlButtonTrailingConstraint.constant = -16
            videoPlayerView.videoPlayerControlView.screenSizeControlButtonBottomConstraint.constant = -16
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
