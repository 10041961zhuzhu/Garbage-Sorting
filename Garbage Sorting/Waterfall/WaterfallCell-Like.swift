//
//  WaterfallCell-Like.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 11/04/2022.
//

import Foundation
import LeanCloud
extension WaterfallCell{
    @objc func likeBtnTappedWhenLogin(){
        
        if likeCount != currentLikeCount{
            guard let note = note, let authorObjectId = (note.get(kAuthorCol) as? LCUser)?.objectId?.stringValue else {return}
            let user = LCApplication.default.currentUser!
            
            let offset = isLike ? 1 : -1
            currentLikeCount += offset
            if isLike{
            let userLike = LCObject(className: kUserLikeTable)
            try? userLike.set(kUserCol, value: user)
            try? userLike.set(kNoteCol, value: note)
            userLike.save{ _ in }
                try? note.increase(kLikeCountCol)
                LCObject.UserInfo(where: authorObjectId, increase: kLikeCountCol )
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

