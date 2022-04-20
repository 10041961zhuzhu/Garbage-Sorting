//
//  NoteDetailVC-Helper.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 11/04/2022.
//

import Foundation
extension NoteDetailVC{
    func showDelAlert(for name: String, confirmHandler: ((UIAlertAction) -> ())?){
        let alert = UIAlertController(title: "提示", message: "确认删除此\(name)", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "取消", style: .cancel)
        let action2 = UIAlertAction(title: "确认", style: .default, handler: confirmHandler)
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true)
    }
}
