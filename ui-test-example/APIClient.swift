import Foundation
import BrightFutures

class APIClient {

    func fetchContent() -> Future<String, NSError> {
        let promise = Promise<String, NSError>()
        let url = APIClient.APIURL.appendingPathComponent("foo")!
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let body = String(data: data, encoding: String.Encoding.utf8)!
                promise.success(body)
            } else {
                promise.failure(error as! NSError)
            }
        }.resume()

        return promise.future
    }

    private static var APIURL: NSURL {
        let defaultURLString = "https://real-api.example.com"
        return NSURL(string: ProcessInfo.processInfo.environment["API_URL"] ?? defaultURLString)!
    }

}
