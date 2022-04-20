//
//  NearByVC.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 22/03/2022.
//

import UIKit
import XLPagerTabStrip

class NearByVC: UIViewController ,IndicatorInfoProvider{


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        IndicatorInfo(title:NSLocalizedString("变废为宝", comment: "变废为宝标签"))
    }
    

}
