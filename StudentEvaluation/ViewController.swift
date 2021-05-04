//
//  ViewController.swift
//  StudentEvaluation
//
//  Created by Fenix Lavon on 5/4/21.
//  Copyright © 2021 Fenix Lavon. All rights reserved.
//

import UIKit

protocol StudentViewControllerDelegate: class {
	func configure(with student: Student, index indexPath: IndexPath)
}

class StudentViewController: UITableViewController, StudentViewControllerDelegate {
	
	let editStudentSegue = "EditStudentSegue"
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == editStudentSegue,
		   let destination = segue.destination as? StudentEditViewController,
		   let cell = sender as? StudentInfoListCell,
		   let indexPath = tableView.indexPath(for: cell) {
			let student = Student.testData[indexPath.row]
			destination.firstName = student.firstName
			destination.secondName = student.secondName
			destination.averageEval = String(student.evalution)
			destination.indexPath = indexPath
			destination.delegate = self
		}
	}
	
	enum StudentRow: Int, CaseIterable {
		case fullname
		case evaluation
	
		func outputText(for students: Student) -> String? {
				switch self {
				case .fullname: return (students.firstName + " " + students.secondName)
				case .evaluation:
					return String(students.evalution)
			}
		}
	}
	
	var student: Student?
	let studentCellId = "Student"
	
	func configure(with student: Student, index indexPath: IndexPath) {
		Student.testData[indexPath.row] = student
		tableView.reloadRows(at: [indexPath], with: .none)
		print(student)
	}
}

extension StudentViewController {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return Student.testData.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: studentCellId, for: indexPath) as? StudentInfoListCell else {
			fatalError("Error\n Create in cell failed")
		}
		let student = Student.testData[indexPath.row]
		cell.fullName.text = student.firstName + " " + student.secondName
		cell.averageEvaluation.text = String(student.evalution)
		return cell
	}
}

