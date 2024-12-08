import Foundation

struct APIEndpoint {
    let url: URL
    let method: HTTPMethod
    let headers: [String: String]
    let body: Encodable?
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    init(url: URL, 
         method: HTTPMethod = .get,
         headers: [String: String] = [:],
         body: Encodable? = nil) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
    }
}