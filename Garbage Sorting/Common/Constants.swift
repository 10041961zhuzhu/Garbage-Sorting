//
//  Constants.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 22/03/2022.
//

import UIKit


let kDiscoveryVCID = "DiscoveryVCID"
//let kFollowVCID = "FollowVCID"
let kNearByVCID = "NearByVCID"
let kWaterfallCellID = "WaterfallCellID"
let kNoteEditVCID = "NoteEditVCID"
let kPhotoCellID = "PhotoCellID"
let kWaterfallVCID = "WaterfallVCID"
let kPhotoFooterID = "PhotoFooterID"
let kChannelTableVCID = "ChannelTableVCID"
let kSubChannelCellID = "SubChannelCellID"
let kPOICellID = "POICellID"
let kDraftNoteWaterfallCellID = "DraftNoteWaterfallCellID"
let kNoteDetailVCID = "NoteDetailVCID"
let kDraftNoteCount = "draftNoteCount"
let kMyDraftNoteWaterfallCellID = "MyDraftNoteWaterfallCellID"

//UI布局
let screenRect = UIScreen.main.bounds

//CoreData
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let persistentContainer = appDelegate.persistentContainer
let context = persistentContainer.viewContext
let backgroundContext = persistentContainer.newBackgroundContext()

//笔记
let kWaterfallPadding = CGFloat(4)
let kDraftNoteWaterfallCellBottomViewH: CGFloat = 95.5
let kMaxNoteTitleCount = 20
let kWaterfallCellBottomViewH: CGFloat = 83.5

//话题
let kChannels = [NSLocalizedString("推荐", comment: "推荐标签"),NSLocalizedString("可回收物", comment: "可回收物标签"),NSLocalizedString("厨余垃圾", comment: "厨余垃圾标签"),NSLocalizedString("有害垃圾", comment: "有害垃圾标签"),NSLocalizedString("其他垃圾", comment: "其他垃圾标签")]
let kAllSubChannels = [["推荐","环保","关注","健康","生态"],["可回收物","北京","废纸","废弃塑料瓶","上海","西部地区","废金属","废弃电器电子产品","废玻璃"],["厨余垃圾","骨骼内脏","菜梗菜叶","果皮","果壳","残枝落叶","剩菜剩饭","北京","上海"],["有害垃圾","污染","北京","废弃","电池类","含汞类","废药类","超标","设备","净化","文明和谐","许可"],["其他垃圾","砖瓦陶瓷","大棒骨","渣土","卫生间废纸","纸巾","难以回收的废弃物","尘土","食品袋","食品盒"]]

//高德
let kNoPOIPH = "未知地点"
let kPOITypes = "汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施"
let kPOIsInitArr = [["不显示位置",""]]
let kPOIsOffset = 20

//云端
let kNotesOffset = 20
let kMaxPhotoCount = 9

//资源文件相关
let blueColor = UIColor(named: "blue")
let imagePH = UIImage(named: "imagePH")!


//全局函数
func largeIcon(_ iconName: String, with color: UIColor = .systemGreen) -> UIImage{
    let config = UIImage.SymbolConfiguration(scale: .large)
    let icon = UIImage(systemName: iconName, withConfiguration: config)!
    
    return icon.withTintColor(color)
}

func fontIcon(_ iconName: String, fontSize: CGFloat, with color: UIColor = .systemGreen) -> UIImage{
    let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: fontSize))
    let icon = UIImage(systemName: iconName, withConfiguration: config)!
    
    return icon.withTintColor(color)
}

func showGlobalTextHUD(_ title: String){
    let window = UIApplication.shared.windows.last!
    let hud = MBProgressHUD.showAdded(to: window, animated: true)
    hud.mode = .text //不指定的话显示菊花和配置的文本
    hud.label.text = title
    hud.hide(animated: true, afterDelay: 2)
}

//通用字段
let kCreatedAtCol = "createdAt"
let kUpdatedAtCol = "updatedAt"

//thy新增
//StoryboardID
let CodeLoginVCID = "CodeLoginVCID"
let MeVCID = "MeVCID"
let PasswordLoginVCID = "PasswordLoginVCID"
let kDraftNotesNaviID = "DraftNotesNaviID"
let kRecognizeVCID = "RecognizeVCID"
//资源文件相关
let greyBtnColor = UIColor(named: "greybc")
let greenBtnColor = UIColor(named: "greenbc")
let mainColor = UIColor(named: ".systemGreen")

//正则表达式 \转义
let PhoneRegEx = "^1\\d{10}$"
let AuthCodeRegEx = "^\\d{6}$"
//LeanCloud相关
let LCAppid = "NuTLvYbETlQnSBCDVdupNFg1-gzGzoHsz"
let LCAppKey = "Iw8ylQDjsDs15f376Sd31y3M"
let LCServerURL = "https://nutlvybe.lc-cn-n1-shared.com"
//表
let kNoteTable = "Note"
let kUserLikeTable = "userLike"
let kUserFavTable = "userFav"
let kUserInfoTable = "UserInfo"
//Note表
let kCoverPhotoCol = "coverPhoto"
let kCoverPhotoRatioCol = "coverPhotoRatio"
let kPhotosCol = "photos"
let kVideoCol = "video"
let kTitleCol = "title"
let kTextCol = "text"
let kChannelCol = "channel"
let kSubChannelCol = "subChannel"
let kPOINameCol = "poiName"
let kIsVideoCol = "isVideo"
let kLikeCountCol = "likeCount"
let kFavCountCol = "favCount"
let kCommentCountCol = "commentCount"
let kAuthorCol = "author"
let kHasEditCol = "hasEdit"

//UserLike表
let kUserCol = "user"
let kNoteCol = "note"
//User表
let nickNameCol = "nickName"
let avatarCol = "avatar"
let genderCol = "gender"
let introCol = "intro"
let kIDCol = "id"
let kBirthCol = "birth"
let kIsSetPasswordCol = "isSetPassword"

//UserInfo表
let kUserObjectIdCol = "userObjectId"

//支付宝登录相关
let AppScheme = "GarbageSorting"
let AliAppid = "2021003125674333"
let AliPid = "2088432074655406"
let AliPrivateKey = "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCI5AAeskTZXFlOtc56rd6X6viRuMSdp68j7yzDoi7HP8TMTgesb6Pq/GDlTMlc2XFWqZx2Lbesj7M+7Hi8I3BnWWB+gyXQW7JRMWYUpGWVzUfAlOqfyqDPR1ULG9Hy8IA7YEthLaIh7qD31ZUFCL2viHBB4kyCKDO7knLqVCBH/aE1kPrLTBauvV8Ud6k4eF+KAfBdQInsv9HTCtyLSecEF6jDk2c3umj16FA/9USRkE+FA3sHNtlazRkFLNEVfF9Xre78VPANhs6FXN+uf6nI2z46SEeXYbRmHyS8NqglcMugv9/ZTxffpQLroSMSnWo9TSdYF+3QXcMCyL+ZrKKrAgMBAAECggEAWFiNm0ICHSX0nU/IinRcDD+hXKqaegUWi2J4yWmKNx14rUJOwYLrj2SCRHpiGoJbG0srpzmqKLw1Oo7y/LkCejC8jemmJeqIEs6GyxuuVBfADxIMukPTtPKceCbkQJ3mpGtpOrZwxOV1DX3SRwV1JiwwBtU9+2JmwM+rSoAwtUSMAwccGLPpFBmeqlwCuqe/4i7NoUYso9FqtbcBp83aLn0kQA5AQpY4KMsfGY93JllFYyJWWh/4cMpIR1pxFqaPJxNBaDz/IJQwtee/2m4CNNkW7iUiMK1Ww0Dz9I/SpdCGY3A+v3/c5BE26SHg5AoitsHmdGio69fD1iDv0wsZwQKBgQDngqn7Aq3YP7/HLsaIfcV2GxLzfCjT7yArKMKgTYKPUtMx5tVm0cO1N3tnGZDP4xHJ8IPSEvk3NAAaWFMcqdMcf5zfmvV2TLy/wPBrcR1YCW3ydf23zlH47+fslKvAb5xBTwZ1Lim0TzZsDHQ8Er0QF00Em9M1MruoeXWP8pJ5FwKBgQCXXwTU4lRX2rXRNAU0J2/JE57Bg9weIakNtaaQBCk8siSipslUf/mK1ZlcjnUC6APyTmMhl2FNzFWhpjNHwgu2rjd0acJnIDTRQqdMeSXpJFDNP4uvdzvAAn33esE85YFgaVA72Ol3S8hwp1dzrJMUkAOKwNNJqCLnj+3/1mQ3jQKBgQDCFHMloAhXWpIOjDMZp76LFYVco8CiczwXknMe6fvC5V9x3R8XtFCKMfn845zX+ncmQMBxs0BDvA8+Br+eLuxxXrYHaqPOyeQOKNQkbk54SGdotOu/VHK5630Vg0k86RQoV/SE9e82XpW0HPiwh9EBlVcWvv9gAKj7Qt+Ajo2mfwKBgGPlDxk2rBa2fVqsi+qZRApc6l4nGPLBoAEuKdfNBzHJFqhIjYE4W4Sl5enREaNzXndgB8e5UTu4Z6KgPiNTCcvrOSmYSfUoqfKXnDS5lq0/jBuHnjWT6FiUzHCwECqSA0mO9qYoRhq2ZncB2JK8BuyBBfVhv45SaYaL07MM12JZAoGBAKpO4c6kY3TNlX+SXDMLjyqlLepzLSOirhci2oloJ+jNoLPBp5ItdutbopjyjH/ndZxEVI6Zip52HITy+z1sxb8JePfIUsi8xbkElnrQjPSQfNjO+78Wiw2IzaLXt+v0jSG4ZU3IrMBJybfYKAcnn+86hYOXXQlBClGVGUC+XC8F"

