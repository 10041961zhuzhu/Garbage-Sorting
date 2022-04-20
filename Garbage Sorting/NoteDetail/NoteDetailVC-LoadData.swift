//
//  NoteDetailVC-LoadNote.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 12/04/2022.
//

import Foundation
import LeanCloud

extension NoteDetailVC{
    func getFav(){
        if let user = LCApplication.default.currentUser{
            let query = LCQuery(className: kUserFavTable)
            query.whereKey(kUserCol, .equalTo(user))
            query.whereKey(kNoteCol, .equalTo(note))
            query.getFirst{ res in
                if case .success = res{
                    DispatchQueue.main.async {
                        self.favBtn.setSelected(selected: true, animated: false)
                    }
                }
                
            }
            
        }
    }
}
