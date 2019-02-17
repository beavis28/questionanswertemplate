//
//  DrivingTestViewController.swift
//  DrivingTestSG
//
//  Created by Goto, Satoshi a | RASIA on 8/2/19.
//  Copyright © 2019 Goto, Satoshi a | RASIA. All rights reserved.
//

import UIKit

class ReviewTestViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
}

extension ReviewTestViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return questionModel.getReviewCount()
  }
  
  @objc func buttonClicked() {
    questionModel.removeQuestionsAll()
    tableView.reloadData()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reviewItem", for: indexPath) as! TestViewReviewCell
    let review = questionModel.getReviewValue(index: indexPath.row)
    cell.question_label?.text = review.question
    cell.answer_label?.text = review.answer
    if review.correct {
      cell.answer_label?.textColor = UIColor.green
    } else {
      cell.answer_label?.textColor = UIColor.red
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 60))
    
    let label = UILabel()
    label.frame = CGRect.init(x: 20, y: 0, width: headerView.frame.width/2, height: headerView.frame.height)
    label.text = "Score \(questionModel.getReviewScore())"
    label.font = UIFont(name:"MarkerFelt-Wide", size: 24.0)
    label.textColor = UIColor.green
    
    headerView.addSubview(label)
    headerView.backgroundColor = UIColor(red:0.20, green:0.20, blue:0.22, alpha:1.0)
    
    let button = UIButton(frame: CGRect.init(x: headerView.frame.width - 50, y: 0, width: 50, height: headerView.frame.height))
    button.setImage(UIImage(named: "trash"), for: .normal)
    button.backgroundColor = UIColor(red:0.20, green:0.20, blue:0.22, alpha:1.0)
    button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
    headerView.addSubview(button)
    
    return headerView
  }
  
}

extension ReviewTestViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return CGFloat(60)
  }
}

class TestViewReviewCell: UITableViewCell {
  @IBOutlet weak var question_label: UILabel!
  @IBOutlet weak var answer_label: UILabel!
}
