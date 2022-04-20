//
//  Question.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 01/04/2022.
//

import Foundation
class Question{
    var text:String
    var answer:Bool
    init(text:String,answer:Bool){
        self.text=text
        self.answer=answer
    }
}
let questions:[Question]=[
    Question(text:"电池是可回收垃圾",answer:false),
Question(text:"有害垃圾应投入红色的垃圾桶",answer:true),
    Question(text:"其他垃圾应该投入灰色垃圾桶",answer:true),
    Question(text:"旧衣服属于可回收垃圾",answer:false),
    Question(text:"过期药品是可回收垃圾",answer:false),
    Question(text:"茶叶渣应该倒入厨余垃圾",answer:true),
    Question(text:"保鲜袋属于其他垃圾",answer:true),
    Question(text:"有机玻璃制品是可回收垃圾",answer:false),
    Question(text:"一次性纸杯是可回收垃圾",answer:false),Question(text:"抽完的烟蒂应投入灰色垃圾桶",answer:true),
    Question(text:"饮料及牛奶等纸包装盒是可回收垃圾",answer:true),
    Question(text:"一次性餐具不是可回收垃圾",answer:true),
    Question(text:"可回收垃圾可进行降解堆肥处理",answer:false)]
