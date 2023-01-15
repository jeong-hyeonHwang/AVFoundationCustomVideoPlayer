//
//  ScreenSizeControlButton.swift
//  CustomVideoPlayer
//
//  Created by 황정현 on 2023/01/15.
//

import UIKit

enum ScreenSizeStatus {
    case normal
    case full
    
    mutating func changeButtonImage() -> UIImage {
        switch self {
        case .normal:
            self = .full
            return UIImage(systemName: "arrow.down.right.and.arrow.up.left")!
        case .full:
            self = .normal
            return UIImage(systemName: "arrow.up.left.and.arrow.down.right")!
        }
    }
}

final class ScreenSizeControlButton: UIButton {

    var testScreenSizeStatus: ScreenSizeStatus = .normal
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        
        self.setImage(UIImage(systemName: "arrow.up.left.and.arrow.down.right"), for: .normal)
        self.addTarget(self, action: #selector(pressScreenSizeControlButton), for: .touchUpInside)
        
        // TEST
        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func pressScreenSizeControlButton() {
        self.setImage(testScreenSizeStatus.changeButtonImage(), for: .normal)
    }
}
