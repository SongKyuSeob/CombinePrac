//
//  DIContainer.swift
//  CombinePrac
//
//  Created by 송규섭 on 10/10/25.
//

import Foundation

final class DIContainer {
    
    private let mainService = MainService()
    private lazy var mainRepository = MainRepository(service: mainService)
    private lazy var mainUseCase = MainUseCase(repository: mainRepository)
    
    func makeMainVC() -> MainViewController {
        let viewModel = MainViewModel(useCase: mainUseCase)
        return MainViewController(viewModel: viewModel)
    }
}
