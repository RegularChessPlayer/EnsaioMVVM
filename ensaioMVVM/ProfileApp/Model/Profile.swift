import Foundation

struct Profile {
    let image: String
    let name: String
    let age: String // date and stored property to return string
    let address: String?
    let gender: String
    let occupation: String
    var isFollow: Bool
    
    init(image: String, name: String, age: String, address: String?, occupation: String, gender: String, isFollow: Bool) {
        self.image = image
        self.name = name
        self.age = age
        self.address = address
        self.occupation = occupation
        self.gender = gender
        self.isFollow = isFollow
    }
    
}
