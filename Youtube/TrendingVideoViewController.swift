//
//  TrendingVideoViewController.swift
//  Youtube
//
//  Created by Doan Tuan on 5/7/17.
//  Copyright © 2017 Doan Tuan. All rights reserved.
//

import UIKit

class TrendingVideoViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView:UITableView!
    
    let service = ContentManager.sharedInstant
    
    var videos:VideoModel!
    var channel:ChannelModel!
    var idVideo:String!
    var urlImage:String!
    
    @IBOutlet weak var selectTrendingSegmented: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTrending(channelID: ConstanAPI.idTrend)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
        
    }

    @IBAction func homeButton(_ sender: UIButton){
        loadTrending(channelID: ConstanAPI.idTrend)
    }
    @IBAction func musicButton(_ sender: UIButton){
        loadTrending(channelID: ConstanAPI.idMusic)
      
    }
    @IBAction func liveButton(_ sender: UIButton){
        loadLive()
    }
    
    func loadTrending(channelID: String){
       
        service.getVideoChannel(channel: channelID) { (dictVideo, error) -> (Void) in
            
            if error == nil {
                self.videos = VideoModel(videoDict: dictVideo!)
                self.refeshTableView()
            }
        }
    }
    
    func loadLive(){
        service.getSearchInfo(searchText: "live") { (jsonData, error) -> (Void) in
            if error == nil {
                self.videos = VideoModel(videoDict: jsonData!)
                self.refeshTableView()
                
            }
        }
    }
    
    func refeshTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        
        switch selectTrendingSegmented.selectedSegmentIndex {
        case 0:
            loadTrending(channelID: ConstanAPI.idTrend)
            break
        case 1:
            loadTrending(channelID: ConstanAPI.idMusic)
            break
        case 2:
            loadLive()
            break
        
        default:
            break
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.itemsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellResult = UITableViewCell()

            let cell = tableView.dequeueReusableCell(withIdentifier: "trendingCell", for: indexPath) as! TrendingTableViewCell
            
            cell.backgroundColor = UIColor.white
            cell.titleVideoLabel.text = videos.itemsArr[indexPath.row ].snippet.title
            
            DispatchQueue.global().async {
                let url = URL(string: self.videos.itemsArr[indexPath.row].snippet.thumb.urlImag)
                let data = try? Data(contentsOf: url!)
                
                DispatchQueue.main.async {
                    cell.thumbImageView.image = UIImage(data: data!)
                }
            }
            
            cellResult = cell

        return cellResult
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(videos.itemsArr[indexPath.row])
        print(videos.itemsArr[indexPath.row].iD)
        //pushVCPlayVideo(video: self.videos.itemsArr[indexPath.row])
    }
    
    func pushVCPlayVideo(video:Items){
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "playVideoVC") as? PlayVideoController{
            
            vc.idVideo = video.iD.videoId
            
            vc.titleVideoText = video.snippet.title
            
            self.service.getChannelInfo(idChannel: video.snippet.channelID) { (channelDict, error) -> (Void) in
                if error == nil{
                    
                    guard let items = channelDict?[ParamAPI.items] as? [Any] else {return}
                    guard let dict = items[0] as? NSDictionary else {return}
                    self.channel = ChannelModel(channelItemsDict: dict)
                    vc.channel = self.channel
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }

}
