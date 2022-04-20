//
//  CustomViews.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 08/04/2022.
//

import Foundation


//在class前面定义@IBDesignable,用于UIView的子类,在IB中连上这个类之后就能够实时在IB中渲染
//结合1.IBInspectable属性的didset(圆角,阴影等),2.init(),3.draw方法(label圆角)等
//除此用法外,还可以全部用IBInspectable,之后在IB上调整也能够实时显示(不常用)
@IBDesignable
class BigButton: UIButton{
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    //用代码创建这个btn时走这里,最好加上,以后用代码也能创建这样的button
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        sharedInit()
    }
    
    
    private func sharedInit(){
        backgroundColor = .secondarySystemBackground
        tintColor = .placeholderText
        setTitleColor(.placeholderText, for: .normal)
        
        contentHorizontalAlignment = .leading
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }
}

@IBDesignable
class RoundedLabel: UILabel{
    override func draw(_ rect: CGRect) {
        super.drawText(in: rect.inset(by: UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 5)))
    }
}
