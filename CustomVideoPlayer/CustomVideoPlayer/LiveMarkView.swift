//
//  LiveMarkView.swift
//  CustomVideoPlayer
//
//  Created by 황정현 on 2023/02/10.
//

import UIKit

final class LiveMarkView: UIView {

    private var liveLabel: UILabel = UILabel()
    
    override init(frame: CGRect  =  CGRect()) {
        super.init(frame: frame)

        backgroundColor = UIColor(red: 255/255, green: 116/255, blue: 129/255, alpha: 1)
        setUpLayout()
        componentConfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout() {
        addSubview(liveLabel)
        liveLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            liveLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            liveLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            liveLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            liveLabel.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        
    }
    
    private func componentConfigure() {
        liveLabel.textAlignment = .center
        liveLabel.text = "LIVE"
        liveLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    }

    func setUpLiveLabelRadius(to: CGFloat) {
        self.layer.cornerRadius = to
    }
}
