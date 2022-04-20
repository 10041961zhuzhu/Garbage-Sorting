//
//  DiscoveryVC.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 22/03/2022.
//

import UIKit
import XLPagerTabStrip

class DiscoveryVC: ButtonBarPagerTabStripViewController ,IndicatorInfoProvider{

    override func viewDidLoad() {
        
        settings.style.selectedBarHeight = 0
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemFont = .systemFont(ofSize: 14)
        super.viewDidLoad()

        containerView.bounces = false
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex :Bool, animated: Bool) -> Void in guard changeCurrentIndex == true else {return}
            
            oldCell?.label.textColor = .secondaryLabel
            newCell?.label.textColor = .systemGreen
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        var vcs:[UIViewController] = []
        for channel in kChannels{
        let vc = storyboard!.instantiateViewController(identifier: kWaterfallVCID) as! WaterfallVC
            vc.channel = channel
            vcs.append(vc)
        }
        return vcs
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        IndicatorInfo(title:NSLocalizedString("物归原主", comment: "物归原主标签"))
    }
}
