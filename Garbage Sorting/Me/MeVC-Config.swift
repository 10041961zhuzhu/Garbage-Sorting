//
//  MeVC-Config.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 13/04/2022.
//

import Foundation
import LeanCloud

extension MeVC{
    func config(){
    navigationItem.backButtonDisplayMode = .minimal
    
    if let user = LCApplication.default.currentUser, user == self.user{
        isMySelf = true
        }
   
    }
}
