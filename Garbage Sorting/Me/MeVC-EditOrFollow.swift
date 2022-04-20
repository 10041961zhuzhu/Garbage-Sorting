//
//  MeVC-EditOrFollow.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 13/04/2022.
//

import Foundation
import LeanCloud

extension MeVC{
    @objc func editOrFollow(){
       if isMySelf{//编辑资料
            
        }else{
            if let _ = LCApplication.default.currentUser{
                print("关注和取消关注功能")
            }else{
                showLoginHUD()
            }
        }
     
    }
}
