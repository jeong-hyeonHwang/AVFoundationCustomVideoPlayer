//
//  ViewController.swift
//  CustomVideoPlayer
//
//  Created by 황정현 on 2023/01/11.
//

import UIKit

class ViewController: UIViewController {

    private var videoPlayerView: UIView = VideoPlayerView()
    private var screenSizeControlButton: ScreenSizeControlButton = ScreenSizeControlButton()
    private var playStatusControlButton: PlayStatusControlButton = PlayStatusControlButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TEST
        view.backgroundColor = .white
        
        setUpLayout()
    }

    func setUpLayout() {
        
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
        
        let buttonSize = screenWidth / 12
        videoPlayerView.addSubview(screenSizeControlButton)
        screenSizeControlButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            screenSizeControlButton.widthAnchor.constraint(equalToConstant: buttonSize),
            screenSizeControlButton.heightAnchor.constraint(equalToConstant: buttonSize),
            screenSizeControlButton.trailingAnchor.constraint(equalTo: videoPlayerView.trailingAnchor),
            screenSizeControlButton.bottomAnchor.constraint(equalTo: videoPlayerView.bottomAnchor)
        ])
        
        videoPlayerView.addSubview(playStatusControlButton)
        playStatusControlButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playStatusControlButton.widthAnchor.constraint(equalToConstant: buttonSize),
            playStatusControlButton.heightAnchor.constraint(equalToConstant: buttonSize),
            playStatusControlButton.leadingAnchor.constraint(equalTo: videoPlayerView.leadingAnchor),
            playStatusControlButton.bottomAnchor.constraint(equalTo: videoPlayerView.bottomAnchor)
        ])
    }
}

