//
//  QuestionViewController.swift
//  DrivingTestSG
//
//  Created by Goto, Satoshi a | RASIA on 8/2/19.
//  Copyright © 2019 Goto, Satoshi a | RASIA. All rights reserved.
//

import UIKit
import GoogleMobileAds

var questionModel = QuestionModel()

class QuestionViewController: UIViewController, GADBannerViewDelegate {
  
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var Ans1: UIButton!
  @IBOutlet weak var Ans2: UIButton!
  @IBOutlet weak var Ans3: UIButton!
  
  @IBOutlet weak var admobView: GADBannerView!
  
  var random_number = 0
  
  @IBAction func Ans1_pressed(_ sender: Any) {
    let ans = questionModel.getAnswer(index: random_number)
    if (ans == "ans1") {
      showToast(message: "correct!", correct: true)
      refillQuestion(correct: true)
    } else {
      showToast(message: "wrong", correct: false)
      refillQuestion(correct: false)
    }
  }
  
  @IBAction func Ans2_pressed(_ sender: Any) {
    let ans = questionModel.getAnswer(index: random_number)
    if (ans == "ans2") {
      showToast(message: "correct!", correct: true)
      refillQuestion(correct: true)
    } else {
      showToast(message: "wrong", correct: false)
      refillQuestion(correct: false)
    }
  }
  
  @IBAction func Ans3_pressed(_ sender: Any) {
    let ans = questionModel.getAnswer(index: random_number)
    if (ans == "ans3") {
      showToast(message: "correct!", correct: true)
      refillQuestion(correct: true)
    } else {
      showToast(message: "wrong", correct: false)
      refillQuestion(correct: false)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    questionModel.fillupQuestion()
    newQuestion()
    self.tabBarController?.delegate = self
    
    admobView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
    admobView.rootViewController = self
    let req = GADRequest()
    admobView.load(req)
  }
  
  func refillQuestion(correct: Bool) {
    questionModel.putRealAnswerIntoReview(index: random_number, correct: correct)
    questionModel.removeQuestionFromQueue(index: random_number);
    newQuestion()
  }
  
  func newQuestion() {
    let question_count = questionModel.getAnswerCount()
    if question_count > 0 {
      random_number = Int.random(in: 0 ..< question_count)
      questionLabel.text = questionModel.getQuestion(index: random_number)
      Ans1.setTitle(questionModel.getAns1(index: random_number), for: .normal)
      Ans1.titleLabel!.numberOfLines = 0; // Dynamic number of lines
      Ans1.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping;
      Ans2.setTitle(questionModel.getAns2(index: random_number), for: .normal)
      Ans2.titleLabel!.numberOfLines = 0; // Dynamic number of lines
      Ans2.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping;
      Ans3.setTitle(questionModel.getAns3(index: random_number), for: .normal)
      Ans3.titleLabel!.numberOfLines = 0; // Dynamic number of lines
      Ans3.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping;
    } else {
      self.tabBarController!.selectedIndex=1;
    }
  }
}

extension QuestionViewController : UITabBarControllerDelegate  {
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    let tabBarIndex = tabBarController.selectedIndex
    if tabBarIndex == 0 {
      if (questionModel.getAnswerCount() == 0) {
        questionModel.fillupQuestion()
        newQuestion()
      }
    }
  }
}

extension QuestionViewController {
  
  func showToast(message : String, correct : Bool) {
    
    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height/2, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    if correct == true {
      toastLabel.textColor = UIColor.green
    } else {
      toastLabel.textColor = UIColor.red
    }
    toastLabel.textAlignment = .center;
    toastLabel.font = UIFont(name: "Montserrat-Light", size: 16.0)
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
      toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
      toastLabel.removeFromSuperview()
    })
  } }
