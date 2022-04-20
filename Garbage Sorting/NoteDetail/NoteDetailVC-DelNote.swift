//
//  NoteDetailVC-DelNote.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 11/04/2022.
//

import Foundation
import LeanCloud
extension NoteDetailVC{
    func delNote(){
        showDelAlert(for: "笔记"){ _ in
            //数据
            self.delLCNote()
            //UI
            self.dismiss(animated: true){
                self.delNoteFinished?()
            }
        }
    }
    
    private func delLCNote(){
        note.delete{ res in
            if case .success = res {
                self.showTextHUD("已经删除")
                }
            }
}
}
