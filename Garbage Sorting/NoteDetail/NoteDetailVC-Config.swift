//
//  NoteDetailVC-Config.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 08/04/2022.
//

import Foundation
import ImageSlideshow
import LeanCloud

extension NoteDetailVC{
    func config(){
        
        //imageSlideshow
        imageSlideshow.zoomEnabled = true
        imageSlideshow.circular = false
        imageSlideshow.contentScaleMode = .scaleAspectFill
        imageSlideshow.activityIndicator = DefaultActivityIndicator()
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.currentPageIndicatorTintColor = mainColor
        imageSlideshow.pageIndicator = pageControl
        
        
        //如果没有的登录
        if LCApplication.default.currentUser == nil{
            likeBtn.setToNormal()
            favBtn.setToNormal()
        }
    }
}

