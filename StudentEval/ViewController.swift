//
//  ViewController.swift
//  StudentEvaluation
//
//  Created by Fenix Lavon on 5/4/21.
//  Copyright © 2021 Fenix Lavon. All rights reserved.
//

import UIKit
import CoreData

protocol StudentControllerDelegate: class {
	func configure(with student: NSManagedObject, index indexPath: IndexPath?)
	var student: [NSManagedObject] { get set }
}

class StudentViewController: UITableViewController, StudentControllerDelegate {
	let editStudentSegue = "EditStudentSegue"
	let studentCellId = "Student"
	var student: [NSManagedObject] = []
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		let managedContext = CoreDataStack.managedObjectContext
		  let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Student")
		
		do {
			student = try managedContext.fetch(fetchRequest)
		  } catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
		  }
	}
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let destination = segue.destination as? StudentEditViewController else { return }
		if segue.identifier == editStudentSegue,
		   let cell = sender as? StudentInfoListCell,
		   let indexPath = tableView.indexPath(for: cell) {
			let student = self.student[indexPath.row]
			destination.firstName = student.value(forKey: "firstName") as! String
			destination.secondName = student.value(forKey: "secondName") as! String
			destination.averageEval = student.value(forKey: "averageEval") as! String
			destination.indexPath = indexPath
		}
		destination.delegate = self
	}
	func configure(with student: NSManagedObject, index indexPath: IndexPath? = nil) {
		if let index = indexPath {
			self.student[index.row] = student
			tableView.reloadRows(at: [index], with: .fade)
		} else {
			let indexPath = IndexPath(row: self.student.count - 1, section: 0)
			tableView.insertRows(at: [indexPath], with: .fade)
		}
	}
}

extension StudentViewController {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return student.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: studentCellId, for: indexPath) as? StudentInfoListCell else {
			fatalError("Error\n Create in cell failed")
		}
		let student = self.student[indexPath.row]
		cell.fullName.text = (student.value(forKey: "firstName") as? String)! + " " + (student.value(forKey: "secondName") as? String)!
		cell.averageEvaluation.text = (student.value(forKey: "averageEval") as? String)!
		return cell
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let managedContext = CoreDataStack.managedObjectContext
			do {
				managedContext.delete(student[indexPath.row])
				student.remove(at: indexPath.row)
				try managedContext.save()
			} catch let error as NSError { print("Could not save. \(error), \(error.userInfo)") }
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
}

