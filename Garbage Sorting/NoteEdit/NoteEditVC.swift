//
//  NoteEditVC.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 25/03/2022.
//

import UIKit
import YPImagePicker
import MBProgressHUD
import SKPhotoBrowser
import AVKit
import LeanCloud

class NoteEditVC: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleCountLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var channelIcon: UIImageView!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var channelPlaceholderLabel: UILabel!
    @IBOutlet weak var poiNameLabel: UILabel!
    @IBOutlet weak var poiNameIcon: UIImageView!
    var dragingIndexPath = IndexPath(item: 0, section: 0)

    var draftNote: DraftNote?
    var updateDraftNoteFinished:(() -> ())?
    var postDraftNoteFinished: (() -> ())?
    
    var note: LCObject?
    var updateNoteFinished: ((String) -> ())?
    
    //var photos = [UIImage(named: "1")!, UIImage(named: "2")!]
    var photos:[UIImage] = []
    var videoURL: URL?
    //Bundle.main.url(forResource: "testVideo-filmage", withExtension: "mp4")!
    
    var channel = ""
    var subChannel = ""
    var poiName = ""
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var photoCollectionview: UICollectionView!
    
    @IBAction func TFEditBegin(_ sender: Any) {
        titleCountLabel.isHidden = false
    }

    @IBAction func TFEditChanged(_ sender: Any) {
        titleCountLabel.text = "\(kMaxNoteTitleCount - titleTextField.unwrappedaText.count)"
    }
    @IBAction func TFEditEnd(_ sender: Any) {
        titleCountLabel.isHidden = true
    }
    var photoCount: Int{photos.count}
    var isVideo: Bool{videoURL != nil}
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  photoCollectionview.dragInteractionEnabled = true
      //  titleCountLabel.text = "\(kMaxNoteTitleCount)"
        config()
        setUI()
        //点击空白处隐藏键盘
        hideKeyboardWhenTappedAround()
    }
    
    
    @IBAction func saveDraftNote(_ sender: Any) {

        guard isValidateNote() else {return}
        if let draftNote = draftNote {
            updateDraftNote(draftNote)
        }else{
            createDraftNote()
        }
    }
    
    @IBAction func postNote(_ sender: Any) {
        guard isValidateNote() else {return}
        
        if let draftNote = draftNote{//发布草稿笔记
            postDraftNote(draftNote)
        }else if let note = note{//更新笔记
            updateNote(note)
        }else{//发布新笔记
            createNote()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let channelVC = segue.destination as? ChannelVC{
            channelVC.PVDelegate = self
        }else if let poiVC = segue.destination as? POIVC{
            poiVC.delegate = self
            poiVC.poiName = poiName
        }
    }
}
    extension NoteEditVC:UITextFieldDelegate{
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if range.location >= kMaxNoteTitleCount{
                return false
            }
            return true
        }
}

extension NoteEditVC: ChannelVCDelegate{
    func updateChannel(channel: String, subChannel: String) {
        //数据
        self.channel = channel
        self.subChannel = subChannel
        //UI
        updateChannelUI()
    }
}

extension NoteEditVC: POIVCDelegate{
    func updatePOIName(_ poiName: String) {
        //数据
        if poiName == kPOIsInitArr[0][0]{
            self.poiName = ""
        }else{
            self.poiName = poiName
        }
        //UI
        updatePOINameUI()
    }
    
}
