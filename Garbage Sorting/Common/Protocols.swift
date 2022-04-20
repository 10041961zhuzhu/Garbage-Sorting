//
//  Protocols.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 28/03/2022.
//

import Foundation

protocol ChannelVCDelegate
{
    /// 用户从选择话题页面返回编辑页面传值用
    func updateChannel(channel: String, subChannel: String)
}

protocol POIVCDelegate{
    func updatePOIName(_ poiName:String)
}
