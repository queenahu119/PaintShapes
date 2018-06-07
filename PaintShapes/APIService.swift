//
//  APIService.swift
//  PaintShapes
//
//  Created by QueenaHuang on 7/6/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import Foundation
import UIKit

class APIService: NSObject {
    let colorsURL = "http://www.colourlovers.com/api/colors/random?format=json"

    func getRandomColor(completion: @escaping (_ color: UIColor?) -> Void) {
        var components = URLComponents(string: colorsURL)!
        components.queryItems = [
            URLQueryItem(name: "format", value: "json")
        ]

        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = URLRequest(url: components.url!)

        let task = URLSession.shared.dataTask(with: request) { (data, response , error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let rootData = try decoder.decode([ColorData?].self, from: data)

                    if let data = rootData.first {
                        if let hexString = data?.hex {
                            let color = UIColor(hex: hexString)
                            completion(color)
                        }
                    }
                } catch let error as NSError {
                    print("Json failed. \(error)")
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
