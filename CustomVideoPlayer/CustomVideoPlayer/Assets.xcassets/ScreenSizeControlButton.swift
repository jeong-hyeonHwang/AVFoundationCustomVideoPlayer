//
//  ScreenSizeControlButton.swift
//  CustomVideoPlayer
//
//  Created by 황정현 on 2023/01/15.
//

import UIKit

class ScreenSizeControlButton: UIButton {

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
        print("HERE")
    }
}
