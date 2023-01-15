//
//  ViewController.swift
//  CustomVideoPlayer
//
//  Created by 황정현 on 2023/01/11.
//

import UIKit

class ViewController: UIViewController {

    private var videoPlayerView: VideoPlayerView = VideoPlayerView()
    private var videoPlayerControlView: VideoPlayerControlView = VideoPlayerControlView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()
    }

    func setUpLayout() {
        
        // TEST
        view.backgroundColor = .white
        
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
        
        view.addSubview(videoPlayerControlView)
        videoPlayerControlView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            videoPlayerControlView.leadingAnchor.constraint(equalTo: videoPlayerView.leadingAnchor),
            videoPlayerControlView.trailingAnchor.constraint(equalTo: videoPlayerView.trailingAnchor),
            videoPlayerControlView.bottomAnchor.constraint(equalTo: videoPlayerView.bottomAnchor),
            videoPlayerControlView.heightAnchor.constraint(equalToConstant: screenWidth / 12)
        ])
    }
}

