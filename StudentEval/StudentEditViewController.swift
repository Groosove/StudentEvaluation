//
//  StudentEditViewController.swift
//  StudentEvaluation
//
//  Created by Fenix Lavon on 5/4/21.
//  Copyright © 2021 Fenix Lavon. All rights reserved.
//

import UIKit
import CoreData
class StudentEditViewController: UIViewController {
	var indexPath: IndexPath?
	var firstName = ""
	var secondName = ""
	var averageEval = ""
	var newStudent = true
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
		if !checkLabel() || !newStudent { return }
		if indexPath == nil {
			guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
			  let managedContext = appDelegate.persistentContainer.viewContext
			  let entity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext)!
			  
			  let student = NSManagedObject(entity: entity,
										   insertInto: managedContext)
			  
			student.setValue(firstNameLabel.text!, forKey: "firstName")
			student.setValue(secondNameLabel.text!, forKey: "secondName")
			student.setValue(averageEvalLabel.text!, forKey: "averageEval")
			
			do {
				try managedContext.save()
				delegate?.student.append(student)
			  } catch let error as NSError {
				print("Could not save. \(error), \(error.userInfo)")
			  }
		}
		let student = delegate?.student[indexPath?.row ?? (delegate?.student.count)! - 1]
		student?.setValue(firstNameLabel.text!, forKey: "firstName")
		student?.setValue(secondNameLabel.text!, forKey: "secondName")
		student?.setValue(averageEvalLabel.text!, forKey: "averageEval")
		delegate?.configure(with: student!, index: indexPath)
		self.navigationController?.popViewController(animated: true)
	}
	
	@IBAction func cancelledButton(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
		newStudent = false
	}
	
	func checkLabel() -> Bool {
		let alertFirstName = UIAlertController(title: "Error", message: "Имя должно содеражать только Русские или Английские символы", preferredStyle: .alert)
		alertFirstName.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in NSLog("The \"OK\" alert occured.")}))
		let alertSecondeName = UIAlertController(title: "Error", message: "Фамилия должна содеражать только Русские или Английские символы", preferredStyle: .alert)
		alertSecondeName.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in NSLog("The \"OK\" alert occured.")}))
		let alertAverageEval = UIAlertController(title: "Error", message: "Оценка может быть только от 1...5", preferredStyle: .alert)
		alertAverageEval.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in NSLog("The \"OK\" alert occured.")}))
		
		guard firstNameLabel.text?.rangeOfCharacter(from: CharacterSet.controlCharacters) == nil &&
			firstNameLabel.text?.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines) == nil &&
			firstNameLabel.text?.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil &&
			firstNameLabel.text?.rangeOfCharacter(from: CharacterSet.letters) != nil else { self.present(alertFirstName, animated: true, completion: nil); return false }
		guard secondNameLabel.text?.rangeOfCharacter(from: CharacterSet.controlCharacters) == nil &&
			secondNameLabel.text?.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines) == nil &&
			secondNameLabel.text?.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil &&
			secondNameLabel.text?.rangeOfCharacter(from: CharacterSet.letters) != nil else { self.present(alertFirstName, animated: true, completion: nil); return false }
		
		guard let value = UInt8(averageEvalLabel.text!) else { self.present(alertAverageEval, animated: true, completion: nil); return false }
		
		if !(1...5).contains(value) { return false }
		return true
	}

}
