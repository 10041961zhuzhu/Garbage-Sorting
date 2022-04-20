//
//  NoteEditVC-DraftNote.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 07/04/2022.
//

import Foundation

extension NoteEditVC{
    func createDraftNote(){
        backgroundContext.perform {
            let draftNote = DraftNote(context: backgroundContext)
            
            if self.isVideo{
                draftNote.video = try? Data(contentsOf: self.videoURL!)
            }
            //图片
            self.handlePhotos(draftNote)
            
            draftNote.isVideo = self.isVideo
            self.handleOthers(draftNote)
            
            UserDefaults.increase(kDraftNoteCount)
            DispatchQueue.main.async {
                self.showTextHUD("保存草稿成功", false)
            }
        }
        dismiss(animated: true)
    }
    //更新草稿
    func updateDraftNote(_ draftNote: DraftNote){
        backgroundContext.perform {
            if !self.isVideo{
                self.handlePhotos(draftNote)
            }
            self.handleOthers(draftNote)
            DispatchQueue.main.async {
                self.updateDraftNoteFinished?()
            }
        }
        navigationController?.popViewController(animated: true)
    }
}

extension NoteEditVC{
    private func handlePhotos(_ draftNote: DraftNote){
        draftNote.coverPhoto = photos[0].jpeg(.high)
        
        var photos: [Data] = []
        for photo in self.photos {
            if let pngData = photo.pngData(){
                photos.append(pngData)
            }
        }
        draftNote.photos = try? JSONEncoder().encode(photos)
    }
    
    private func handleOthers(_ draftNote: DraftNote){
        DispatchQueue.main.async {
            draftNote.text = self.textView.text
            draftNote.title = self.titleTextField.text
        }
        draftNote.channel = channel
        draftNote.subChannel = subChannel
        draftNote.poiName = poiName
        draftNote.updateAt = Date()
        appDelegate.saveBackgroundContext()
    }
}
