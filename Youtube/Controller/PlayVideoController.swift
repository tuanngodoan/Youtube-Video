//
//  PlayVideoControllerViewController.swift
//  Youtube
//
//  Created by Doan Tuan on 4/22/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit
//import youtube_ios_player_helper
import AVFoundation
import youtube_ios_player_helper


enum stateOfPlayView {
    case minimized
    case fullScreen
    case hidden
}

enum Direction {
    case up
    case left
    case none
}

//class ytpView:YTPlayerView{
//    
//    override init(frame: CGRect) {
//        
//    }
//    
//    
//}

class PlayVideoController: UIViewController, UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate,YTPlayerViewDelegate {


    @IBOutlet weak var playVideoView: YTPlayerView!
    @IBOutlet weak var playVideoWebView:UIWebView!
    
    
    var idVideo:String!
    var titleVideoText:String!
    var channel:ChannelModel!
    var statisticVideo:Statistics!
    let service = ContentManager.sharedInstant
    
    
    var state = stateOfPlayView.hidden
    var direction = Direction.none
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        playVideoView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width * 9 / 16)
        playVideoView.backgroundColor = UIColor(white: 0, alpha: 0)
        
        self.state = .fullScreen
        
        loadVideo(videoID: idVideo)

        //playVideoView.delegate = self
        //playVideoView.setPlaybackQuality(.HD720)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    

    func loadVideo(videoID: String){
        
        
        let varParam = ["playsinline" : "1", "rel":"0", "showinfo":"0","color":"white","controls":"1","fs":"0"]
        
        playVideoView.load(withVideoId: videoID, playerVars: varParam)
    }
    
    func updateUI(){
        
        

    }
    
    func  loadInfo(){
    
        self.service.getStatisticVideo(idVideo: self.idVideo) { (dataDict, error) -> (Void) in
            self.statisticVideo = Statistics(dataDict: dataDict!)
            print(dataDict!)
            
        }
    }
    
    ///
    
    @IBAction func miniGesture(_ sender: UIPanGestureRecognizer) {
        
        if sender.state == .began {
            
            let vection = sender.velocity(in: nil)
            
            if abs(vection.x) < abs(vection.y){
                self.direction = Direction.up
            }else{
                self.direction = Direction.left
            }
        }
        
        var finalState = stateOfPlayView.fullScreen
            
            switch self.state {
            case .fullScreen:
                finalState = .minimized
                //minimize()
            break
            case .minimized:
                if self.direction == .left{
                    print("lefttttt")
                    finalState = .hidden
                    //hidden()
                }else{
                    print("uppp")
                    finalState = .fullScreen
                    //fullScreen()
                }
            break
            default:
            break
            }
        if sender.state == .ended{
            self.state = finalState
            print("final state",self.state)
        }
        
    }
    
    func minimize(){
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
        
            let width = self.view.frame.width * 4 / 5
            let height = width * 9 / 16
            self.playVideoView.frame = CGRect(x: self.view.frame.width - 305, y: self.view.frame.height - 250, width: width, height: height)
            
        }, completion: { (completion) in
            
        })
    }
    
    func fullScreen(){
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            
            let width = self.view.frame.width
            let height = width * 9 / 16
            self.playVideoView.frame = CGRect(x: 0, y: 0, width: width, height: height)
            
        }, completion: { (completion) in
            //
        })
    }
    
    func hidden(){
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            
            let width = self.view.frame.width * 4 / 5
            let height = width * 9 / 16
            self.playVideoView.frame = CGRect(x:  600, y: self.view.frame.height - 250, width: width, height: height)
            
        }, completion: { (completion) in
            self.navigationController?.popViewController(animated: true)
        })
        
    }
    
    func numberCount(numberConvert number:String)->String{
        var numString:String = ""
        
        guard let numberInt = Int(number) else {return "0"}
        if numberInt < 1000 {
            
            numString = number
        }else{
            
            if numberInt >= 1000 && numberInt < 1000000{
                numString = String(numberInt/1000) + "K"
            }else{
                
                if numberInt >= 1000000 && numberInt < 1000000000{
                    
                    numString = String(numberInt/1000000) + "M"
                }else{
                    
                    numString = String(numberInt/1000000000) + "B"
                }
            }
        }
        
        return numString
    }
    
    override var prefersStatusBarHidden:Bool {
        return true
    }

    
    
    ///
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellResult = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! InfoVideoTableViewCell
            
            headerCell.TitleVideoLabel.text = titleVideoText
            
            self.service.getStatisticVideo(idVideo: self.idVideo) { (dataDict, error) -> (Void) in
            
                    self.statisticVideo = Statistics(dataDict: dataDict!)
                    print(dataDict!)
                    headerCell.viewCountLabel.text = self.numberCount(numberConvert: self.statisticVideo.viewCount) + " lượt xem"
                    headerCell.likeCountLabel.text = self.numberCount(numberConvert: self.statisticVideo.likeCount)
                    headerCell.dislikeCountLabel.text = self.numberCount(numberConvert: self.statisticVideo.dislikeCount)
                    headerCell.channelTitleLabel.text = self.channel.title
                    headerCell.numSubLabel.text = self.numberCount(numberConvert: self.channel.subsctipCount) + " đăng kí"
            
                    //headerCell.channelImageView.layer.cornerRadius = headerCell.frame.height * 0.2
                    headerCell.channelImageView.image = self.channel.imageChannel
                    headerCell.channelImageView.layer.cornerRadius = headerCell.channelImageView.frame.width / 2
                    headerCell.channelImageView.clipsToBounds = true
            }
            
            cellResult = headerCell
            break
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SuggestVideoTableViewCell
            
            
            
            
            cellResult = cell
            break
        }
        
        return cellResult
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat!
        
        switch indexPath.row {
        case 0:
            height = 192
            break
        default:
            height = 80
            break
        }
        return height
    }
}
