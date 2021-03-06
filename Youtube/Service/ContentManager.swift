//
//  Contentmanager.swift
//  Youtube
//
//  Created by Doan Tuan on 4/19/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import Foundation
import AFNetworking
import AppAuth
import Google

class ContentManager: NSObject {
    
    enum httpmethod {
        case GET
        case POST
    }
    
    static let sharedInstant = ContentManager()
    let manager:AFHTTPSessionManager!
    
 
    override init() {
        manager = AFHTTPSessionManager()
    }
    
    
    
    
    //func getVideoInfo()
    
    func getSearchInfo(searchText: String,completion: @escaping (_ dataJson: NSDictionary?, _ error: Error?)->(Void)) -> Void {
        
       let url = ConstanAPI.base_api_url.appending(ConstanAPI.APIPath.search)
        
        let qParam = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        let params = ["part":"snippet","q":qParam!,"key": ConstanAPI.keyAPI,"maxResults":"50","regionCode":"VN","type":"video","access_token":ConstanAPI.access_tokenKey,"mine":"true"]
        
       
        manager.get(url, parameters: params, progress: nil, success: { (task, responseObject) in
            
            let dataVideo = responseObject as! NSDictionary
            //print(dataVideo)
            completion(dataVideo,nil)
            
         }) { (task, error) in
            
            print(error)
            completion(nil, error)
        }
    }
    
    func getStatisticVideo(idVideo: String,completion: @escaping (_ dataJson: NSDictionary?, _ error: Error?)->(Void)) -> Void{
        let url = ConstanAPI.base_api_url.appending(ConstanAPI.APIPath.videos)

        let params = ["part":"statistics","id":idVideo,"key":ConstanAPI.keyAPI]
        //DispatchQueue.global().async {
            self.manager.get(url, parameters: params, progress: nil, success: { (task, responseObject) in
                
                let dataVideo = responseObject as! NSDictionary
                completion(dataVideo,nil)
            }) { (task, error) in
                
                print(error)
                completion(nil, error)
            }
        //}
    }
    
    func getChannelInfo(idChannel: String,completion: @escaping (_ dataJson: NSDictionary?, _ error: Error?)->(Void)) -> Void {
        
        let url = ConstanAPI.base_api_url.appending(ConstanAPI.APIPath.channels)
        
        let params = ["part":"snippet,statistics", "id":idChannel,"key":ConstanAPI.keyAPI]
        manager.get(url, parameters: params, progress: nil, success: { (task, responseObject) in
            
                let dataChannel = responseObject as! NSDictionary
                completion(dataChannel,nil)
                print(dataChannel)
            
            }) { (task, error) in
            
                print(error)
                completion(nil, error)
        }
    }
    
    func getVideoChannel(channel: String, completion: @escaping (_ dataJson: NSDictionary?,_ error: Error?)->(Void)){
        let url = ConstanAPI.base_api_url.appending(ConstanAPI.APIPath.activities)
        
        let param = ["part":"snippet,contentDetails","channelId":channel,"key": ConstanAPI.keyAPI]
        
        manager.get(url, parameters: param, progress: nil, success: { (task, responseObj) in
            //
            let data = responseObj as! NSDictionary
            completion(data, nil)
            
        }) { (task, error) in
            print("Error ", error.localizedDescription)
            completion(nil, error)
        }
        
    }
    
    func getActivites(completion: @escaping (_ data: NSDictionary?,_ error:Error?)->(Void) ){
        
        let url = ConstanAPI.base_api_url.appending(ConstanAPI.APIPath.activities)
       
        let param = ["part":"snippet", "key": ConstanAPI.keyAPI,"mine":"true","access_token=":ConstanAPI.access_tokenKey]
        
        manager.get(url, parameters: param, progress: nil, success: { (task, responseObj) in
            //
            let data = responseObj as! NSDictionary
            completion(data, nil)
            
        }) { (task, error) in
            print("Error ", error.localizedDescription)
            
        }
    }
}
