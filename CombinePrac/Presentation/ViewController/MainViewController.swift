//
//  ViewController.swift
//  CombinePrac
//
//  Created by 송규섭 on 10/9/25.
//

import UIKit
import Combine

final class MainViewController: UIViewController {
    // MARK: - Properties
    private let mainView = MainView()
    private let viewModel: MainViewModel
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    private var profiles: [Profile] = []
    
    // MARK: - loadView
    override func loadView() {
        view = mainView
    }
    
    // MARK: - Initializer
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        viewDidLoadSubject.send()
    }
}

private extension MainViewController {
    func configure() {
        setDelegate()
        setBindings()
    }
    
    func setDelegate() {
        mainView.setTableView(dataSource: self, delegate: self)
    }
    
    func setBindings() {
        let input = MainViewModel.Input(viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher())
        let output = viewModel.transform(input: input)
        
        output.profiles.sink { [weak self] profiles in
            guard let self else { return }
            self.profiles = profiles
            self.mainView.reloadTableView()
        }
        .store(in: &cancellables)
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier) as? ProfileCell else {
            return UITableViewCell()
        }
        cell.update(with: profiles[indexPath.row])
        return cell
    }
}
