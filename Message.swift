//
//  Message.swift
//  FarceBookTheApp
//
//  Created by jwilson on 11/14/17.
//  Copyright © 2017 jwilson. All rights reserved.
//

import Foundation
struct Message: Codable {
    var user: String
    var text: String
    var date: Date
    var imgURL: String?
    var id: String
    var replyTo: String?
    var likedBy: [String]
}
