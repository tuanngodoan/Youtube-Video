//
//  ConstantAPI.swift
//  Youtube
//
//  Created by Doan Tuan on 4/19/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit

struct ConstanAPI {
    static let base_api_url = "https://www.googleapis.com/youtube/v3"
    static let keyAPI = "AIzaSyAT2g4I-H7w7kQ2fKJHwS956Kwu271xO6M"
    
    struct APIPath{
        static let search     = "/search"
        static let activities = "/activities"
        static let channels   = "/channels"
        static let videos     = "/videos"
        static let liveBroadcasts = "/liveBroadcasts"
        static let liveStreams = "/liveStreams"
    }
}

struct ParamAPI {
    
    static let kind = "kind"
    static let etag = "etag"
    static let nextPageToken = "nextPageToken"
    static let regionCode = "regionCode"
    static let pageInfo = "pageInfo"
    static let totalResults = "totalResults"
    static let resultsPerPage = "resultsPerPage"
    static let items = "items"
    static let id = "id"
    static let videoID = "videoId"
    static let snippet = "snippet"
    static let publishedAt = "publishedAt"
    static let channelId = "channelId"
    static let title = "title"
    static let description = "description"
    
    static let thumbnails = "thumbnails"
    static let defaults = "default"
    static let medium = "medium"
    static let high = "high"
    
    static let urlImg = "url"
    static let width = "width"
    static let height = "height"
    static let standard = "standard"
    static let channelTitle = "channelTitle"
    static let liveBroadcastContent = "none"
    
    static let statistics  = "statistics"
    static let viewCount = "viewCount"
    static let likeCount = "likeCount"
    static let dislikeCount = "dislikeCount"
    static let commentCount = "commentCount"
    static let subscriberCount = "subscriberCount"
    static let videoCount = "videoCount"
    static let hiddenSubscriberCount = "hiddenSubscriberCount"
    
}
