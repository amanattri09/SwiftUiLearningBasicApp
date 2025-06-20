//
//  Validations.swift
//  FirebaseSwiftUIExample
//
//  Created by Aman Attri on 18/03/25.
//

import Foundation

struct EmailValidator {
    func isValidEmail(_ email : String) -> Bool{
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if predicate.evaluate(with: email) {
            return true
        } else {
            return false
        }
    }

}

func validateEmail(_ email : String) -> Bool{
    let validator = EmailValidator()
    return validator.isValidEmail(email)
}
