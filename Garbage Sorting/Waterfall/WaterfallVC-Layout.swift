//
//  WaterfallVC-Layout.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 14/04/2022.
//

import Foundation
import CHTCollectionViewWaterfallLayout

extension WaterfallVC :CHTCollectionViewDelegateWaterfallLayout{
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellW = (screenRect.width - kWaterfallPadding * 3) / 2
    var cellH: CGFloat = 0
    
    if isMyDraft, indexPath.item == 0{
        cellH = 100
    }else if isDraft{
        let draftNote = draftNotes[indexPath.item]
        let imageSize = UIImage(draftNote.coverPhoto)?.size ?? imagePH.size
        let imageH = imageSize.height
        let imageW = imageSize.width
        let imageRatio = imageH / imageW
        cellH = cellW * imageRatio + kDraftNoteWaterfallCellBottomViewH
    }
    else{
        let offset = isMyDraft ? 1 : 0
        let note = notes[indexPath.item - offset]
        let coverPhotoRatio = CGFloat(note.getExactDoubelVal(kCoverPhotoRatioCol))
        cellH = cellW * coverPhotoRatio + kWaterfallCellBottomViewH
    }
    return CGSize(width: cellW, height: cellH)
}
}
