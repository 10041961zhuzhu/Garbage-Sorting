//
//  WaterfallVC-Config.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 06/04/2022.
//

import CHTCollectionViewWaterfallLayout

extension WaterfallVC{
    func config(){
    let layout = collectionView.collectionViewLayout as! CHTCollectionViewWaterfallLayout
    layout.columnCount = 2
    layout.minimumColumnSpacing = kWaterfallPadding
    layout.minimumInteritemSpacing = kWaterfallPadding
    var inset: UIEdgeInsets = .zero
    if let _ = user{
        inset = UIEdgeInsets(top: 10, left: kWaterfallPadding, bottom: kWaterfallPadding, right: kWaterfallPadding)
    }else{
        inset = UIEdgeInsets(top: 0, left: kWaterfallPadding, bottom: kWaterfallPadding, right: kWaterfallPadding)
    }
        layout.sectionInset = inset
        /*if isDraft{
            layout.sectionInset = UIEdgeInsets(top: 44, left: kWaterfallPadding, bottom: kWaterfallPadding, right: kWaterfallPadding)
        }*/
        if isDraft{
            navigationItem.title = "本地草稿"
        }
        collectionView.register(UINib(nibName: "MyDraftNoteWaterfallCell", bundle: nil), forCellWithReuseIdentifier: kMyDraftNoteWaterfallCellID)
    }
}
