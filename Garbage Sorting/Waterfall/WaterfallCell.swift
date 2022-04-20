//
//  WaterfallCell.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 23/03/2022.
//

import UIKit
import LeanCloud
import Kingfisher

class WaterfallCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var likebtn: UIButton!
    
    var likeCount = 0{
        didSet{
            likebtn.setTitle(likeCount.formattedStr, for: .normal)
        }
    }
    var currentLikeCount = 0
    var isLike: Bool{ likebtn.isSelected }
    var note: LCObject?{
        didSet{
            guard let note = note, let author = note.get(kAuthorCol) as? LCUser else{return}
            
            let coverPhotoURL = note.getImageURL(from: kCoverPhotoCol, .coverPhoto)
            imageview.kf.setImage(with: coverPhotoURL)
            
            let avatarURL = author.getImageURL(from: avatarCol, .avatar)
            avatarImageView.kf.setImage(with: avatarURL)
            //笔记标题
            titleLabel.text = note.getExactStringVal(kTitleCol)
            //作者昵称
            nickNameLabel.text = author.getExactStringVal(nickNameCol)
            //笔记被点赞数
            likeCount = note.getExactIntVal(kLikeCountCol)
            currentLikeCount = likeCount
            //判断是否点赞
            if let user = LCApplication.default.currentUser{
                let query = LCQuery(className: kUserLikeTable)
                query.whereKey(kUserCol, .equalTo(user))
                query.whereKey(kNoteCol, .equalTo(note))
                query.getFirst{ res in
                    if case .success = res{
                        self.likebtn.isSelected = true
                }
            }
            }
        }
    }
    
    @IBAction func like(_ sender: Any) {
        if let _ = LCApplication.default.currentUser{
        //UI
        likebtn.isSelected.toggle()
        isLike ? (likeCount += 1) : (likeCount -= 1)
            //数据//防止暴力点击
                NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(likeBtnTappedWhenLogin), object: nil)
                perform(#selector(likeBtnTappedWhenLogin), with: nil, afterDelay: 1)

        }else{
            showGlobalTextHUD("请先登录哦！")
        }
    }
}

