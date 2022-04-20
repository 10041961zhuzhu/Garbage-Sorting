//
//  NoteEditVC-UI.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 07/04/2022.
//

import PopupDialog

extension NoteEditVC{
    func setUI(){
        addPopup()
        setDraftNoteEditUI()
        setNoteEditUI()
    }
   
}
//编辑草稿笔记
extension NoteEditVC{
    func setDraftNoteEditUI(){
        //编辑草稿笔记时的UI处理
        if let draftNote = draftNote{
            titleTextField.text = draftNote.title
            textView.text = draftNote.text
            channel = draftNote.channel!
            subChannel = draftNote.subChannel!
            poiName = draftNote.poiName!
            
            if !subChannel.isEmpty{
                updateChannelUI()
            }
            if !poiName.isEmpty{
                updatePOINameUI()
            }
        }
    }
    //编辑笔记时的UI处理
    private func setNoteEditUI(){
        if let note = note{
            titleTextField.text = note.getExactStringVal(kTitleCol)
            textView.text = note.getExactStringVal(kTextCol)
            channel = note.getExactStringVal(kChannelCol)
            subChannel = note.getExactStringVal(kSubChannelCol)
            poiName = note.getExactStringVal(kPOINameCol)
            
            if !subChannel.isEmpty{updateChannelUI()}
            if !poiName.isEmpty{updatePOINameUI()}
        }
    }
}

extension NoteEditVC{
    func addPopup(){
        let icon = largeIcon("info.circle")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(showPopup))
        
        let pv = PopupDialogDefaultView.appearance()
        pv.titleColor = .systemGreen
        pv.messageFont = .systemFont(ofSize: 14)
        pv.messageColor = .systemGreen
        pv.messageTextAlignment = .natural
        
        let cb = CancelButton.appearance()
        cb.titleColor = .systemGreen
        cb.separatorColor = .systemGreen
        
        let pcv = PopupDialogContainerView.appearance()
        pcv.backgroundColor = .secondarySystemBackground
        pcv.cornerRadius = 10
    }
}


extension NoteEditVC{
    @objc private func showPopup(){
        let title = "发布小贴士"
        let message =
        """
        垃圾分类鼓励向上、真实、原创的内容，含以下信息的内容不会被展示：
        1、含有不文明语言、照片；
        2、含有网址链接、联系方式；
        3、冒充他人身份或搬运他人作品；
        4、通过有奖方式诱导他人点赞、评论、收藏、转发、关注.
        """
        let popup = PopupDialog(title: title, message: message, transitionStyle: .zoomIn)
        let btn = CancelButton(title: "知道了", action: nil)
        popup.addButton(btn)
        present(popup, animated: true)
    }
}

extension NoteEditVC{
    
    func updateChannelUI(){
        channelLabel.text = subChannel
        channelIcon.tintColor = .systemGreen
        channelLabel.textColor = .systemGreen
        channelPlaceholderLabel.isHidden = true
    }
    func updatePOINameUI(){
        if poiName == ""{
            poiNameIcon.tintColor = .label
            poiNameLabel.text = "添加地点"
            poiNameLabel.textColor = .label
        }else{
            poiNameLabel.text = poiName
            poiNameIcon.tintColor = .systemGreen
            poiNameLabel.textColor = .systemGreen
        }
    }
}
