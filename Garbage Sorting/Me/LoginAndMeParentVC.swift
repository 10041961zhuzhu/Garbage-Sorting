//
//  loginAndMeParentVC.swift
//  Garbage Sorting
//
//  Created by 谭红雨 on 2022/4/7.
//

import UIKit
import LeanCloud
//全局
var loginAndMeParentVC = UIViewController()
class LoginAndMeParentVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = LCApplication.default.currentUser{
            let meVC = storyboard!.instantiateViewController(identifier: MeVCID){ coder in MeVC(coder: coder, user: user)
                
            }
            add(child: meVC)
            print("mevc")
        }else{
            let loginVC = storyboard!.instantiateViewController(identifier: PasswordLoginVCID)
            add(child: loginVC)
            print("loginvc")
        }
        loginAndMeParentVC = self
    }
    

   
}

