//
//  Login-Extensions.swift
//  Garbage Sorting
//
//  Created by 谭红雨 on 2022/4/7.
//

import Foundation
import LeanCloud

extension UIViewController{
    func configAfterLogin( _ user: LCUser, _ nickName:String, _ email:String = ""){
        if let _ = user.get(nickNameCol){
            dismissAndShowMeVC(user)
        }else{//首次登陆
            let group = DispatchGroup()
            
            let Avatar = UIImage(named: "avatar")
            if let avatardata = Avatar?.pngData(){
                let avatarfile = LCFile(payload: .data(data: avatardata))
                avatarfile.mimeType = "image/jpeg"
                avatarfile.save(to: user, as: avatarCol, group: group)
            }
            do {
                user.email = LCString(email)
                try user.set(nickNameCol, value: nickName)
               
            } catch {
                print("给User字段赋值失败\(error)")
                return
            }
            group.enter()
            user.save{
                _ in
                group.leave()
                
            }
            group.enter()
            user.save{ _ in group.leave()}
            
            group.enter()
            let userInfo = LCObject(className: kUserInfoTable)
            try? userInfo.set(kUserObjectIdCol, value: user.objectId)
            userInfo.save{ _ in group.leave()}
            
            group.notify(queue: .main){
                self.dismissAndShowMeVC(user)
            }
        
    }
    }
    
    func dismissAndShowMeVC(_ user: LCUser){
        DispatchQueue.main.async {
            let mainSB = UIStoryboard(name: "Main", bundle: nil)
            let meVC = mainSB.instantiateViewController(identifier: MeVCID){ coder in MeVC(coder: coder, user: user)
                
            }
            
            loginAndMeParentVC.removeChildren()
            loginAndMeParentVC.add(child:meVC)
            self.dismiss(animated: true)
        }
    }
}
 
