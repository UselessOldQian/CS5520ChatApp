//  Note.swift
//  App11
//
//  Created by GG Q on 2023/11/5.
//

import Foundation
import FirebaseFirestoreSwift

//struct Chat: Codable{
//    let userId: String
//    let text: String
//    let _id:String
//
//    init(userId: String, text: String, _id: String) {
//        self.userId = userId
//        self.text = text
//        self._id = _id
//    }
//}

 struct Chat: Codable {
     @DocumentID var id: String?
     var friends: [String]
     var friendName: String
     var lastMessageID: String
 }
 
