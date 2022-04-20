//
//  MeVC.swift
//  Garbage Sorting
//
//  Created by 谭红雨 on 2022/4/7.
//

import UIKit
import LeanCloud
import SegementSlide

class MeVC: SegementSlideDefaultViewController {

    var user: LCUser
    var isFromNote = false
    var isMySelf = false
    init?(coder: NSCoder,user: LCUser) {
        self.user = user
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        setUI()
        
        
    }
    
    override var bouncesType: BouncesType {.child}
    
    override func segementSlideHeaderView() -> UIView?{
        setHeaderView()
    }
    
    //tab标题
    override var titlesInSwitcher: [String] { ["笔记", "收藏", "赞过"] }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        //是否显示草稿cell
        let isMyDraft = (index == 0) && isMySelf && (UserDefaults.standard.integer(forKey: kDraftNoteCount) > 0)
        
        let vc = storyboard!.instantiateViewController(identifier: kWaterfallVCID) as! WaterfallVC
        vc.isMyDraft = isMyDraft
        vc.user = user
        vc.isMyNote = index == 0
        vc.isMyFav = index == 1
        return vc
    }
    
    //tab
    override var switcherConfig: SegementSlideDefaultSwitcherConfig{
        var config = super.switcherConfig
        config.type = .tab
        config.selectedTitleColor = .label
        config.indicatorColor = .systemGreen
        return config
    }
    
    
    //内层滚动视图--用index判断是哪个tab的页面
   /* override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        //是否显示草稿cell
        let isDraft = (index == 0) && isMySelf && (UserDefaults.standard.integer(forKey: kDraftNoteCount) > 0)
        
        let vc = storyboard!.instantiateViewController(identifier: kWaterfallVCID) as! WaterfallVC
        vc.isDraft = isDraft
        vc.user = user
        vc.isMyNote = index == 0
        vc.isMyFav = index == 1
        vc.isMyselfLike = (isMySelf && index == 2)
        vc.isFromMeVC = true
        vc.fromMeVCUser = user
        return vc
    }
    */
    //退出登录(演示)
    //    @IBAction func logoutTest(_ sender: Any) {
    //        LCUser.logOut()
    //
    //        let loginVC = storyboard!.instantiateViewController(identifier: kLoginVCID)
    //
    //        loginAndMeParentVC.removeChildren()
    //        loginAndMeParentVC.add(child: loginVC)
    //
    //    }
    //    @IBAction func showDraftNotes(_ sender: Any) {
    //        let navi = storyboard!.instantiateViewController(identifier: kDraftNotesNaviID)
    //        navi.modalPresentationStyle = .fullScreen
    //        present(navi, animated: true)
    //    }
}


