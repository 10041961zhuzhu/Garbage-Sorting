//
//  Extensions.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 24/03/2022.
//

import UIKit
import DateToolsSwift

extension Optional where Wrapped == String{
    var unwrappedText: String {self ?? ""}
}
extension Date{
    var formattedDate: String{
        let currentYear = Date().year
        if year == currentYear{//今年
            if isToday{//今天
                if minutesAgo > 10{//发布（草稿）超过10分钟显示‘今天xx：xx’
                    return "今天 \(format(with: "HH:mm"))"
                }else{
                    return timeAgoSinceNow
                }
                
            }else if isYesterday{//昨天
                return "昨天 \(format(with: "HH:mm"))"
            }
            else{//前天或更早
                return format(with: "HH:mm")
            }
        }else if year < currentYear{//去年或更早
            return format(with: "yyyy-MM-dd")
        }else{
            return "更远"
        }
    }
}

extension Bundle{
    var appName: String{
        if let appName = localizedInfoDictionary?["CFBundleDisplayName"] as? String{
            return appName
        }else{
            return infoDictionary!["CFBundleDisplayName"] as! String
        }
    }
    // MARK: 静态属性和方法--1.直接用类名进行调用,2.省资源
    // MARK: static和class的区别
    //static能修饰class/struct/enum的存储属性、计算属性、方法;class能修饰类的计算属性和方法
    //static修饰的类方法不能继承；class修饰的类方法可以继承
    //在protocol中要使用static
    
    //加载xib上的view
    //为了更通用，使用泛型。as?后需接类型，故形式参数需为T.Type，实质参数为XXView.self--固定用法
    static func loadView<T>(fromNib name: String, with type: T.Type) -> T{
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T{
            return view
        }
        fatalError("加载\(type)类型的view失败")
    }

}

extension Int{
    var formattedStr: String{
        let num = Double(self)
        let tenThousand = num / 10000
        let hundredMillon = num / 100000000
        
        if tenThousand < 1{
            return "\(self)"
        }else if hundredMillon >= 1{
            return "\(round(hundredMillon * 10) / 10)亿"
        }else{
            return "\(round(tenThousand * 10) / 10)万"
        }
    }
}

extension String{
    var isBlank:Bool{
        self.trimmingCharacters(in:  .whitespacesAndNewlines).isEmpty
    }
    
    var isPhoneNum:Bool{
        //判断当前字符串是否能转换为整数 正则表达式判断
        Int(self) != nil && NSRegularExpression(PhoneRegEx).matches(self)
        
    }
    var isAuthCode:Bool{
        Int(self) != nil && NSRegularExpression(AuthCodeRegEx).matches(self)
    }
    static func randomString(_ length:Int) -> String{
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
extension NSRegularExpression{
    convenience init(_ pattern: String){
        do{
            try self.init(pattern:pattern)
        } catch{
            fatalError("非法的正则表达式")
        }
    }
    func matches(_ string: String)-> Bool{
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string,options: [], range: range) != nil
    }
}
extension UITextField{
    var unwrappedaText: String{text ?? ""}
    var exactText:String {
        unwrappedaText.isBlank ? "":unwrappedaText
    }
}
extension UITextView{
    var unwrappedText: String { text ?? "" }
    var exactText: String { unwrappedText.isBlank ? "" : unwrappedText }
    var isBlank: Bool { unwrappedText.isBlank }
}
extension UIImage{
    
    convenience init?(_ data: Data?) {
        if let unwrappedData = data{
            self.init(data:unwrappedData)
        }else{
            return nil
        }
    }
    
    enum JPEGQuality: CGFloat{
        case lowest = 0
        case low = 0.25
        case medium = 0.5
        case high = 0.75
        case highest = 1
    }
    func jpeg(_ jpegQuality: JPEGQuality) -> Data?{
        jpegData(compressionQuality: jpegQuality.rawValue)
    }
}
extension UIView{
    @IBInspectable
    var radius: CGFloat{
        get{
            layer.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
        }
    }
}
extension UIButton{
    func setToEnabled(){
        isEnabled = true
        backgroundColor = greenBtnColor
    }
    func setToDisabled(){
        isEnabled = false
        backgroundColor = greyBtnColor
    }
    func makeCapsule(_ color: UIColor = .label){
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
    }
}
extension UIViewController{
    
    //加载框：手动隐藏
    func showLoadHUD(_ title: String? = nil){
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = title
    }
    func hideLoadHUD(){
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    //提示框：自动隐藏
    func showTextHUD( _ title:String,_ inCurrentView: Bool = true, _ subTitle:String? = nil){
        var viewToShow = view!
        if !inCurrentView{
            viewToShow = UIApplication.shared.windows.last!
        }
        let hud = MBProgressHUD.showAdded(to: viewToShow, animated: true)
        hud.mode = .text
        hud.label.text = title
        hud.detailsLabel.text = subTitle
        hud.hide(animated: true,afterDelay: 2)
    }
    
    func showLoginHUD(){
        showTextHUD("还没有登录哦！")
    }
    
    func hideKeyboardWhenTappedAround(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        //保证tap手势不会影响到其他touch类控件的手势
        //若不设置，则本页面有tabview时，点击cell不会触发didSelectRowAtIndex（除非长按）
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    @objc func dissmissKeyboard(){
        view.endEditing(true)
        //让view中的所有textfield失去焦点--即关闭小键盘
    }
    //给一个控制器添加子视图控制器
    func add(child vc:UIViewController){
        addChild(vc)
        //将子视图控制器完全覆盖父视图控制器
        vc.view.frame = view.bounds
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    func remove(child vc:UIViewController){
        vc.willMove(toParent: nil)
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }
    
    func removeChildren(){
        if !children.isEmpty{
            for vc in children{
                remove(child: vc)
            }
        }
    }
}


extension FileManager{
    func save(_ data: Data?, to dirName : String, as fileName: String) -> URL?{
        guard let data = data else{
            print("要写入的data为nil")
            return nil
        }
        let dirURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(dirName, isDirectory: true)
        if !fileExists(atPath: dirURL.path){
            guard let _ = try? createDirectory(at: dirURL, withIntermediateDirectories: true)
        else{
            print("创建文件夹失败")
                return nil
            }}
        
        let fileURL = dirURL.appendingPathComponent(fileName)
        if !fileExists(atPath: fileURL.path){
            guard let _ = try? data.write(to: fileURL) else {
                print("写入/保存文件失败")
                return nil
            }
        }
        return fileURL
    }
}

extension UserDefaults{
    static func increase(_ key: String,by val: Int = 1){
        standard.set(standard.integer(forKey: key) + val, forKey: key)
    }
    static func decrease(_ key: String,by val: Int = 1){
        standard.set(standard.integer(forKey: key) - val, forKey: key)
    }
}
