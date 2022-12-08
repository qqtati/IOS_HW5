//
//  URLExtencion.swift
//  HW4
//
//  Created by qqtati on 08.12.2022.
//

import Foundation
extension URLSession {
    func getTopStories(completion: @escaping (Model.News) -> ()){
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=0dc3a9b3ba974e178b8efd89c64cf980") else{return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
               let news = try? JSONDecoder().decode(Model.News.self, from: data)
            {
                completion(news)
            }
            else{
                print("Could not get any content")
            }
            
        }
        
        task.resume()
    }
}
