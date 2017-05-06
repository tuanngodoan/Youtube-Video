//
//  ViewController.swift
//  Youtube
//
//  Created by Doan Tuan on 4/19/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit

class ResultVideoViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate {


    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchTextField: UITextField!
    

    let service = ContentManager.sharedInstant
    
    var searchVideo:VideoModel!
    var statisticVideo:Statistics!
    var channel:ChannelModel!
    var idVideo:String!
    var urlImage:String!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchTextField.delegate = self
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 204/255, green: 24/255, blue: 30/255, alpha: 0.8)
        
        getSearch(searchText: "pewpew")
        
        //let playerVars:Dictionary = ["playsinline":1]
        //playerView.load(withVideoId: "M7lc1UVf-VE", playerVars: playerVars)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    @IBAction func searchButton(_ sender: Any) {
        searchTextField.text = ""
        searchTextField.becomeFirstResponder()
    }
    
    
    @IBAction func accountButton(_ sender: Any){
        
        print("taptaptap")
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginVC") as? LoginGGViewController{
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
            
    }
    
    func getSearch(searchText: String){
        
        service.getSearchInfo(searchText: searchText) { (dict, error) -> (Void) in
            if error == nil {
                self.searchVideo = VideoModel(videoDict: dict!)
                self.loadVideoCellTable()
            }
        }
    }
    
    func getChannel(id:String){
        DispatchQueue.global().sync {
            self.service.getChannelInfo(idChannel: id) { (channelDict, error) -> (Void) in
                if error == nil{
                    self.channel = ChannelModel(channelItemsDict: channelDict!)
                }
            }
        }
    }
    
    func loadVideoCellTable(){
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        getSearch(searchText: searchTextField.text!)
        textField.resignFirstResponder()
        return true;
    }
    
    
    /// Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  searchVideo.itemsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellVideo", for: indexPath) as! VideoTableViewCell
        
        //titile
        cell.titleVideoLabel.text = searchVideo.itemsArr[indexPath.row].snippet?.title!
        // description
        cell.descriptionLabel.text = searchVideo.itemsArr[indexPath.row].snippet?.channelTitle!

        // thumb video
        
        DispatchQueue.global().async {
            let url = URL(string: self.searchVideo.itemsArr[indexPath.row].snippet.thumb.urlImag)
            let data = try? Data(contentsOf: url!)
            
            DispatchQueue.main.async {
                cell.thumbImage.image = UIImage(data: data!)
            }
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        self.pushVCPlayVideo(video: self.searchVideo.itemsArr[indexPath.row])
//        let videoLauncher = VideoLauncher()
//        videoLauncher.showVideoPlayer()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func pushVCPlayVideo(video:Items){
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "playVideoVC") as? PlayVideoController{
            vc.idVideo = video.iD.videoId
            vc.titleVideoText = video.snippet.title
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        
//        if scrollView.contentOffset.y < 10 {
//            UIView.animate(withDuration: 0.2, animations: {
//                self.navigationController?.isNavigationBarHidden = false
//            })
//        }else{
//            UIView.animate(withDuration: 0.3, animations: {
//                self.navigationController?.isNavigationBarHidden = true
//            })
//        }
//    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    

}

