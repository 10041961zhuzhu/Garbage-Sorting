//
//  ViewController.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 22/03/2022.
//

import UIKit
import XLPagerTabStrip

class HomeVC: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        
        //selectedBar--按钮下方的条
        settings.style.buttonBarBackgroundColor = .systemGreen
        settings.style.selectedBarHeight = 3
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemFont = .systemFont(ofSize: 16)
        settings.style.buttonBarItemLeftRightMargin = 0
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        
        super.viewDidLoad()
        
        containerView.bounces = false
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex :Bool, animated: Bool) -> Void in guard changeCurrentIndex == true else {return}
            
            oldCell?.label.textColor = .secondaryLabel
            newCell?.label.textColor = .label
        }
        
    }


    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let discoveryVC=storyboard!.instantiateViewController(identifier:kDiscoveryVCID)
      //  let followVC=storyboard!.instantiateViewController(identifier: kFollowVCID)
        let nearByVC=storyboard!.instantiateViewController(identifier: kNearByVCID)
        
        return [discoveryVC,nearByVC]
    }
}

