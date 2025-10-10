//
//  MainService.swift
//  CombinePrac
//
//  Created by 송규섭 on 10/9/25.
//

import Foundation
import Combine

protocol MainServiceProtocol: AnyObject {
    func fetchProfiles() -> AnyPublisher<[ProfileResponseDTO], Error>
}

final class MainService: MainServiceProtocol {
    /// 기존 URLSession의 dataTask 메서드를 활용해 데이터 파싱 후 이를 Future에 활용 후 AnyPublisher로 변환하는 방식
//    func fetchProfiles() -> AnyPublisher<[ProfileResponseDTO], Error> {
//        return Future<[ProfileResponseDTO], Error> { promise in
//            let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
//            let task = URLSession.shared.dataTask(with: url) { data, response, error in
//                if let error {
//                    print("error: \(error)")
//                    return
//                }
//                
//                guard let httpResponse = response as? HTTPURLResponse,
//                      httpResponse.statusCode == 200 else {
//                    print("invalid response")
//                    return
//                }
//                
//                if let data {
//                    do {
//                        let decoder = JSONDecoder()
//                        let result = try decoder.decode([ProfileResponseDTO].self, from: data)
//                        
//                    }
//                    catch {
//                        print("decode error:", error)
//                    }
//                }
//            }
//            task.resume()
//        }
//        .eraseToAnyPublisher()
//    }
//
    /// URLSession 내 dataTaskPublisher를 활용한 Combine 친화적 방법
    func fetchProfiles() -> AnyPublisher<[ProfileResponseDTO], any Error> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { element in
                guard let response = element.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: [ProfileResponseDTO].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
