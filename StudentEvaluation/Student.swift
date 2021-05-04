//
//  Student.swift
//  StudentEvaluation
//
//  Created by Fenix Lavon on 5/4/21.
//  Copyright © 2021 Fenix Lavon. All rights reserved.
//

import UIKit

struct Student {
	var firstName: String
	var secondName: String
	var evalution: UInt8
}

extension Student {
	static var testData = [
		Student(firstName: "Artur", secondName: "Lutfullin", evalution: 3),
		Student(firstName: "Regina", secondName: "Nurgalieva", evalution: 4),
		Student(firstName: "Danila", secondName: "Kozlov", evalution: 4),
		Student(firstName: "Sergey", secondName: "Abramov", evalution: 5),
		Student(firstName: "Ruslan", secondName: "Enikeev", evalution: 3),
		Student(firstName: "Alexandr", secondName: "Vasnetcov", evalution: 5),
		Student(firstName: "Nikita", secondName: "Kabachkov", evalution: 2)
	]
}
