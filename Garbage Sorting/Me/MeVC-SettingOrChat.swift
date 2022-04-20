//
//  MeVC-SettingOrChat.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 13/04/2022.
//

import Foundation
import LeanCloud

extension MeVC{
    @objc func settingOrChat(){
       if isMySelf{//设置
            
        }else{
            if let _ = LCApplication.default.currentUser{
                print("私信功能")
            }else{
                showLoginHUD()
            }
        }
        
    }
}
