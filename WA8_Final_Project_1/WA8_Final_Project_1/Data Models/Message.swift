//
//  Message.swift
//  WA8_Final_Project_1
//
//  Created by Tiffany Zhang on 11/15/23.
//

//import Foundation
//
//import FirebaseFirestoreSwift
//
//struct Message: Codable{
//    @DocumentID var id: String?
//    var message: String
//    var myself: Bool
//    var time: Date
//
//    init(message: String, myself: Bool, time: Date) {
//        self.message = message
//        self.myself = myself
//        self.time = time
//    }
//}


import Foundation
import FirebaseFirestoreSwift

struct Message: Codable {
    @DocumentID var id: String?
    var text: String
    var sender: String
    var time: String
    var utc: Date
}
