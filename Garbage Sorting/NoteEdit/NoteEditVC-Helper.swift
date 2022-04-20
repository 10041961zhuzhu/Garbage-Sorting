//
//  NoteEditVC-Helper.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 07/04/2022.
//

import Foundation

extension NoteEditVC{
    func isValidateNote() -> Bool{
        guard !photos.isEmpty else{
            showLoadHUD("至少一张图片!")
            return false
        }
        return true
    }
    
    func showAllowPushAlert(){
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus{
            //未请求过授权(notDetermined)需再次请求授权,此处省略
            
            //未授权(不允许通知)时引导用户去设置App里授权
            case .denied:
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: #""小粉书"想给您发送通知"#, message: "收到评论后第一时间就知道哦~", preferredStyle: .alert)
                    let notAllowAction = UIAlertAction(title: "不允许", style: .cancel)
                    let allowAction = UIAlertAction(title: "允许", style: .default) { _ in
                        jumpToSetting()
                    }
                    alert.addAction(notAllowAction)
                    alert.addAction(allowAction)
                    self.view.window?.rootViewController?.present(alert, animated: true)
                }
            default:
                break
            }
        }
    }

}
