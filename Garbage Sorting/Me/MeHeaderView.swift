//
//  MeHeaderView.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 12/04/2022.
//

import UIKit
import LeanCloud
import Kingfisher
class MeHeaderView: UIView {

    @IBOutlet weak var rootStackView: UIStackView!
    @IBOutlet weak var editOrFollowBtn: UIButton!
     @IBOutlet weak var settingOrChatBtn: UIButton!
    @IBOutlet weak var backOrDrawerBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var likedAndFavedLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        editOrFollowBtn.makeCapsule()
        settingOrChatBtn.makeCapsule()
    }
    var user: LCUser!{
        didSet{
            //头像和昵称
            avatarImageView.kf.setImage(with: user.getImageURL(from: avatarCol, .avatar))
            nickNameLabel.text = user.getExactStringVal(nickNameCol)
            
            //性别
            let gender = user.getExactBoolValDefaultF(genderCol)
            genderLabel.text = gender ? "♂︎" : "♀︎"
            genderLabel.textColor = gender ? blueColor : mainColor
            
            //账号
            idLabel.text = "\(user.getExactIntVal(kIDCol))"
            
            //个人简介
            let intro = user.getExactStringVal(introCol)
            introLabel.text = intro.isEmpty ? "填写个人简介更容易获得关注哦,点击此处填写" : intro
            
            //获赞和收藏数
            guard let userObjectId =  user.objectId?.stringValue else { return }
            let query = LCQuery(className: kUserInfoTable)
            query.whereKey(kUserObjectIdCol, .equalTo(userObjectId))
            query.getFirst { res in
                if case let .success(object: userInfo) = res{
                    let likeCount = userInfo.getExactIntVal(kLikeCountCol)
                    let favCount = userInfo.getExactIntVal(kFavCountCol)
                    DispatchQueue.main.async {
                        self.likedAndFavedLabel.text = "\(likeCount + favCount)"
                    }
                }
            }
        }
}
    @IBAction func logout(_ sender: Any) {
        LCUser.logOut()
    }
}
