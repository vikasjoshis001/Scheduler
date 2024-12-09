//
//  NetworkManager.swift
//  Scheduler
//
//  Created by Vikas Joshi on 08/12/24.
//

import Foundation

enum NetworkManager {
    // Function to decode any Decodable model from a JSON file
    static func decodeData<T: Decodable>(from fileName: String, type: T.Type) -> Result<T, Error> {
        guard let url = Bundle.main.url(forResource: fileName,
                                        withExtension: "json")
        else {
            return .failure(NSError(domain: "JSONError", code: -1,
                                    userInfo: [NSLocalizedDescriptionKey: "Could not find the JSON file"]))
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return .success(decodedData)
        } catch {
            debugPrint(error.localizedDescription)
            return .failure(error)
        }
    }
}
