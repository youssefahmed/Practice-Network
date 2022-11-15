//
//  Repository.swift
//  Github Project
//
//  Created by youssef on 14/11/2022.
//

import Foundation

struct Repository: Codable {
    let name : String?
    let owner: Owner?
}
struct Owner : Codable {
    let avatar_url : String?
   
}
