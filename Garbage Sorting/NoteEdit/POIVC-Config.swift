//
//  POIVC-Config.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 05/04/2022.
//

import Foundation

extension POIVC{
    func config(){
        //定位
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.locationTimeout = 5
        locationManager.reGeocodeTimeout = 5
        
        //搜索POI
        mapSearch?.delegate = self
        //上拉刷新位置数据
        tableView.mj_footer = footer
        
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton
        { cancelButton.isEnabled = true}
    }
}
