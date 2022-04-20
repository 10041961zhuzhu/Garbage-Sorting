//
//  WaterfallVC-DataSource.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 06/04/2022.
//

import Foundation
extension WaterfallVC{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if isMyDraft{
            return notes.count + 1
        }else if isDraft{
            return draftNotes.count
        }else{
            return notes.count
        }
    }
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isMyDraft,indexPath.item == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMyDraftNoteWaterfallCellID, for: indexPath)
            return cell
        }else if isDraft{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kDraftNoteWaterfallCellID, for: indexPath) as! DraftNoteWaterfallCell
            cell.draftNote = draftNotes[indexPath.item]
            cell.deleteBtn.tag = indexPath.item
            cell.deleteBtn.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
            return cell
        }else{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kWaterfallCellID, for: indexPath) as! WaterfallCell
            let offset = isMyDraft ? 1 : 0
            cell.note = notes[indexPath.item - offset]
        return cell
    }

    }

}
extension WaterfallVC{
    private func deleteDraftNote(_ index:Int){
        backgroundContext.perform {
            let draftNote = self.draftNotes[index]
            //数据:本地CoreData里的
            backgroundContext.delete(draftNote)
            appDelegate.saveBackgroundContext()
            //数据：内存的
            self.draftNotes.remove(at: index)
            
            UserDefaults.decrease(kDraftNoteCount)
            DispatchQueue.main.async {
                //UI
                self.collectionView.reloadData()
                self.showTextHUD("删除草稿成功")
            }
        }
    }
}

extension WaterfallVC{
    @objc private func showAlert(_ sender: UIButton){
        let index = sender.tag
        
        let alert =  UIAlertController(title: "提示", message: "确认删除该草稿吗？", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "取消", style: .cancel)
        let action2 = UIAlertAction(title: "确认", style: .destructive){_ in
            self.deleteDraftNote(index)
        }
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true)
    }
}
