//
//  StudentEditViewController.swift
//  StudentEvaluation
//
//  Created by Fenix Lavon on 5/4/21.
//  Copyright © 2021 Fenix Lavon. All rights reserved.
//

import UIKit

class StudentEditViewController: UIViewController {
	let editStudentSegue = "EditStudentSegue"
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == editStudentSegue {
			let destination = segue.destination as? StudentInfoListCell
		}
	}
	

	@IBOutlet weak var firstNameLabel: UITextField!
	@IBOutlet weak var secondNameLabel: UITextField!
	@IBOutlet weak var averageEvalLabel: UITextField!
	
	@IBAction func saveButton(_ sender: Any) {
		print("\(firstNameLabel.text)")
		print("\(secondNameLabel.text)")
		print("\(averageEvalLabel.text)")
	}
	@IBAction func cancelledButton(_ sender: Any) {
		
	}
}
