//
//  NoteEditVC-DragDrop.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 27/03/2022.
//

import Foundation

extension NoteEditVC: UICollectionViewDragDelegate{
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        let photo = photos[indexPath.item]
       let dragItem = UIDragItem(itemProvider: NSItemProvider(object: photos[indexPath.item]))
        dragItem.localObject = photo
        return  [dragItem]
    }
}
    
    extension NoteEditVC:UICollectionViewDropDelegate{
        
        func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
            
            dragingIndexPath.section == destinationIndexPath?.section
            
            if collectionView.hasActiveDrag{
                return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
            return UICollectionViewDropProposal(operation: .forbidden)
        }
        func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
            if coordinator.proposal.operation == .move,
               let item = coordinator.items.first,
               let sourceIndexPath = item.sourceIndexPath,
               let destinationIndexPath = coordinator.destinationIndexPath {
                collectionView.performBatchUpdates{
                photos.remove(at: sourceIndexPath.item)
                photos.insert(item.dragItem.localObject as! UIImage, at: destinationIndexPath.item)
                collectionView.moveItem(at: sourceIndexPath, to: destinationIndexPath)
            }
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        }
        }
}
