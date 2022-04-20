//
//  SingInWithAli.swift
//  Garbage Sorting
//
//  Created by 谭红雨 on 2022/3/31.
//

import UIKit


class SingInWithAli: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func ALILogin(_ sender: UIButton) {
        let InfoStr = "apiname=com.alipay.account.auth&app_id=\(AliAppid)&app_name=mc&auth_type=AUTHACCOUNT&biz_type=openservice&method=alipay.open.auth.sdk.code.get&pid=\(AliPid)&product_id=APP_FAST_LOGIN&scope=kuaijie&sign_type=RSA2&target_id=20141225xxxx"
       guard let signer = APRSASigner(privateKey: AliPrivateKey),
             let signedStr = signer.sign(InfoStr, withRSA2: true)
       else { return }
        
      let authInfoStr = "\(InfoStr)&sign=\(signedStr)"
      print(authInfoStr)
        
        AlipaySDK.defaultService()?.auth_V2(withInfo: authInfoStr, fromScheme: AppScheme){ res in
            print(res)
        }
        
    }
    
   
  

    
 
   
  
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
