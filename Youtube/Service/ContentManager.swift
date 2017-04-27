//
//  Contentmanager.swift
//  Youtube
//
//  Created by Doan Tuan on 4/19/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import Foundation
import AFNetworking

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
        
//        let url = ConstanAPI.base_api_url
//        
//        if Video {
//        }else{
//            Channel
//        }
// gộp thành 1 hàm
        
        let url = ConstanAPI.base_api_url.appending(ConstanAPI.APIPath.search)
        let qParam = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        print("search",qParam!)
        
        let params = ["part":"snippet","q":qParam!,"type":"video","key":ConstanAPI.keyAPI,"maxResults":"20","regionCode":"VN"]
        
       
        manager.get(url, parameters: params, progress: nil, success: { (task, responseObject) in
            
            let dataVideo = responseObject as! NSDictionary
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
        print("id Channel",idChannel)
        
        
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
    
    
}
