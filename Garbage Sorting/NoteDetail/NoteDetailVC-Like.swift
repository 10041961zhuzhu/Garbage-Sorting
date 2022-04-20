//
//  NoteEditVC-LikeFav.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 11/04/2022.
//

import Foundation
import LeanCloud
import SwiftUI

extension NoteDetailVC{
    func like(){
        if let _ = LCApplication.default.currentUser{
            //UI
            isLike ? (likeCount += 1) : (likeCount -= 1)
            //数据//防止暴力点击
                NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(likeBtnTappedWhenLogin), object: nil)
                perform(#selector(likeBtnTappedWhenLogin), with: nil, afterDelay: 1)
        }else{
            showLoginHUD()
        }
    }
  
    @objc private func likeBtnTappedWhenLogin(){
        if likeCount != currentLikeCount{
            let user = LCApplication.default.currentUser!
            let authorObjectId = author?.objectId?.stringValue ?? ""
            let offset = isLike ? 1: -1
            currentLikeCount += offset
            
            if isLike{
            let userLike = LCObject(className: kUserLikeTable)
            try? userLike.set(kUserCol, value: user)
            try? userLike.set(kNoteCol, value: note)
            userLike.save{ _ in }
                try? note.increase(kLikeCountCol)
                LCObject.UserInfo(where: authorObjectId, increase: kLikeCountCol)
            }else{
                let query = LCQuery(className: kUserLikeTable)
                query.whereKey(kUserCol, .equalTo(user))
                query.whereKey(kNoteCol, .equalTo(note))
                query.getFirst{ res in
                    if case let .success(object: userLike) = res{
                        userLike.delete{ _ in }
                }
            }
                try? note.set(kLikeCountCol, value: likeCount)
                note.save{ _ in }
                LCObject.UserInfo(where: authorObjectId, decrease: kLikeCountCol, to: likeCount)
            }
            }
    }
    
}
