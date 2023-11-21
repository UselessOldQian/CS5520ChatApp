//  Note.swift
//  App11
//
//  Created by GG Q on 2023/11/5.
//

import Foundation
import FirebaseFirestoreSwift

 struct Chat: Codable {
     @DocumentID var id: String?
     var friends: [String]
     var friendName: String?
     var lastMessageID: String?
     var messages: [Message]?
 }
 
