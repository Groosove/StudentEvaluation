//
//  ViewController.swift
//  StudentEvaluation
//
//  Created by Fenix Lavon on 5/4/21.
//  Copyright © 2021 Fenix Lavon. All rights reserved.
//

import UIKit

class StudentViewController: UITableViewController {
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
	
	func configure(with student: Student) {
		self.student = student
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

