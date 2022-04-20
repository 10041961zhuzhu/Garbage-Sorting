//
//  PhotoFooter.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 27/03/2022.
//

import UIKit

class PhotoFooter: UICollectionReusableView {
    
    @IBOutlet weak var addPhotoBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        addPhotoBtn.layer.borderWidth = 1
        addPhotoBtn.layer.borderColor = UIColor.tertiaryLabel.cgColor
    }
}
