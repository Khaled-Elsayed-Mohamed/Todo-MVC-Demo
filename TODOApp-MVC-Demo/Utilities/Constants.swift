//
//  Constants.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation


// Storyboards
struct Storyboards {
    static let authentication = "Authentication"
    static let main = "Main"
}

// View Controllers
struct ViewControllers {
    static let signUpVC = "SignUpVC"
    static let signInVC = "SignInVC"
    static let todoListVC = "TodoListVC"
    static let taskEntryVC = "TaskEntryVC"
    static let profileVC = "ProfileVC"
}

// Urls
struct URLs {
    
    static let base = "https://api-nodejs-todolist.herokuapp.com"
    static let user = base + "/user"
    static let login = user + "/login"
    static let register = user + "/register"
    static let task = base + "/task"
    static let getUser = user + "/me"
    static let logout = user + "/logout"
    
}

// Header Keys
struct HeaderKeys {
    static let contentType = "Content-Type"
    static let authorization = "Authorization"
}

// Parameters Keys
struct ParameterKeys {
    static let email = "email"
    static let password = "password"
    static let age = "age"
    static let name = "name"
}

// UserDefaultsKeys
struct UserDefaultsKeys {
    static let token = "UDKToken"
}

//cells
struct Cells {
    static let taskCell = "TaskCell"
}

// Alert messege
struct AlertMess {
    static let title = "Attention"
    static let invalidEmail = "Your email or password is invalid, please try again"
    static let inUseEmail = "Email already in use, please try another email"
    static let logoutFail = "Faild to logout, please try again"
    static let taskFail = "Couldn't add your task, Please try again"
}
