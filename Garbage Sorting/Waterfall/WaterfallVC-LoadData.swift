//
//  WaterfallVC-LoadData.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 06/04/2022.
//

import CoreData
import LeanCloud

extension WaterfallVC{
    func getDraftNotes(){
        let request = DraftNote.fetchRequest() as NSFetchRequest<DraftNote>
        //分页 上拉加载
        //request .fetchLimit = 20
        //request.fetchOffset = 0
        
        //筛选
       // request.predicate = NSPredicate(format: "title = %@" , "IOS")
        
        //排序
        //日期
      //?????  let sortDescriptor1 = NSSortDescriptor(key: "updatedAt", ascending: false)
        //题目
       // let sortDescriptor2 = NSSortDescriptor(key: "title", ascending: true)
        //request.sortDescriptors = [sortDescriptor1]
        request.propertiesToFetch = ["coverPhoto", "title", "isVideo"]
        
        showLoadHUD()
        backgroundContext.perform {
            if let draftNotes = try? backgroundContext.fetch(request){
                self.draftNotes = draftNotes
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            self.hideLoadHUD()
        }
    }
    func getNotes(){
        let query = LCQuery(className: kNoteTable)
        
        query.whereKey(kChannelCol, .equalTo(channel))
        query.whereKey(kAuthorCol, .included)
        query.whereKey(kUpdatedAtCol, .descending)
        query.limit = kNotesOffset
        _ = query.find{ result in
            if case let .success(objects: notes) = result{
                self.notes = notes
                self.collectionView.reloadData()
            }
        }
    }
    func getMyNotes(_ user: LCUser){
        let query = LCQuery(className: kNoteTable)
        
        query.whereKey(kAuthorCol, .equalTo(user))
        query.whereKey(kAuthorCol, .included)
        query.whereKey(kUpdatedAtCol, .descending)
        query.limit = kNotesOffset
        _ = query.find{ result in
            if case let .success(objects: notes) = result{
                self.notes = notes
                self.collectionView.reloadData()
            }
        }
    }
}
