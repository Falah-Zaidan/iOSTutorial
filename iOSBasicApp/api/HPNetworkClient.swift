import Foundation

class HPNetworkClient : HPService {
    
    func getCharacters(completion: @escaping ([Character]?, Error?) -> Void) {
    
        let url = URL(string: "https://hp-api.onrender.com/api/characters")!
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in //requesting response as JSON
            if let data = data {
                if let characters = try? JSONDecoder().decode([Character].self, from: data) { //successful response, decode using a JSONDecoder and specify the type ()
                    DispatchQueue.main.async { // switch back to the main thread (to publish changes to the UI)
                        completion(characters, nil)
                    }
                } else {
                    //error handling
                    guard let response = response as? HTTPURLResponse else {
                        return
                    }
                    DispatchQueue.main.async {
                        let error = Error(errorCode: response.statusCode, errorDescription: response.description)
                        completion(nil, error)
                    }
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }

        task.resume()
    }
    
    func getSpells(completion: @escaping ([Spell]?, Error?) -> Void) {
        
        let url = URL(string: "https://hp-api.onrender.com/api/spells")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let spells = try? JSONDecoder().decode([Spell].self, from: data) {
                    DispatchQueue.main.async {
                        completion(spells, nil)
                    }
                } else {
                    guard let response = response as? HTTPURLResponse else {
                        return
                    }
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
}
