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
        
        getSearch(searchText: "us&uk")
        //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShown), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        
        //let playerVars:Dictionary = ["playsinline":1]
        //playerView.load(withVideoId: "M7lc1UVf-VE", playerVars: playerVars)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButton(_ sender: Any) {
        searchTextField.text = ""
        searchTextField.becomeFirstResponder()
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
        var url = URL(string: searchVideo.itemsArr[indexPath.row].snippet.thumb.urlImag)
        var data = try? Data(contentsOf: url!)
        cell.thumbImage.image = UIImage(data: data!)
        
        // avataChannel
        //let idChannel = searchVideo.itemsArr[indexPath.row].snippet.channelID
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        self.pushVCPlayVideo(video: self.searchVideo.itemsArr[indexPath.row])
    }
    
    func pushVCPlayVideo(video:Items){
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "playVideoVC") as? PlayVideoController{
            vc.idVideo = video.iD.videoId
            vc.titleVideoText = video.snippet.title
            vc.discVideoText = video.snippet.descriptionsVideo
            //vc.statisticVideo = self.statisticVideo
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    

}

