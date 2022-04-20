//
//  RecognizeVC.swift
//  Garbage Sorting
//
//  Created by 谭红雨 on 2022/4/14.
//

import UIKit
import Alamofire
class RecognizeVC: UIViewController {

    var Rphotos:[UIImage] = []
    var RvideoURL: URL?
    var RphotoCount: Int{Rphotos.count}
    var RisVideo: Bool{RvideoURL != nil}
    var imagePNG:UIImage? = nil
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var rubbishType: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = Rphotos[0]
        imagePNG = Rphotos[0]
        print("图片imagePNG:\(imagePNG)")
        //uploadimg(im: imagePNG!) 调用函数
        //直接提交
        let im = imagePNG!
        let urlString = "http://127.0.0.1:5000/GetType"
        let httpHeaders = HTTPHeaders([:])
        let imageData : Data = im.jpegData(compressionQuality: 0.5)!
        Alamofire.AF.upload(multipartFormData: { multiPart in
            multiPart.append(imageData, withName: "file", fileName: "rubbish.jpg", mimeType: "image/jpg")
        }, to: urlString, method: .post, headers: httpHeaders).uploadProgress(queue: .main) { progress in
            
        }.responseJSON { response in
            switch response.result {
                  case .success(let result):
                    debugPrint(response)
                    if let json = result as? Dictionary<String, Any> {
                        if let type = json["Type"] as? String {
                            let rtype = type
                            print(rtype)
                            self.rubbishType.text = "\(rtype)"
                        }
                    }
                  case .failure(let error):
                    debugPrint("识别失败：\(error)")
                }
        }
        //rubbishType.text = "\(RType)"
    }
    


}
