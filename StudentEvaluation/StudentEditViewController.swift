//
//  StudentEditViewController.swift
//  StudentEvaluation
//
//  Created by Fenix Lavon on 5/4/21.
//  Copyright © 2021 Fenix Lavon. All rights reserved.
//

import UIKit

class StudentEditViewController: UIViewController {
	var indexPath: IndexPath?
	var firstName = ""
	var secondName = ""
	var averageEval = ""
	var newStudent = false
	weak var delegate: StudentControllerDelegate?
	
	override func viewDidLoad() {
			super.viewDidLoad()
			
		firstNameLabel.text = firstName
		secondNameLabel.text = secondName
		averageEvalLabel.text = averageEval
	}
	@IBOutlet weak var firstNameLabel: UITextField!
	@IBOutlet weak var secondNameLabel: UITextField!
	@IBOutlet weak var averageEvalLabel: UITextField!
	
	@IBAction func saveButton(_ sender: Any) {
		if indexPath == nil {
			Student.testData.append(Student(firstName: firstNameLabel.text!,
											secondName: secondNameLabel.text!,
											evalution: UInt8(averageEvalLabel.text!)!))
		}
		var student = Student.testData[indexPath?.row ?? Student.testData.count - 1]
		student.firstName = firstNameLabel.text!
		student.secondName = secondNameLabel.text!
		student.evalution = UInt8(averageEvalLabel.text!)!
		delegate?.configure(with: student, index: indexPath)
		self.navigationController?.popViewController(animated: true)
	}
	
	@IBAction func cancelledButton(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
	}

}
