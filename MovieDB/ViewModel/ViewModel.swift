//
//  Model.swift
//  MovieDB
//
//  Created by Joe Leung on 7/13/21.
//

import Foundation
import UIKit

class ViewModel {

    public var modelData = [(String?, String?, String?, Double?)]()

    private var rawModelData: QueryResult?
    private let urlString: String
    private let view: UITableView
    
    init(withURL urlString: String, withView view: UITableView) {
        self.urlString = urlString
        self.view = view
        self.runQuery()
    }
    
    private func runQuery() {
        DispatchQueue.global().async {
            self.loadJson() { result in
                switch result {
                 case .success(let data):
                     self.parse(jsonData: data)
                 case .failure(let error):
                     print(error)
                 }
            }
        }
    }
    
    private func parse(jsonData: Data) {
        do {
            self.rawModelData = try JSONDecoder().decode(QueryResult.self,
                                                       from: jsonData)
            self.modelData = rawModelData!.results.map {
                ($0.title! + " (" + $0.releaseDate!.split(separator: "-")[0] + ")", $0.title, $0.posterPath, $0.popularity)
            }
        } catch {
            print("Decode error")
        }
        DispatchQueue.main.async {
            self.view.reloadData()
        }
    }
    
    private func loadJson(completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: self.urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                if let data = data {
                    completion(.success(data))
                }
            }
            urlSession.resume()
        }
    }
}
