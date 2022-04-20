//
//  TabBarC.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 23/03/2022.
//

import UIKit
import YPImagePicker
import LeanCloud
class TabBarC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is PostVC{
            
            //（判断是否登录）
            if let _ = LCApplication.default.currentUser{
                
                var config = YPImagePickerConfiguration()
                
                //通用配置
                config.isScrollToChangeModesEnabled = false
                config.onlySquareImagesFromCamera = false
                config.albumName =  Bundle.main.appName
                config.startOnScreen = .library
                config.screens = [.library, .video, .photo]
                config.maxCameraZoomFactor = 5
                
                
                //相册配置
                config.library.defaultMultipleSelection = true
                config.library.maxNumberOfItems = kMaxPhotoCount
                config.library.spacingBetweenItems = 2
                
                //视频配置--默认
                
                //多选后的展示与编辑
                config.gallery.hidesRemoveButton = false
                
                let picker = YPImagePicker(configuration: config)
               
              
                picker.didFinishPicking { [unowned picker] items, cancelled in
                    if cancelled{
                        picker.dismiss(animated: true)
                    }else{
                        var photos:[UIImage] = []
                        var videoURL: URL?
                        
                    for item in items{
                        switch item{
                        case let .photo(photo):
                            photos.append(photo.image)
                        case .video(let video):
                            photos.append(video.thumbnail)
                            videoURL = video.url
                        }
                    }
                    let vc = self.storyboard!.instantiateViewController(identifier: kNoteEditVCID) as! NoteEditVC
                        vc.photos = photos
                        vc.videoURL = videoURL
                    picker.pushViewController(vc, animated: true)
                }
                }
                present(picker, animated: true)
            }else{
                let alert = UIAlertController(title: "提示", message: "需要先登录哦", preferredStyle: .alert)
                let action1 = UIAlertAction(title: "再看看", style: .cancel, handler: nil)
                let action2 = UIAlertAction(title: "去登录", style: .default){_ in
                    tabBarController.selectedIndex = 4
                }
                alert.addAction(action1)
                alert.addAction(action2)
                
                present(alert, animated: true, completion: nil)
            }
            
           
            
            return false
        }else if viewController is OpenRecognizeVC  {
            
            //（判断是否登录）
            if let _ = LCApplication.default.currentUser{
                
                var config = YPImagePickerConfiguration()
                
                //通用配置
                config.isScrollToChangeModesEnabled = false
                config.onlySquareImagesFromCamera = false
                config.albumName =  Bundle.main.appName
                config.startOnScreen = .library
                config.screens = [.library, .video, .photo]
                config.maxCameraZoomFactor = 5
                
                
                //相册配置
                config.library.defaultMultipleSelection = true
                config.library.maxNumberOfItems = kMaxPhotoCount
                config.library.spacingBetweenItems = 2
                
                //视频配置--默认
                
                //多选后的展示与编辑
                config.gallery.hidesRemoveButton = false
                
                let picker = YPImagePicker(configuration: config)
               
              
                picker.didFinishPicking { [unowned picker] items, cancelled in
                    if cancelled{
                        picker.dismiss(animated: true)
                    }else{
                        var photos:[UIImage] = []
                        var videoURL: URL?
                        
                    for item in items{
                        switch item{
                        case let .photo(photo):
                            photos.append(photo.image)
                        case .video(let video):
                            photos.append(video.thumbnail)
                            videoURL = video.url
                        }
                    }
                    let vc = self.storyboard!.instantiateViewController(identifier: kRecognizeVCID) as! RecognizeVC
                        vc.Rphotos = photos
                        vc.RvideoURL = videoURL
                    picker.pushViewController(vc, animated: true)
                }
                }
                present(picker, animated: true)
            }else{
                let alert = UIAlertController(title: "提示", message: "需要先登录哦", preferredStyle: .alert)
                let action1 = UIAlertAction(title: "再看看", style: .cancel, handler: nil)
                let action2 = UIAlertAction(title: "去登录", style: .default){_ in
                    tabBarController.selectedIndex = 4
                }
                alert.addAction(action1)
                alert.addAction(action2)
                
                present(alert, animated: true, completion: nil)
            }
            
           
            
            return false
        }else{
            return true
        }
    
    }



}
