//
//  ViewController.swift
//  CustomVideoPlayer
//
//  Created by 황정현 on 2023/01/11.
//

import UIKit

class ViewController: UIViewController {

    private var videoPlayerView: UIView = VideoPlayerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(videoPlayerView)
        setUpLayout()
    }

    func setUpLayout() {
        
        let safeArea = view.safeAreaLayoutGuide
        let videoPlayerViewHeight = UIScreen.main.bounds.width * 9/16
        videoPlayerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            videoPlayerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            videoPlayerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            videoPlayerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            videoPlayerView.heightAnchor.constraint(equalToConstant: videoPlayerViewHeight)
        ])
    }
}

