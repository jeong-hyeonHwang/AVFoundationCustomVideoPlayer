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
            return UIImage(systemName: "pause.fill")!
        case .pause:
            self = .play
            return UIImage(systemName: "play.fill")!
        }
    }
}

final class PlayStatusControlButton: UIButton {

    var testPlayStatus: PlayStatus = .play
    
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        
        self.setImage(UIImage(systemName: "play.fill"), for: .normal)
        self.addTarget(self, action: #selector(pressPlayStatusControlButton), for: .touchUpInside)
        
        // TEST
        self.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func pressPlayStatusControlButton() {
        self.setImage(testPlayStatus.changeButtonImage(), for: .normal)
        
    }

}
