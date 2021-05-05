//
//  ViewController.swift
//  StudentEvaluation
//
//  Created by Fenix Lavon on 5/4/21.
//  Copyright © 2021 Fenix Lavon. All rights reserved.
//

import UIKit

protocol StudentControllerDelegate: class {
    func configure(with student: Student, index indexPath: IndexPath?)
}

class StudentViewController: UITableViewController, StudentControllerDelegate {
	let editStudentSegue = "EditStudentSegue"
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let destination = segue.destination as? StudentEditViewController else { return }
		if segue.identifier == editStudentSegue,
		   let cell = sender as? StudentInfoListCell,
		   let indexPath = tableView.indexPath(for: cell) {
			let student = Student.testData[indexPath.row]
			destination.firstName = student.firstName
			destination.secondName = student.secondName
			destination.averageEval = String(student.evalution)
			destination.indexPath = indexPath
		}
		destination.delegate = self
	}
	
	
	var student: Student?
	let studentCellId = "Student"
	
	func configure(with student: Student, index indexPath: IndexPath? = nil) {
		if let index = indexPath {
			Student.testData[index.row] = student
			tableView.reloadRows(at: [index], with: .fade)
		} else {
			let indexPath = IndexPath(row: Student.testData.count - 1, section: 0)
			tableView.insertRows(at: [indexPath], with: .fade)
		}
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
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			Student.testData.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
}

