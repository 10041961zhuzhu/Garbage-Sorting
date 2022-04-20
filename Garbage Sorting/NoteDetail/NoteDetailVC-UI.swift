//
//  NoteDetailVC-UI.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 08/04/2022.
//

import Foundation
import Kingfisher
import LeanCloud
import ImageSlideshow

extension NoteDetailVC{
    func setUI(){
        followBtn.makeCapsule(.systemGreen)
        
        if isReadMyNote{
            followBtn.isHidden = true
            shareBtn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        }
        
        showLike()
        showNote()
    }
    func showNote(_ isUpdatingNote: Bool = false){
        if !isUpdatingNote{
            let authorAvatarURL = author?.getImageURL(from: avatarCol, .avatar)
            authorAvatarBtn.kf.setImage(with: authorAvatarURL, for: .normal)
            authorNickNameBtn.setTitle(author?.getExactStringVal(nickNameCol), for: .normal)
        }
        
        //note图片
        let coverPhotoHeight = CGFloat(note.getExactDoubelVal(kCoverPhotoRatioCol)) * screenRect.width
        imageSlideShowHeight.constant = coverPhotoHeight
        
        let coverPhoto = KingfisherSource(url: note.getImageURL(from: kCoverPhotoCol, .coverPhoto))
        if let photoPaths = note.get(kPhotosCol)?.arrayValue as? [String]{
            var photoArr = photoPaths.compactMap{ KingfisherSource(urlString:  $0)}
            photoArr[0] = coverPhoto
            imageSlideshow.setImageInputs(photoArr)
        }else{
            imageSlideshow.setImageInputs([coverPhoto])
        }
        
        //note标题
        let noteTitle = note.getExactStringVal(kTitleCol)
        if noteTitle.isEmpty{
            titleLabel.isHidden = true
        }else{
            titleLabel.text = noteTitle
        }
        let noteText = note.getExactStringVal(kTextCol)
        if noteText.isEmpty{
            textLabel.isHidden = true
        }else{
            textLabel.text = noteText
        }
        
        //note话题
        let noteChannel = note.getExactStringVal(kSubChannelCol)
        let noteSubChannel = note.getExactStringVal(kSubChannelCol)
        channelBtn.setTitle(noteSubChannel.isEmpty ? noteChannel : noteSubChannel, for: .normal)
        
        //note发表或编辑时间
        if let updatedAt = note.updatedAt?.value{
            dateLabel.text = "\(note.getExactBoolValDefaultF(kHasEditCol) ? "编辑于 " : "")\(updatedAt.formattedDate)"
        }
        //当前用户头像
        if let user = LCApplication.default.currentUser{
        let avatarURL = user.getImageURL(from: avatarCol, .avatar)
            avatarImageView.kf.setImage(with: avatarURL)
        }
        //点赞数
        likeCount = note.getExactIntVal(kLikeCountCol)
        currentLikeCount = likeCount
        //收藏数
        favCount = note.getExactIntVal(kFavCountCol)
        currentFavCount = favCount
        //评论数
        commentCount = note.getExactIntVal(kCommentCountCol)
    }
    
    private func showLike(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.likeBtn.isSelected = self.isLikeFromWaterfallCell
            self.likeBtn.setSelected(selected: self.isLikeFromWaterfallCell, animated: false)
        }
    }
}
