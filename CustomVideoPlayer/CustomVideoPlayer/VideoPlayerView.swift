//
//  VideoPlayerView.swift
//  CustomVideoPlayer
//
//  Created by 황정현 on 2023/01/15.
//

import UIKit
import AVFoundation

protocol VideoPlayerViewDelegate: AnyObject {
    func videoIsReadyToPlay()
}

weak var delegate: ScreenSizeControlButtonDelegate?
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
    
    var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    var videoPlayerControlView: VideoPlayerControlView = VideoPlayerControlView()
    
    private let videoURL = ""
    
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
        
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    private var playerItemContext = 0

    private var playerItem: AVPlayerItem?
    
    override init(frame: CGRect  =  CGRect()) {
        super.init(frame: frame)

        setUpLayout()
        componentConfigure()
        playVideo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        playerItem?.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
    }
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    private func setUpLayout() {
        
        // TEST
        self.backgroundColor = .black
        
        addSubview(videoPlayerControlView)
        videoPlayerControlView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            videoPlayerControlView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            videoPlayerControlView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            videoPlayerControlView.topAnchor.constraint(equalTo: self.topAnchor),
            videoPlayerControlView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        videoPlayerControlView.alpha = 0.0
        videoPlayerControlView.playStatusControlButton.isHidden = true
        videoPlayerControlView.isUserInteractionEnabled = true
        
        addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            activityIndicatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            activityIndicatorView.topAnchor.constraint(equalTo: self.topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        activityIndicatorView.style = .large
        activityIndicatorView.color = .white
        activityIndicatorStatus(true)
    }
    
    private func componentConfigure() {
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(touchVideoPlayerScreen))
        self.addGestureRecognizer(touchGesture)
        
        self.player?.rate = 30
        playerLayer.player?.currentItem?.automaticallyPreservesTimeOffsetFromLive = true
    }
    
    private func setUpAsset(with url: URL, completion: ((_ asset: AVAsset) -> Void)?) {
        let asset = AVAsset(url: url)
        
        Task {
            let isPlayable = try await asset.load(.isPlayable)
            
            if isPlayable {
                completion?(asset)
            } else {
                print("Non-playable")
            }
        }
    }
    
    // https://medium.com/@tarasuzy00/build-video-player-in-ios-i-avplayer-43cd1060dbdc
    private func setUpPlayerItem(with asset: AVAsset) {
        playerItem = AVPlayerItem(asset: asset)
        playerItem?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.old, .new], context: &playerItemContext)
            
        DispatchQueue.main.async { [weak self] in
            self?.player = AVPlayer(playerItem: self?.playerItem!)
        }
    }
        
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard context == &playerItemContext else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
            
        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: AVPlayerItem.Status
            if let statusNumber = change?[.newKey] as? NSNumber {
                status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
            } else {
                status = .unknown
            }
            
            switch status {
            case .readyToPlay:
                print(".readyToPlay")
                activityIndicatorStatus(false)
                delegate?.videoIsReadyToPlay()
                player?.play()
            case .failed:
                print(".failed")
            case .unknown:
                print(".unknown")
            @unknown default:
                print("@unknown default")
            }
        }
    }
    
    func play(with url: URL) {
        setUpAsset(with: url) { [weak self] (asset: AVAsset) in
            self?.setUpPlayerItem(with: asset)
        }
    }
    
    func playVideo() {
        guard let url = URL(string: videoURL) else { return }
        self.play(with: url)
    }
    
    func pause() {
        playerLayer.player?.pause()
    }
    
    func replay() {
        playerLayer.player?.play()
    }
    
    func activityIndicatorStatus(_ isActive: Bool) {
        if isActive == true {
            activityIndicatorView.startAnimating()
            activityIndicatorView.isHidden = false
            self.isUserInteractionEnabled = false
        } else {
            activityIndicatorView.stopAnimating()
            activityIndicatorView.isHidden = true
            self.isUserInteractionEnabled = true
        }
        
    }
    @objc private func touchVideoPlayerScreen() {
        testControlStatus.changeControlStatus(view: videoPlayerControlView)
    }
    
    
}
