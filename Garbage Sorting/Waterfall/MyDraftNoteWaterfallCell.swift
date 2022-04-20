//
//  MyDraftNoteWaterfallCell.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 14/04/2022.
//

import UIKit

class MyDraftNoteWaterfallCell: UICollectionViewCell {

    @IBOutlet weak var CountLabel: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        CountLabel.text = "\(UserDefaults.standard.integer(forKey: kDraftNoteCount))"
    }

}
