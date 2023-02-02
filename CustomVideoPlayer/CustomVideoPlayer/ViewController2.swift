//
//  ViewController2.swift
//  CustomVideoPlayer
//
//  Created by 황정현 on 2023/02/02.
//

import UIKit

class ViewController2: UIViewController {

    private var videoPlayerView: OnlyVideoPlayerView = OnlyVideoPlayerView()
    private var videoPlayerControlView: VideoPlayerControlView = VideoPlayerControlView()
    private var infoView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()
        componentConfigure()
        delegateConfigure()
        notificationConfigure()

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
        
        view.addSubview(videoPlayerView)
        videoPlayerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            videoPlayerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            videoPlayerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            videoPlayerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            videoPlayerView.heightAnchor.constraint(equalToConstant: videoPlayerViewHeight)
        ])
        
        let controlViewHeight = UIScreen.main.bounds.width / 12
        view.addSubview(videoPlayerControlView)
        videoPlayerControlView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            videoPlayerControlView.leadingAnchor.constraint(equalTo: videoPlayerView.leadingAnchor),
            videoPlayerControlView.trailingAnchor.constraint(equalTo: videoPlayerView.trailingAnchor),
            videoPlayerControlView.bottomAnchor.constraint(equalTo: videoPlayerView.bottomAnchor),
            videoPlayerControlView.heightAnchor.constraint(equalToConstant: controlViewHeight)
        ])
        
        videoPlayerControlView.alpha = 0.0
        videoPlayerControlView.isUserInteractionEnabled = true
        
    }
    
    private func componentConfigure() {
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(touchVideoPlayerScreen))
        videoPlayerView.addGestureRecognizer(touchGesture)
    }
    
    func delegateConfigure() {
        videoPlayerControlView.screenSizeControlButton.delegate = self
        videoPlayerControlView.playStatusControlButton.delegate = self
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
        if videoPlayerControlView.playStatusControlButton.testPlayStatus == .play {
            videoPlayerControlView.playStatusControlButton.changeButtonImage()
        }
    }
    
    // CASE2 objc func
    @objc private func toForeground() {
        if videoPlayerControlView.playStatusControlButton.testPlayStatus == .play {
            videoPlayerView.replay()
        }
    }
    
    @objc private func touchVideoPlayerScreen() {
        videoPlayerView.testControlStatus.changeControlStatus(view: videoPlayerControlView)
    }
}

extension ViewController2: ScreenSizeControlButtonDelegate
{
    func changeScreenSize(screenSizeStatus: ScreenSizeStatus) {
        switch screenSizeStatus {
        case .normal:
            self.videoPlayerView.layer.anchorPoint = CGPointMake(0.5, 0.5)
            self.videoPlayerControlView.layer.anchorPoint = CGPointMake(0.5, 0.5)
            UIView.animate(withDuration: 0.3, delay: TimeInterval(0.0), animations: { [self] in
                videoPlayerView.transform = CGAffineTransformTranslate(videoPlayerView.transform, 0, 0)
                videoPlayerView.transform = CGAffineTransform(rotationAngle: 0.0)
                videoPlayerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)
                
                videoPlayerControlView.transform = CGAffineTransformTranslate(videoPlayerControlView.transform, 0, 0)
                videoPlayerControlView.transform = CGAffineTransform(rotationAngle: 0.0)
                videoPlayerControlView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)
                
                [videoPlayerControlView.playStatusControlButton, videoPlayerControlView.screenSizeControlButton].forEach({
                    $0.transform = CGAffineTransformScale($0.transform, 16.0/9.0, 1.0)
                })
                infoView.alpha = 1.0
            })
        case .full:
            UIView.animate(withDuration: 0.3, delay: TimeInterval(0.0), animations: { [self] in
                
                // NON PHYSICAL BUTTON
                self.videoPlayerView.layer.anchorPoint = CGPointMake(0.1, 0.5)
                
                // PHYSICAL BUTTON
                //self.videoPlayerView.layer.anchorPoint = CGPointMake(0.188, 0.5)
                
                videoPlayerView.transform = CGAffineTransform(rotationAngle: .pi/2.0)
                videoPlayerView.transform = CGAffineTransformScale(videoPlayerView.transform, 16.0/9.0, 16.0/9.0)
                
                // NON PHYSICAL BUTTON
                self.videoPlayerControlView.layer.anchorPoint = CGPointMake(0.235, -5.0)
                
                // PHYSICAL BUTTON
                //self.videoPlayerControlView.layer.anchorPoint = CGPointMake(0.3225, -5.0)
                videoPlayerControlView.transform = CGAffineTransform(rotationAngle: .pi/2.0)
                videoPlayerControlView.transform = CGAffineTransformScale(videoPlayerControlView.transform, 16.0/9.0, 1.0)
                [videoPlayerControlView.playStatusControlButton, videoPlayerControlView.screenSizeControlButton].forEach({
                    $0.transform = CGAffineTransformScale($0.transform, 9.0/16.0, 1.0)
                })
                
                infoView.alpha = 0.0
            })
        }
    }
}

extension ViewController2: PlayStatusControlButtonDelegate {
    func changePlayStatus(playStatus: PlayStatus) {
        switch playStatus {
        case .play:
            videoPlayerView.replay()
        case .pause:
            videoPlayerView.pause()
        }
    }
}
