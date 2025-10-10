//
//  MainUseCase.swift
//  CombinePrac
//
//  Created by 송규섭 on 10/9/25.
//

import Foundation
import Combine

final class MainUseCase: MainUseCaseProtocol {
    private let mainRepository: MainRepositoryProtocol
    
    init(repository: MainRepositoryProtocol) {
        self.mainRepository = repository
    }
    
    func fetchProfiles() -> AnyPublisher<[Profile], Error> {
        mainRepository.fetchProfiles()
    }
}
