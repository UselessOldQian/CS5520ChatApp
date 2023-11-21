
import Foundation
import FirebaseFirestoreSwift

struct Message: Codable {
    @DocumentID var id: String?
    var text: String
    var date: Date
    var myself: Bool
}
