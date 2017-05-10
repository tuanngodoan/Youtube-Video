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
    
    let server = ContentManager.sharedInstant
    var videos:VideoModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTrending(channelID: ConstanAPI.idTrend)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }

    @IBAction func homeButton(_ sender: UIButton){
        loadTrending(channelID: ConstanAPI.idTrend)
    }
    @IBAction func musicButton(_ sender: UIButton){
        loadTrending(channelID: ConstanAPI.idMusic)
      
    }
    @IBAction func liveButton(_ sender: UIButton){
        loadTrending(channelID: ConstanAPI.idLive)
    }
    
    func loadTrending(channelID: String){
       
        server.getActivities(channel: channelID) { (dictVideo, error) -> (Void) in
            
            if error == nil {
                self.videos = VideoModel(videoDict: dictVideo!)
                self.refeshTableView()
            }
        }
    }
    
    func refeshTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.itemsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "trendingCell", for: indexPath) as! TrendingTableViewCell
        
        cell.backgroundColor = UIColor.white
        cell.titleVideoLabel.text = videos.itemsArr[indexPath.row].snippet.title
        //cell.titleChannelLabel.text = videos.itemsArr[indexPath.row].snippet.channelTitle
        
        
        
        DispatchQueue.global().async {
            let url = URL(string: self.videos.itemsArr[indexPath.row].snippet.thumb.urlImag)
            let data = try? Data(contentsOf: url!)
            
            DispatchQueue.main.async {
                cell.thumbImageView.image = UIImage(data: data!)
            }
        }
        
        return cell
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
