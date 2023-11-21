
import Foundation
import FirebaseFirestoreSwift

struct Chat: Codable {
    @DocumentID var id: String?
    var name: String
    var lastText: String
    var date: Date
}
