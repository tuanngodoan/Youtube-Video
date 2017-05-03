//
//  VideoLauncher.swift
//  Youtube
//
//  Created by Doan Tuan on 5/3/17.
//  Copyright © 2017 Doan Tuan. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIWebView{
    
    
    let activityView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.activityIndicatorViewStyle = .whiteLarge
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    
    let controlsContrainsView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 0, alpha: 1)
        loadVideo(videoID: "lArGvoP0f04")
//        controlsContrainsView.frame = frame
//        addSubview(controlsContrainsView)
//        
//        controlsContrainsView.addSubview(activityView)
//        activityView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        activityView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadVideo(videoID: String){
    
        self.allowsInlineMediaPlayback = true
        self.allowsPictureInPictureMediaPlayback = true
        let urlVideo = URL(string:"https://www.youtube.com/embed/\(videoID)")
        let urlRequest = URLRequest(url: urlVideo!)
        self.loadRequest(urlRequest)
    }
}
class VideoLauncher: NSObject {

    func showVideoPlayer(){
        
        print("Show View Playerrrr")
        
        
        if let keyWindow = UIApplication.shared.keyWindow {
            let view =  UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.white
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height-10, width: 10, height: 10)
            
            
            let heightVideo = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width:  keyWindow.frame.width, height: heightVideo)
            let videoPlayView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayView)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                
                view.frame = keyWindow.frame
                
            }, completion: { (completion) in
                UIApplication.shared.isStatusBarHidden = true
            })
        }
    }
}
