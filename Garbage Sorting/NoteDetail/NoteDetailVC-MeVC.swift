//
//  NoteDetailVC-MeVC.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 13/04/2022.
//

import Foundation
import LeanCloud

extension NoteDetailVC{
    func noteToMeVC(_ user: LCUser?){
        guard let user = user else{return}
        let meVC = storyboard!.instantiateViewController(identifier: MeVCID){ coder in
            MeVC(coder: coder, user: user)
        }
        meVC.isFromNote = true
        meVC.modalPresentationStyle = .fullScreen
        present(meVC, animated: true)
    }

}

