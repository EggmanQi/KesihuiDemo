//
//  APIService.swift
//  KesihuiDemo
//
//  Created by P on 2024/2/3.
//

import Combine
import Foundation

class APIService {
    func fetchAppStoreData(term: String = "歌", limit: Int = 200, country: String = "HK") -> AnyPublisher<[MediaModel], Error> {
        let apiUrl = "https://itunes.apple.com/search?term=\(term)&limit=\(limit)&country=\(country)"
        guard let url = URL(string: apiUrl) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: AppModel.self, decoder: JSONDecoder())
            .map(\.results)
            .eraseToAnyPublisher()
    }
}

