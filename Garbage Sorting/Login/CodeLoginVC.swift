//
//  CodeLoginVC.swift
//  Garbage Sorting
//
//  Created by 谭红雨 on 2022/4/4.
//

import UIKit
import LeanCloud
private let totalTime = 60
class CodeLoginVC: UIViewController {
    
    private var timeRemain = totalTime
    
    @IBOutlet weak var phoneNumTF: UITextField!
    @IBOutlet weak var authCodeTF: UITextField!
    @IBOutlet weak var LoginBtn: UIButton!
    @IBOutlet weak var getAuthCodeBtn: UIButton!
    
    lazy private var timer = Timer()
    
    private var phoneNumStr:String{ phoneNumTF.unwrappedaText }
    private var authCodeStr:String{ authCodeTF.unwrappedaText }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
       
    }
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        //焦点放到手机号码输入框中 并弹出输入键盘
        phoneNumTF.becomeFirstResponder()
        
        
    }

    @IBAction func TFEditingChanged(_ sender: UITextField) {
        if sender == phoneNumTF{
        //判断用户输入的手机号是否合法来决定【获取验证码】的按钮展示与否
        getAuthCodeBtn.isHidden = !phoneNumStr.isPhoneNum && getAuthCodeBtn.isEnabled
        }
       //登录按钮可用判断
       // if( phoneNumStr.isPhoneNum && authCodeStr.isAuthCode ){
       //     LoginBtn.isEnabled = true
       // }else{
       //     LoginBtn.isEnabled = false
       // }
    }
    @IBAction func getAuthCode(_ sender: UIButton) {
        getAuthCodeBtn.isEnabled = false
        setAuthCodeBtnDisabletext()
        authCodeTF.becomeFirstResponder()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeAuthCodeBtnText), userInfo: nil, repeats: true )
        
        let variables: LCDictionary = [
            "name": LCString("垃圾分类"),
            "ttl":LCNumber(5)
        ]

         LCSMSClient.requestShortMessage(
            mobilePhoneNumber: phoneNumStr,
            //模版名称
            templateName: "Order_Notice",
            //签名名称
            signatureName: "sign_BuyBuyBuy",
            //变量
            variables: variables)
        { (result) in
          //  switch result {
          //  case .success:
           //     break
           // case .failure(error: let error):
           //     print(error)
          //  }
            if case let .failure(error: error) = result{
                print(error.reason ?? "短信验证码未知错误")
            }
        }
    }
    
    @IBAction func Login(_ sender: UIButton) {
        //将软键盘收起来
        view.endEditing(true)
        //showLoadHUD()
        //测试手机号15280800234    测试验证码595775
        LCUser.signUpOrLogIn(mobilePhoneNumber: phoneNumStr, verificationCode: authCodeStr){ result in
            switch result {
            case let .success(object:  user):
                //print(user)
                //判断用户是否是首次注册登录位置预留
                //用户首次登陆
                let randomNickName = "垃圾分类\(String.randomString(6))"
                self.configAfterLogin(user, randomNickName)
                
            case let .failure(error:  error):
                print(error)
                DispatchQueue.main.async {
                    self.showTextHUD("登录失败", (error.reason != nil))
                }
            }
        }
        
    }
    
}

extension CodeLoginVC:UITextFieldDelegate{
    //在用户输入之前就可以进行判断
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //range.location -- 当前输入的字符或粘贴文本的第一个字符的索引
        //string -- 当前输入字符或粘贴的文本
        let limit = textField == phoneNumTF ? 11 : 6
        let isExceed = range.location >= limit || (textField.unwrappedaText.count + string.count) > limit
        if(isExceed){
            showTextHUD("最多只能输入\(limit)位哦")
        }
        return !isExceed
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == phoneNumTF{
            authCodeTF.becomeFirstResponder()
        }else{
            if LoginBtn.isEnabled {
                Login(LoginBtn)
            }
        }
        
        return true
    }
  
}
// MARK: - 监听
extension CodeLoginVC{
    @objc private func changeAuthCodeBtnText(){
        timeRemain -= 1
        setAuthCodeBtnDisabletext()
        
        if timeRemain <= 0 {
            timer.invalidate()
            timeRemain = totalTime
            getAuthCodeBtn.isEnabled = true
            getAuthCodeBtn.setTitle("发送验证码", for: .normal)
            
            getAuthCodeBtn.isHidden = !phoneNumStr.isPhoneNum
        }
    }
}
// MARK: - 普通函数
extension CodeLoginVC{
    @objc private func setAuthCodeBtnDisabletext(){
        getAuthCodeBtn.setTitle("重新发送(\(timeRemain)", for: .disabled)
    }
}

