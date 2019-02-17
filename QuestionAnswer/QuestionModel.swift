//
//  QuestionModel.swift
//  DrivingTestSG
//
//  Created by Goto, Satoshi a | RASIA on 8/2/19.
//  Copyright © 2019 Goto, Satoshi a | RASIA. All rights reserved.
//

import Foundation
import UIKit

class QuestionModel {
  
  struct Review {
    var question: String = ""
    var answer: String = ""
    var correct: Bool = false
    
    init(q: String, a: String, c: Bool) {
      self.question = q
      self.answer = a
      self.correct = c
    }
  }
  
  var question_array = [String]()
  var ans1_array = [String]()
  var ans2_array = [String]()
  var ans3_array = [String]()
  var ans_array = [String]()
  var review_array = [Review]()
  
  public func getAnswer(index: Int) -> String {
    return ans_array[index]
  }
  
  public func getAnswerCount() -> Int {
    return ans_array.count
  }
  
  public func getQuestion(index: Int) -> String {
    return question_array[index]
  }
  
  public func getAns1(index: Int) -> String {
    return ans1_array[index]
  }
  
  public func getAns2(index: Int) -> String {
    return ans2_array[index]
  }
  
  public func getAns3(index: Int) -> String {
    return ans3_array[index]
  }
  
  public func fillupQuestion() {
    analyzeJson()
    review_array.removeAll()
  }
  
  private func readJSONFromFile(fileName: String) -> Any?
  {
    var json: Any?
    if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
      do {
        let fileUrl = URL(fileURLWithPath: path)
        // Getting data from JSON file using the file URL
        let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
        json = try? JSONSerialization.jsonObject(with: data)
      } catch {
        // Handle error here
      }
    }
    return json
  }
  
  public func removeQuestionFromQueue(index: Int) {
    question_array.remove(at: index)
    ans1_array.remove(at: index)
    ans2_array.remove(at: index)
    ans3_array.remove(at: index)
    ans_array.remove(at: index)
  }
  
  public func removeQuestionsAll() {
    question_array.removeAll()
    ans1_array.removeAll()
    ans2_array.removeAll()
    ans3_array.removeAll()
    ans_array.removeAll()
    review_array.removeAll()
  }
  
  public func putRealAnswerIntoReview(index: Int, correct: Bool) {
    let question = question_array[index]
    let ans = ans_array[index]
    var answer = ""
    if ans == "ans1" {
      answer = ans1_array[index]
    } else if ans == "ans2" {
      answer = ans2_array[index]
    } else if ans == "ans3" {
      answer = ans3_array[index]
    }
    
    let review = Review.init(q: question, a: answer, c: correct)
    review_array.append(review)
  }
  
  public func getReviewCount() -> Int {
    return review_array.count
  }
  
  public func getReviewValue(index: Int) -> Review {
    return review_array[index]
  }
  
  public func getReviewScore() -> String {
    var correct_answer: Int = 0
    let total: Int = getReviewCount()
    for review in review_array {
      if review.correct {
        correct_answer = correct_answer + 1
      }
    }
    
    return "\(correct_answer)\\\(total)"
  }
  
  private func analyzeJson() {
    let json = readJSONFromFile(fileName: "question")
    if let questions = json as? [String: Any] {
      if let question = questions["questions"] as? [String: Any] {
        for (_, value) in question {
          if let question_detail = value as? [String: Any] {
            for (key2, value2) in question_detail {
              if key2 == "ans1" {
                ans1_array.append((value2 as? String)!)
              } else if key2 == "ans2" {
                ans2_array.append((value2 as? String)!)
              } else if key2 == "ans3" {
                ans3_array.append((value2 as? String)!)
              } else if key2 == "question" {
                question_array.append((value2 as? String)!)
              } else if key2 == "ans" {
                ans_array.append((value2 as? String)!)
              }
            }
          }
        }
      }
    }
  }
}

