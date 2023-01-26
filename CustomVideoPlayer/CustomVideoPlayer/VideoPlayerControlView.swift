//
//  VideoPlayerControlView.swift
//  CustomVideoPlayer
//
//  Created by 황정현 on 2023/01/15.
//

import UIKit

final class VideoPlayerControlView: UIView {

    var screenSizeControlButton: ScreenSizeControlButton = ScreenSizeControlButton()
    var playStatusControlButton: PlayStatusControlButton = PlayStatusControlButton()
    
    override init(frame: CGRect  =  CGRect()) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout() {
        
        self.backgroundColor = .gray.withAlphaComponent(0.4)
        
        let buttonSize = UIScreen.main.bounds.width / 12
        addSubview(screenSizeControlButton)
        screenSizeControlButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            screenSizeControlButton.widthAnchor.constraint(equalToConstant: buttonSize),
            screenSizeControlButton.heightAnchor.constraint(equalToConstant: buttonSize),
            screenSizeControlButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            screenSizeControlButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        addSubview(playStatusControlButton)
        playStatusControlButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playStatusControlButton.widthAnchor.constraint(equalToConstant: buttonSize),
            playStatusControlButton.heightAnchor.constraint(equalToConstant: buttonSize),
            playStatusControlButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            playStatusControlButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
