//
//  UserSignUpForm.swift
//  Trainer
//
//  Created by Osvaldo Mosso on 1/27/26.
//


import Foundation

struct UserSignUpFormModel{
    //(required)
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var password: String = ""

    // Optional details
    var age: String = ""
    var sex: String = ""
    var height: String = ""
    var weight: String = ""
    var goal: String = ""
}
