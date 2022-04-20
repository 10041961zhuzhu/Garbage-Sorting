//
//  POIVC.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 28/03/2022.
//

import UIKit

class POIVC: UIViewController {
    
    var delegate: POIVCDelegate?
    var poiName = ""
    
    lazy var locationManager = AMapLocationManager()
    lazy var mapSearch = AMapSearchAPI()
    lazy var aroundSearchRequest :AMapPOIAroundSearchRequest = {
        let request = AMapPOIAroundSearchRequest()
                
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(latitude), longitude: CGFloat(longitude))
        //request.types = kPOITypes
        request.requireExtension = true
        request.offset = kPOIsOffset
        return request
    }()
    
    lazy var keywordsSearchRequest: AMapPOIKeywordsSearchRequest = {
        let request = AMapPOIKeywordsSearchRequest()
        request.requireExtension = true
        request.offset = kPOIsOffset
        return request
    }()
    lazy var footer = MJRefreshAutoNormalFooter()
    
    var pois = kPOIsInitArr
    var aroundSearchedPOIs = kPOIsInitArr       //完全同步copy周边的pois数组，用于简化逻辑
    var latitude = 0.0
    var longitude = 0.0
    var keywords = ""
    var currentAroundPage = 1
    var pageCount = 1
    var currentKeywordsPage = 1
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        requestLocation()

    }

}


extension POIVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pois.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kPOICellID, for: indexPath) as!POICell
        
        let poi = pois[indexPath.row]
        cell.poi = poi
        
        if poi[0] == poiName{
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    
}
extension POIVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.accessoryType = .checkmark
        delegate?.updatePOIName(pois[indexPath.row][0])
        
        dismiss(animated: true)
    }
}

extension POIVC{
    func endRefreshing(_ currentPage: Int){
        if currentPage < pageCount{
            footer.endRefreshing()
        }else{
            footer.endRefreshingWithNoMoreData()
        }
        footer.endRefreshing()
    }
    
}
