//
//  MeVC-UI.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 12/04/2022.
//

import Foundation
import SegementSlide

extension MeVC{
    func setUI(){
        scrollView.backgroundColor = .systemBackground
        contentView.backgroundColor = .systemBackground
        switcherView.backgroundColor = .systemBackground
        
        let statusBarOverlayView = UIView(frame: CGRect(x: 0, y: 0, width: screenRect.width, height: kStatusBarH))
        statusBarOverlayView.backgroundColor = .systemBackground
        view.addSubview(statusBarOverlayView)
        
        defaultSelectedIndex = 0
        reloadData()
    }
}
