//
//  PlayVideoControllerViewController.swift
//  Youtube
//
//  Created by Doan Tuan on 4/22/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit
import youtube_ios_player_helper


class PlayVideoController: UIViewController {
    @IBOutlet weak var playVideoView: YTPlayerView!
    @IBOutlet weak var titleVideoLabel:UILabel!
    @IBOutlet weak var discVideoLabel:UITextView!
    @IBOutlet weak var viewCountLabel:UILabel!
    @IBOutlet weak var likeCountLabel:UILabel!
    @IBOutlet weak var dislikeCountLabel:UILabel!
    
    var idVideo:String!
    var titleVideoText:String!
    var discVideoText:String!
    var statisticVideo:Statistics!
    let service = ContentManager.sharedInstant
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("IDVIDEO:",idVideo)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        DispatchQueue.global().sync {
            self.playVideoView.load(withVideoId: self.idVideo+"/live")
            self.playVideoView.playVideo()
            DispatchQueue.main.async {
                self.loadInfo()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI(){
        
        titleVideoLabel.text = titleVideoText
        discVideoLabel.text = discVideoText
        self.viewCountLabel.text = numberCount(numberConvert: self.statisticVideo.viewCount) + " lượt xem"
        self.likeCountLabel.text = numberCount(numberConvert: self.statisticVideo.likeCount)
        self.dislikeCountLabel.text = numberCount(numberConvert: self.statisticVideo.dislikeCount)

    }
    
  func  loadInfo(){
    
        self.service.getStatisticVideo(idVideo: self.idVideo) { (dataDict, error) -> (Void) in
            self.statisticVideo = Statistics(dataDict: dataDict!)
            print(dataDict!)
            self.updateUI()

        }
    }
    
    func numberCount(numberConvert number:String)->String{
        var numString:String = ""
        
        guard let numberInt = Int(number) else {return "0"}
        if numberInt < 1000 {
            numString = number
        }else{
            if numberInt >= 1000 && numberInt < 1000000{
                numString = String(numberInt/1000) + " N"
            }else{
                if numberInt >= 1000000 && numberInt < 1000000000{
                    numString = String(numberInt/1000000) + " Tr"
                }else{
                    numString = String(numberInt/1000000000) + " Ti"
                }
            }
        }
        
        return numString
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
