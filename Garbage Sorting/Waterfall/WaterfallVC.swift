//
//  WaterfallVC.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 23/03/2022.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import XLPagerTabStrip
import LeanCloud
import SegementSlide


class WaterfallVC: UICollectionViewController, SegementSlideContentScrollViewDelegate {
    
    var channel = ""
    var isDraft = false
    
    @objc var scrollView: UIScrollView{
        collectionView
    }
    
    var isMyDraft = false
    var draftNotes: [DraftNote] = []
    var notes: [LCObject] = []
    var user:LCUser?
    var isMyNote = false
    var isMyFav = false
    
   // var isMyLike = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        
        if let user = user{
        if isMyNote{//个人界面
            getMyNotes(user)
        }else if isMyFav{
            
        }else{
            
        }
        }else if isDraft{//草稿总界面
            getDraftNotes()
        }else{
            getNotes()
        }
        
    }

    @IBAction func dismissDraftNotesVC(_ sender: Any) {
        dismiss(animated: true)
    }
    
}


extension WaterfallVC: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        IndicatorInfo(title: channel)
    }
}

