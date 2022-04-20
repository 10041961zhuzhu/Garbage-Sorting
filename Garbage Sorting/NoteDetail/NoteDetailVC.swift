//
//  NoteDetailVC.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 08/04/2022.
//

import UIKit
import ImageSlideshow
import LeanCloud
import FaveButton

class NoteDetailVC: UIViewController {
    
    var note: LCObject
    var isLikeFromWaterfallCell = false
    var delNoteFinished: (() -> ())?

    @IBOutlet weak var imageSlideshow: ImageSlideshow!
    //上方bar
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var authorNickNameBtn: UIButton!
    @IBOutlet weak var authorAvatarBtn: UIButton!
    //tableheaderview
    @IBOutlet weak var imageSlideShowHeight: NSLayoutConstraint!
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    //这里不使用UITextView是因其默认是滚动状态,不太方便搞成有多少就显示多少行的状态,实际开发中显示多行文本一般是用Label
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var channelBtn: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    //整个tableView
    @IBOutlet weak var tableView: UITableView!
    
    //下方bar(点赞收藏评论)
    @IBOutlet weak var likeBtn: FaveButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var favBtn: FaveButton!
    @IBOutlet weak var favCountLabel: UILabel!
    @IBOutlet weak var commentCountBtn: UIButton!
    
  //  @IBOutlet weak var textViewBarView: UIView!
   // @IBOutlet weak var textView: GrowingTextView!
  //  @IBOutlet weak var textViewBarBottomConstraint: NSLayoutConstraint!
    
    var likeCount = 0{
        didSet{
            likeCountLabel.text = likeCount == 0 ? "点赞" : likeCount.formattedStr
        }
    }
    
    var favCount = 0{
        didSet{
            favCountLabel.text = favCount == 0 ? "收藏" : favCount.formattedStr
        }
    }
    var currentLikeCount = 0
    var currentFavCount = 0
    var commentCount = 0{
        didSet{
            commentCountLabel.text = "\(commentCount)"
            commentCountBtn.setTitle(commentCount == 0 ? "评论" : commentCount.formattedStr, for: .normal )
        }
    }
    
    
    var author: LCUser?{
        note.get(kAuthorCol) as? LCUser}
    var isLike: Bool { likeBtn.isSelected }
    var isFav: Bool{favBtn.isSelected}
    var isReadMyNote: Bool{
        if let user = LCApplication.default.currentUser, let author = author, user == author{
            return true
        }
        else
        {
            return false
        }
    }
    
    init?(coder: NSCoder,note: LCObject){
        self.note = note
        super.init(coder: coder)
    }
    
    required init?(coder:NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config() 
        getFav()
        setUI()
    }
    
    
    override func viewDidLayoutSubviews() {
        let height = tableHeaderView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = tableHeaderView.frame
        
        if frame.height != height{
            frame.size.height = height
            tableHeaderView.frame = frame
            
        }
    }

    
    @IBAction func like(_ sender: Any) {
        like()
    }
    
    @IBAction func fav(_ sender: Any) {
        fav()
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func shareOrMore(_ sender: Any) {
       shareOrMore()
    }
    @IBAction func goToAuthorMeVC(_ sender: Any) {
        noteToMeVC(author)
    }
}
