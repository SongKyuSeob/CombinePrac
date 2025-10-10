//
//  ViewModel.swift
//  CombinePrac
//
//  Created by 송규섭 on 10/9/25.
//

import Foundation
import Combine

protocol ViewModelProtocol: AnyObject {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}

final class MainViewModel: ViewModelProtocol {
    // MARK: - Properties
    private let mainUseCase: MainUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    private let profiles = CurrentValueSubject<[Profile], Never>([])
    
    // MARK: - Initializer
    init(useCase: MainUseCaseProtocol) {
        self.mainUseCase = useCase
    }
    
    // MARK: - Input, Output
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let profiles: AnyPublisher<[Profile], Never>
    }
    
    // MARK: - transform
    func transform(input: Input) -> Output {
        input.viewDidLoad.sink { [weak self] _ in
            guard let self else { return }
//            profiles.send([
//                Profile(id: 1, name: "이이", username: "이이"),
//                Profile(id: 2, name: "아오", username: "아오"),
//                Profile(id: 1, name: "에오", username: "에오")
//            ])
            mainUseCase.fetchProfiles()
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("error: \(error)")
                    case .finished:
                        print("finished!")
                    }
                }, receiveValue: { [weak self] profiles in
                    guard let self else { return }
                    self.profiles.send(profiles)
                })
                .store(in: &cancellables)
        }
        .store(in: &cancellables)
        return Output(
            profiles: profiles.eraseToAnyPublisher()
        )
    }
}
