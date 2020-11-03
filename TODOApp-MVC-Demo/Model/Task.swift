//
//  Task.swift
//  TODOApp-MVC-Demo
//
//  Created by Khaled L Said on 10/31/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

struct TaskResponse: Codable {
    let count: Int!
    let data: [TaskData]
    
}

struct TaskData: Codable {
    let id: String!
    let description: String!
    
    enum CodingKeys: String, CodingKey {
        case description
        case id = "_id"
    }

}
