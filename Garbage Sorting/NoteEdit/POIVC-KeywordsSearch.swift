//
//  POIVC-KeywordsSearch.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 05/04/2022.
//

import Foundation

extension POIVC: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            pois = aroundSearchedPOIs
            setAroundSearchFooter()
            tableView.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isBlank else{return}
        keywords = searchText
        pois.removeAll()
        currentKeywordsPage = 1
        setKeywordsSearchFooter()
        
        showLoadHUD()
        makeKeywordsSearch(keywords)
    }
}

extension POIVC: AMapSearchDelegate{
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        let poiCount = response.count
        hideLoadHUD()
        if poiCount == 0{
            return
        }
        for poi in response.pois{
            let province = poi.province == poi.city ? "" : poi.province
            let address = poi.district == poi.address ? "" :poi.address
            
            let poi = [poi.name ?? kNoPOIPH, "\(province.unwrappedText)\(poi.city.unwrappedText)\(poi.district.unwrappedText)\(address.unwrappedText)"]
            pois.append(poi)
            if request is AMapPOIKeywordsSearchRequest{
                aroundSearchedPOIs.append(poi)
            }
        }
        if poiCount > kPOIsOffset{
            pageCount = poiCount / kPOIsOffset + 1}
        else{
            footer.endRefreshingWithNoMoreData()
        }
        tableView.reloadData()
    }
    
}

extension POIVC{
    private func makeKeywordsSearch(_ keywords: String,_ page: Int = 1){
        keywordsSearchRequest.keywords = keywords
        keywordsSearchRequest.page = page
        mapSearch?.aMapPOIKeywordsSearch(keywordsSearchRequest)
    }
    private func setKeywordsSearchFooter(){
        footer.resetNoMoreData()
        footer.setRefreshingTarget(self, refreshingAction: #selector(keywordsSearchPullToRefresh))
    }
}
extension POIVC{
    @objc private func keywordsSearchPullToRefresh(){
        currentKeywordsPage += 1
        makeKeywordsSearch(keywords, currentKeywordsPage)
        endRefreshing(currentKeywordsPage)
    }
}
