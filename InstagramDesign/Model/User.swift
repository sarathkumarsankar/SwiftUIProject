
struct Users: Codable, Hashable {
    let id: String
    var author: String
    let width: Int
    let height: Int
    var url: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case width
        case height
        case url
        case imageUrl = "download_url"
    }
}
