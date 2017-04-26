//
//  VideoInfoModel.swift
//  Youtube
//
//  Created by Doan Tuan on 4/26/17.
//  Copyright © 2017 Doan Tuan. All rights reserved.
//

import UIKit

class VideoInfoModel: NSObject {

    class Snippet: NSObject {
        
        var publishedAt:  String!
        var channelID:String!
        var urlImageID  = String()
        var title:        String!
        var descriptionsVideo:  String!
        var thumb: Thumbnails!
        var channelTitle: String!
        var liveBroadcastContent:String!
        
        
        init(dict: NSDictionary) {
            
            if let published = dict[ParamAPI.publishedAt] as? String {
                self.publishedAt = published
            }
            if let chanID = dict[ParamAPI.channelId] as? String{
                self.channelID = chanID
            }
            if let title = dict[ParamAPI.title] as? String {
                self.title = title
            }
            if let description = dict[ParamAPI.description] as? String {
                self.descriptionsVideo = description
            }
            
            if let thumbDict = dict[ParamAPI.thumbnails] as? NSDictionary {
                if let highDict = thumbDict[ParamAPI.high] as? NSDictionary {
                    self.thumb = Thumbnails(thumbDict: highDict)
                }
            }
            if let channelTitle = dict[ParamAPI.channelTitle] as? String {
                self.channelTitle = channelTitle
            }
            
            if let liveBroad = dict[ParamAPI.liveBroadcastContent] as? String {
                self.liveBroadcastContent  = liveBroad
            }
        }
        
    }

    
}
