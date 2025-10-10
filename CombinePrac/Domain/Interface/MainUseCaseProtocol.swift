//
//  MainUseCaseProtocol.swift
//  CombinePrac
//
//  Created by 송규섭 on 10/9/25.
//

import Foundation
import Combine

protocol MainUseCaseProtocol: AnyObject {
    func fetchProfiles() -> AnyPublisher<[Profile], Error>
}
