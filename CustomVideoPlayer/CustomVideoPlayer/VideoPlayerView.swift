//
//  VideoPlayerView.swift
//  CustomVideoPlayer
//
//  Created by 황정현 on 2023/01/15.
//

import UIKit

enum ControlStatus {
    case exist
    case hidden
    
    mutating func changeControlStatus(view: UIView) {
        switch self {
        case .exist:
            UIView.animate(withDuration: 0.2, delay: TimeInterval(0.0), animations: {
                view.alpha = 0.0
            })
            self = .hidden
        case .hidden:
            UIView.animate(withDuration: 0.2, delay: TimeInterval(0.0), animations: {
                view.alpha = 1.0
            })
            self = .exist
        }
    }
}

final class VideoPlayerView: UIView {
    
    var testControlStatus: ControlStatus = .hidden
    
    var videoPlayerControlView: VideoPlayerControlView = VideoPlayerControlView()
    
    override init(frame: CGRect  =  CGRect()) {
        super.init(frame: frame)

        setUpLayout()
        componentConfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout() {
        
        // TEST
        self.backgroundColor = .yellow
        
        let controlViewHeight = UIScreen.main.bounds.width / 12
        addSubview(videoPlayerControlView)
        videoPlayerControlView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            videoPlayerControlView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            videoPlayerControlView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            videoPlayerControlView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            videoPlayerControlView.heightAnchor.constraint(equalToConstant: controlViewHeight)
        ])
        
        videoPlayerControlView.alpha = 0.0
        videoPlayerControlView.isUserInteractionEnabled = true
    }
    
    private func componentConfigure() {
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(touchVideoPlayerScreen))
        self.addGestureRecognizer(touchGesture)
    }
    
    @objc private func touchVideoPlayerScreen() {
        testControlStatus.changeControlStatus(view: videoPlayerControlView)
    }
                                            
}
