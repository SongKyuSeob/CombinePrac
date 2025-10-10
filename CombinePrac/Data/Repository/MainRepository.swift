//
//  MainRepository.swift
//  CombinePrac
//
//  Created by 송규섭 on 10/9/25.
//

import Foundation
import Combine

final class MainRepository: MainRepositoryProtocol {
    private let mainService: MainServiceProtocol
    
    init(service: MainServiceProtocol) {
        self.mainService = service
    }
    
    func fetchProfiles() -> AnyPublisher<[Profile], Error> {
        mainService.fetchProfiles()
            .map { dtos in
                dtos.map { dto in
                    Profile(id: dto.id, name: dto.name, username: dto.username)
                }
            }
            .eraseToAnyPublisher()
    }
}
