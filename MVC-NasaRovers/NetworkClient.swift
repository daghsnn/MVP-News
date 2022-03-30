//
//  NetworkClient.swift
//  MVC-NasaRovers
//
//  Created by Hasan Dag on 26.03.2022.
//

import Foundation
import Combine

final class NetworkClient {
    private var query = "q="
    static var shared = NetworkClient()
    private let baseUrl = "https://newsapi.org/v2/"
//    private let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as! String
    private var session : URLSession = URLSession.shared
    private let apiKey = "d1a3f433ab1b4545ab137c9f4a3336d3"
    private init(){}
   
    func getNewswithAllEndPoints(_ sorting:SortingType = SortingType.popular,  page:Int? = 1, keyword:String? = "default", completion: @escaping (NewsModel)->()) {
        let url = URL(string: baseUrl + EndPoints.everything.rawValue + "q=\(keyword ?? "default")&page=\(String(page ?? 1))" + sorting.rawValue + "&apiKey=d1a3f433ab1b4545ab137c9f4a3336d3")
        
        print(url, "url nedir")
        guard let urlString = url else {return}
        URLSession.shared.dataTask(with: urlString) { [weak self] (data, _, error) in
            if error != nil {
                completion(NewsModel(status: error?.localizedDescription, totalResults: 0, articles: []))
            }
            else{
                do {
                    let news = try JSONDecoder().decode(NewsModel.self, from: data!)
                    DispatchQueue.main.async {
                        completion(news)
                    }
                } catch  {
                    
                }
            }
            
        }.resume()
    }

}

