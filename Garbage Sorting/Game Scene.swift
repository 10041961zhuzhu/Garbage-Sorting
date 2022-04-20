//
//  Game Scene.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 01/04/2022.
//

import UIKit
import CoreMedia

class GameScene:UIViewController{
    
  
    var currentquestionIndex=0
    var score=0
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressBarViewWidth: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text=questions[0].text
    }
    
    @IBAction func answerPressed(_ sender: UIButton) {
        checkAnswer(sender.tag)
        currentquestionIndex+=1
        nextQuestion()
        updateProgresss()
        
    }
    func nextQuestion(){
        if currentquestionIndex <= 12{
            questionLabel.text=questions[currentquestionIndex].text
        }
        else{
            currentquestionIndex=0//reset
            score=0
            
          let alert = UIAlertController(title: "太棒啦！", message: "您已经完成了所有问题，想要更多测试吗？", preferredStyle: .alert)
            
           let action = UIAlertAction(title: "更多", style: .default, handler: { _ in
               self.updateQuestionText()
               self.updateScoreLabel()
               
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    func updateQuestionText(){
        questionLabel.text = questions[self.currentquestionIndex].text
    }
    func updateScoreLabel(){
        scoreLabel.text="总得分: \(self.score)"
    }
    func updateProgresss(){
        progressLabel.text="\(currentquestionIndex+1) / 13"
        
        progressBarViewWidth.constant = (view.frame.width/13)*CGFloat(currentquestionIndex)
    }
    func checkAnswer(_ tag:Int){
        if tag == 1{
            if questions[currentquestionIndex].answer{
                ProgressHUD.showSuccess("答对了")
                
                score+=1
                updateScoreLabel()
            }
            else{
                ProgressHUD.showError("答错啦")
               
                }
        }else{
            if questions[currentquestionIndex].answer{
                ProgressHUD.showError("答错啦")
            }
            else{
                ProgressHUD.showSuccess("答对了")
        
                score+=1
               updateScoreLabel()
            }
        }
        
    }
    
}



