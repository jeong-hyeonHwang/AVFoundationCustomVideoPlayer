//
//  PlayStatusControlButton.swift
//  CustomVideoPlayer
//
//  Created by 황정현 on 2023/01/15.
//

import UIKit

enum PlayStatus {
    case play
    case pause
    
    mutating func changeButtonImage() -> UIImage {
        switch self {
        case .play:
            self = .pause
            let config = UIImage.SymbolConfiguration(pointSize: 45, weight: .regular, scale: .medium)
            let image = UIImage(systemName: "play.fill", withConfiguration: config)?
                .withTintColor(.white, renderingMode: .alwaysOriginal)
            return image!
        case .pause:
            self = .play
            let config = UIImage.SymbolConfiguration(pointSize: 45, weight: .regular, scale: .medium)
            let image = UIImage(systemName: "pause.fill", withConfiguration: config)?
                .withTintColor(.white, renderingMode: .alwaysOriginal)
            return image!
        }
    }
}

protocol PlayStatusControlButtonDelegate: AnyObject {
    func changePlayStatus(playStatus: PlayStatus)
}

final class PlayStatusControlButton: UIButton {

    var testPlayStatus: PlayStatus = .play
    
    weak var delegate: PlayStatusControlButtonDelegate?
    
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        
        let config = UIImage.SymbolConfiguration(pointSize: 45, weight: .regular, scale: .medium)
        let image = UIImage(systemName: "pause.fill", withConfiguration: config)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        self.setImage(image, for: .normal)
        self.addTarget(self, action: #selector(pressPlayStatusControlButton), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func pressPlayStatusControlButton() {
        self.changeButtonImage()
        self.delegate?.changePlayStatus(playStatus: testPlayStatus)
    }
    
    func changeButtonImage() {
        self.setImage(testPlayStatus.changeButtonImage(), for: .normal)
    }
}
