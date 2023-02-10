//
//  VideoPlayerControlView.swift
//  CustomVideoPlayer
//
//  Created by 황정현 on 2023/01/15.
//

import UIKit

class ShadowGradientView: UIView {
    let color1 = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
    let color2 = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        let gradientLayer = layer as! CAGradientLayer
        
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
    }
}

final class VideoPlayerControlView: UIView {

    var shadowView: ShadowGradientView = ShadowGradientView()
    var screenSizeControlButton: ScreenSizeControlButton = ScreenSizeControlButton()
    var playStatusControlButton: PlayStatusControlButton = PlayStatusControlButton()
    var screenSizeControlButtonTrailingConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var screenSizeControlButtonBottomConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    override init(frame: CGRect  =  CGRect()) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout() {
        
        let shadowHeight = UIScreen.main.bounds.width * 9 / 16 / 2
        addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            shadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            shadowView.heightAnchor.constraint(equalToConstant: shadowHeight),
        ])
        
        let screenSizeControlButtonSize = UIScreen.main.bounds.width / 12
        addSubview(screenSizeControlButton)
        screenSizeControlButton.translatesAutoresizingMaskIntoConstraints = false
        screenSizeControlButtonTrailingConstraint = screenSizeControlButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4)
        screenSizeControlButtonBottomConstraint = screenSizeControlButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4)
        NSLayoutConstraint.activate([
            screenSizeControlButton.widthAnchor.constraint(equalToConstant: screenSizeControlButtonSize),
            screenSizeControlButton.heightAnchor.constraint(equalToConstant: screenSizeControlButtonSize),
            screenSizeControlButtonTrailingConstraint,
            screenSizeControlButtonBottomConstraint
        ])
        
        let playStatusControlButtonSize = UIScreen.main.bounds.width / 5
        addSubview(playStatusControlButton)
        playStatusControlButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playStatusControlButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            playStatusControlButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            playStatusControlButton.widthAnchor.constraint(equalToConstant: playStatusControlButtonSize),
            playStatusControlButton.heightAnchor.constraint(equalToConstant: playStatusControlButtonSize)
        ])
        
    }
}
