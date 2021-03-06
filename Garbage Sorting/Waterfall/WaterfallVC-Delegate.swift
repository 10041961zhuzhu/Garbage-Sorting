//
//  WaterfallVC-Delegate.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 06/04/2022.
//

import Foundation

extension WaterfallVC{
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isDraft{
            let draftNote = draftNotes[indexPath.item]
            
            if let photosData = draftNote.photos,
               let photoDataArr = try? JSONDecoder().decode([Data].self, from: photosData){
                
                let photos = photoDataArr.map { UIImage($0) ?? imagePH }
                
                let videoURL = FileManager.default.save(draftNote.video, to: "video", as: "\(UUID().uuidString).mp4")
                
                let vc = storyboard!.instantiateViewController(identifier: kNoteEditVCID) as! NoteEditVC
                vc.draftNote = draftNote
                vc.photos = photos
                vc.videoURL = videoURL
                vc.updateDraftNoteFinished = {
                    self.getDraftNotes()
                }
                navigationController?.pushViewController(vc, animated: true)
            }else{
                showTextHUD("加载草稿失败")
            }
        }else{
            //依赖注入
            let detailVC = storyboard!.instantiateViewController(identifier: kNoteDetailVCID){
                coder in NoteDetailVC(coder: coder, note: self.notes[indexPath.item])
            }
            if let cell = collectionView.cellForItem(at: indexPath) as? WaterfallCell{
                detailVC.isLikeFromWaterfallCell = cell.isLike
            }
            detailVC.delNoteFinished = {
                self.notes.remove(at: indexPath.item)
                collectionView.performBatchUpdates{collectionView.deleteItems(at: [indexPath])
                    
                }
            }
            detailVC.modalPresentationStyle = .fullScreen
            present(detailVC, animated: true)
            
        }
    }
}
