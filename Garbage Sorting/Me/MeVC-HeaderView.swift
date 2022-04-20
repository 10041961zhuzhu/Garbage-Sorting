//
//  MeVC-HeaderView.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 13/04/2022.
//

import Foundation
import LeanCloud

extension MeVC{
    func setHeaderView() -> UIView{
        let headerView = Bundle.loadView(fromNib: "MeHeaderView", with: MeHeaderView.self)
        //约束
        headerView.translatesAutoresizingMaskIntoConstraints = false
        //此处有小bug:页面往上推的时候会先折叠掉一部分--可能是包的问题,待解决
        headerView.heightAnchor.constraint(equalToConstant: headerView.rootStackView.frame.height + 16).isActive = true
        
        headerView.user = user
        
        if isFromNote{
            headerView.backOrDrawerBtn.setImage(largeIcon("chevron.left"), for: .normal)
        }
        
        headerView.backOrDrawerBtn.addTarget(self, action: #selector(backOrDrawer), for: .touchUpInside)
        
      if isMySelf{
            headerView.introLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(editIntro)))

        }else{
            if user.getExactStringVal(introCol).isEmpty{
                headerView.introLabel.isHidden = true
            }
            
            if let _ = LCApplication.default.currentUser{
                headerView.editOrFollowBtn.setTitle("关注", for: .normal)
                headerView.editOrFollowBtn.backgroundColor = .systemGreen
            }else{
                headerView.editOrFollowBtn.setTitle("关注", for: .normal)
                headerView.editOrFollowBtn.backgroundColor = .systemGreen
            }
            //聊天按钮
            headerView.settingOrChatBtn.setImage(fontIcon("ellipsis.bubble", fontSize: 13), for: .normal)
        }
      
        
        headerView.editOrFollowBtn.addTarget(self, action: #selector(editOrFollow), for: .touchUpInside)
        headerView.settingOrChatBtn.addTarget(self, action: #selector(settingOrChat), for: .touchUpInside)
        
        return headerView
    }
}
