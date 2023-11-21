//
//  User.swift
//  WA8_Final_Project_1
//
//  Created by (Vincent) GuoWei Li on 11/19/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable {
    @DocumentID var id: String?
    var name: String
}
