//
//  ViewController.swift
//  CustomVideoPlayer
//
//  Created by 황정현 on 2023/01/11.
//

import UIKit


class ViewController: UIViewController {
    
    private var videoPlayerView: VideoPlayerView = VideoPlayerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()
        delegateConfigure()
    }

    func setUpLayout() {
        
        // TEST
        view.backgroundColor = .black
        
        let safeArea = view.safeAreaLayoutGuide
        let screenWidth = UIScreen.main.bounds.width
        
        let videoPlayerViewHeight = screenWidth * 9/16
        
        view.addSubview(videoPlayerView)
        videoPlayerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            videoPlayerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            videoPlayerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            videoPlayerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            videoPlayerView.heightAnchor.constraint(equalToConstant: videoPlayerViewHeight)
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

extension ViewController: ScreenSizeControlButtonDelegate
{
    func changeScreenSize(screenSizeStatus: ScreenSizeStatus) {
        let screen = UIScreen.main.bounds
        switch screenSizeStatus {
        case .normal:
            self.videoPlayerView.layer.anchorPoint = CGPointMake(0.5, 0.5)
            UIView.animate(withDuration: 0.3, delay: TimeInterval(0.0), animations: { [self] in
                videoPlayerView.transform = CGAffineTransformTranslate(videoPlayerView.transform, 0, 0)
                videoPlayerView.transform = CGAffineTransform(rotationAngle: 0.0)
                videoPlayerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)
            })
        case .full:
            UIView.animate(withDuration: 0.3, delay: TimeInterval(0.0), animations: { [self] in
                self.videoPlayerView.layer.anchorPoint = CGPointMake(0.1, 0.5)
                videoPlayerView.transform = CGAffineTransform(rotationAngle: .pi/2.0)
                videoPlayerView.transform = CGAffineTransformScale(videoPlayerView.transform, 16.0/9.0, 16.0/9.0)
            })
        }
    }
}
