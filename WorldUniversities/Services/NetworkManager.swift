//
//  NetworkManager.swift
//  WorldUniversities
//
//  Created by Дима Монид on 6.03.25.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchData(from url: URL, completion: @escaping(Result<[University], AFError>) -> Void){
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    let universities = University.getUniversities(from: data)
                    completion(.success(universities))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    private init() {}
    }
