//
//  DeviceListViewController.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import UIKit


// MARK: - Screen

/// Device list a.k.a home screen of the app.
public final class DeviceListViewController: BaseViewController {
    
    
    /// The viewmodel.
    private let viewModel: DeviceListViewModel
    
    
    // MARK: Subviews
    
    /// Use this property instead of just `view`. Casts a view controller `view` to the needed class.
    private var deviceListView: DeviceListView! {
        return view as? DeviceListView
    }
    
    
    // MARK: Lifecycle
    
    /// Creates an instance of view controller and assignes a view-model to it.
    public init(viewModel: DeviceListViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = DeviceListView(frame: .zero)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        deviceListView.tableView.dataSource = self
        deviceListView.tableView.delegate = self
        setupBindings()
        viewModel.loadDeviceList()
    }
    
    
    // MARK: Helper
    
    /// Setups bindings to the view. Should be called once.
    private func setupBindings() {
        
        disposeBag.collect {
            
            viewModel
                .shouldReloadDeviceList
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: deviceListView.tableView.reloadData)
            
            viewModel
                .screenState
                .throttle(
                    for: 1.5,
                    scheduler: DispatchQueue.main,
                    latest: true
                )
                .receive(on: DispatchQueue.main)
                .sink { [unowned self] state in
                    switch state {
                    case .error(let error):
                        deviceListView.showLoadingErrorState(for: error)
                    case .loading:
                        deviceListView.showLoadingState()
                    case .deviceList:
                        deviceListView.showTableView()
                    }
                }
            
        }
        
    }
    
}


// MARK: UITableViewDataSource

extension DeviceListViewController: UITableViewDataSource {
    
    
    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.devices.count
    }
    
    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell: DeviceListTableViewCell = tableView.dequeue(for: indexPath)
        cell.assign(viewModel.devices[indexPath.row])
        return cell
    }
    
}


// MARK: UITableViewDelegate

extension DeviceListViewController: UITableViewDelegate {
    
    
    public func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let device: Device = viewModel.devices[indexPath.row]
        viewModel.openSettingsScreen(for: device)
    }
    
}
