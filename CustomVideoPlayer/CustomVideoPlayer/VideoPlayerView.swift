//
//  VideoPlayerView.swift
//  CustomVideoPlayer
//
//  Created by 황정현 on 2023/01/15.
//

import UIKit

class VideoPlayerView: UIView {
    
    override init(frame: CGRect  =  CGRect()) {
        super.init(frame: frame)
        
        self.backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
