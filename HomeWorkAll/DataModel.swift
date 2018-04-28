//
//  DataModel.swift
//  HomeWorkAll
//
//  Created by CLINK on 2018/4/26.
//  Copyright © 2018年 CLINK. All rights reserved.
//

import Foundation

struct room: Codable {
    var thumbnail: String
    var name: String
    var flatType: String
    var bedNumber: Int
    var price: Int
    var rate: Int
    var rateCount: Int
    var goodHost: Bool
    
}
struct  roomData {
    var thumbnail: String = ""
    var name: String = ""
    var flatType: String = ""
    var bedNumber: Int = 0
    var price: Int = 0
    var rate: Int = 0
    var rateCount: Int = 0
    var goodHost: Bool = false
    
}
struct pData: Codable {
    var thumbnail: String 
    var title: String
    var Description: String
}
struct mainData {
    var thumbnail: String = ""
    var title: String = ""
    var Description: String = ""
}
//struct roomList: Codable { //Codable JSONDecoder專用格式
//    var api_version: String
//    var rooms: [room]
//}
struct plusDataModel: Codable { //Codable JSONDecoder專用格式
    //var api_version: String
    var plusData: [pData]
    var roomList: [room]
}
