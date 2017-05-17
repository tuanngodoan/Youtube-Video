//
//  VideoModel.swift
//  Youtube
//
//  Created by Doan Tuan on 4/19/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit

class ID:NSObject{
    var kind:String!
    var videoId:String!
    
    init(IDDict: NSDictionary){
        if let kind = IDDict[ParamAPI.kind] as? String! {
            self.kind = kind
        }
        if let videoID = IDDict[ParamAPI.videoID] as? String! {
            self.videoId = videoID
        }
    }
    
}

class Thumbnails: NSObject{
    
    var urlImag: String!
    var width: Float!
    var height: Float!
    
    init(thumbDict: NSDictionary){
        if let urlImg = thumbDict[ParamAPI.urlImg] as? String! {
            self.urlImag = urlImg
        }
//        if let width = thumbDict[ParamAPI.width] as? Float! {
//            self.width = width
//        }
//        if let height = thumbDict[ParamAPI.height] as? Float! {
//            self.height = height
//        }
    }
}

class Snippet: NSObject {
    
    var publishedAt:  String!
    var channelID:String!
    var channelAvatar:UIImage!
    var title:        String!
    var descriptionsVideo:  String!
    var thumb: Thumbnails!
    var channelTitle: String!
    var liveBroadcastContent:String!
    
    let server = ContentManager.sharedInstant
    
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

class ContentDetails{
    
    var videoID:String!
    
    init(contentDict: NSDictionary) {
        
        guard let bulletin = contentDict["bulletin"] as? NSDictionary else {return}
        guard let resourceId = bulletin["resourceId"] as? NSDictionary else {return}
        guard let videoId = resourceId["videoId"] as? String else {return}
        
        self.videoID = videoId
    }
}

class Items{
    
    var kind:String!
    var etag:String!
    var snippet:Snippet!
    var iD:ID!
    var contentDetails:ContentDetails!
    
    init(itemDict: NSDictionary){
        //
            if let kind = itemDict[ParamAPI.kind] as? String {
                self.kind  = kind
            }
            guard let etag = itemDict[ParamAPI.etag] as? String else {return}
            self.etag = etag
            
//            if let etag = itemDict?[ParamAPI.etag] as? String {
//                self.etag  = etag
//            }
            if let idDict = itemDict[ParamAPI.id] as? NSDictionary {
                self.iD = ID(IDDict: idDict)
            }
            if let snippetDict = itemDict[ParamAPI.snippet] as? NSDictionary {
                    self.snippet = Snippet(dict: snippetDict)
            }
        
        guard let contentDetailDict = itemDict["contentDetails"] as? NSDictionary else {return}
            self.contentDetails = ContentDetails(contentDict: contentDetailDict)
        }
    }

class pageInfo{
    
    var totalResults:Int!
    var resultsPerPage:Int!
    
    init(pageDict: NSDictionary) {
        if let total  = pageDict[ParamAPI.totalResults] as? Int{
            self.totalResults = total
        }
        
        if let result  = pageDict[ParamAPI.resultsPerPage] as? Int{
            self.resultsPerPage = result
        }
    }
    
}


class VideoModel: NSObject {
    
    var kind:String!
    var etag:String!
    var nextPageToken:String!
    var regionCode:String!
    var page:pageInfo!
    var itemsArr:[Items]!

    
    
    init(videoDict:NSDictionary){
        
        if let kind  = videoDict[ParamAPI.kind] as? String{
            self.kind = kind
        }
        
        if let etag  = videoDict[ParamAPI.etag] as? String{
            self.etag = etag
        }
        
        if let nextPageToken  = videoDict[ParamAPI.nextPageToken] as? String{
            self.nextPageToken = nextPageToken
        }
        
        if let regionCode  = videoDict[ParamAPI.regionCode] as? String{
            self.regionCode = regionCode
        }
        
        if let pageInfoDict  = videoDict[ParamAPI.pageInfo] as? NSDictionary{
            
            page = pageInfo(pageDict: pageInfoDict)
        }
        if let itemsArrDict  = videoDict[ParamAPI.items] as? [NSDictionary]{
           
            itemsArr = [Items]()
            for itemDict in itemsArrDict{
                
                let item = Items(itemDict: itemDict)
                itemsArr.append(item)
            }
        }
    }
    
}

class Statistics:NSObject{
    var viewCount:String!
    var likeCount:String!
    var dislikeCount:String!
    var commentCount:String!
    var subscriberCount:String!
    var videoCount:String!
    var hiddenSubscriberCount:Bool!
    
    init(dataDict: NSDictionary){
        
        guard let items = dataDict[ParamAPI.items] as? [NSDictionary] else {return}
        guard let item = items[0] as? NSDictionary else {return}
        guard let statisticDict = item[ParamAPI.statistics] as? NSDictionary else{return}
        
        guard let viewCount = statisticDict[ParamAPI.viewCount] as? String else {return }
        self.viewCount = viewCount
        guard let likeCount = statisticDict[ParamAPI.likeCount] as? String else {return }
        self.likeCount = likeCount
        guard let dislikeCount = statisticDict[ParamAPI.dislikeCount] as? String else {return }
        self.dislikeCount = dislikeCount
        
    }
}

class ChannelModel: NSObject {
    var title:String!
    var subsctipCount:String!
    var imageChannel: UIImage!
    init(channelItemsDict: NSDictionary) {
        
        guard let staDict = channelItemsDict[ParamAPI.statistics] as? NSDictionary else {return}
        guard let subCount = staDict[ParamAPI.subscriberCount] as? String else {return}
        self.subsctipCount = subCount
        
        guard let snippet = channelItemsDict[ParamAPI.snippet] as? NSDictionary else {return}
        
        guard let title = snippet[ParamAPI.title] as? String else {return}
        self.title = title
        
        guard let thumb = snippet[ParamAPI.thumbnails] as? NSDictionary else {return}
        guard let medium = thumb[ParamAPI.medium] as? NSDictionary else {return}
        guard let url = medium[ParamAPI.urlImg] as? String else {return}
       
        let urlImage = URL(string: url)
        let data = try? Data(contentsOf: urlImage!)
        let image = UIImage(data: data!)
        self.imageChannel = image
        
    }
}














