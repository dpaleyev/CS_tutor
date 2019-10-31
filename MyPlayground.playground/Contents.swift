import PlaygroundSupport
import Foundation
PlaygroundPage.current.needsIndefiniteExecution = true

struct Profile : Codable {
    var username: String
    var email: String
    var password: String
    var judge_id: String
  
    init() {
        self.username = ""
        self.email = ""
        self.password = ""
        self.judge_id = ""
    }
  
}

var p = Profile()
p.username = "dannypal"
p.email = "dannypal@gmail.com"
p.password = "ololololol"
p.judge_id = "207896"

let jsonData = try! JSONEncoder().encode(p)

let url = URL(string: "http://localhost:8000/register/")!
var request = URLRequest(url: url)
request.httpMethod = "POST"
request.setValue("application/json", forHTTPHeaderField: "Content-Type")

let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
    guard let response = response as? HTTPURLResponse,
        (200...299).contains(response.statusCode) else {
            print(":(")
        return
    }
}
task.resume()

LoginAPI(username: userManager.profile.username, password: userManager.profile.password) { (token) in
    if let token = token {
        print(token)
        //self.userManager.settings.token = token
    }
    else{
        self.wrongAlert = true
    }
}
