//
//  CatalogViewController.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 07/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {
    
    let manager = CatalogManager()
    var items: [Item] = []
    let style = UITableView.Style.plain
    
    var spinner: UIActivityIndicatorView?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: style)
        
        tableView.backgroundColor = .systemBackground
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorColor = .systemGray3
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        spinner = UIActivityIndicatorView(style: .medium)
        spinner?.color = .label
        spinner?.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        tableView.tableFooterView = spinner
        
        return tableView
    }()

    var viewModel: ViewModelProtocol? {
        didSet {
            viewModel?.didSetViewModel()
        }
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
        setupView()
        tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaultsManager.isFirstTime() {
            loadDataFromAPI()
        } else {
            loadDataFromCache()
        }
        
        tableView.delegate = self
    }
    
    func loadDataFromCache(afterItem: Item? = nil) {
        tableView.tableFooterView?.isHidden = false
        self.startSpinner()
        
        do {
            let items = try RealmProvider.getItems(afterItem: afterItem)
            
            guard !items.isEmpty else {
                self.stopSpinner()
                
                // Try loading from API
                if let lastItem = afterItem {
                    loadDataFromAPI(maxID: lastItem.identifier)
                }
                
                return
            }
            
            let validItems = items.filter { !self.items.contains($0) }
            self.items.append(contentsOf: validItems)

            self.perform(#selector(self.reloadData), with: nil, afterDelay: 1)
        } catch {
            self.presentError(withTitle: "Oops! 😵", message: error.localizedDescription)
        }
    }
    
    func loadDataFromAPI(sinceID: String? = nil, maxID: String? = nil) {
        UserDefaultsManager.setFirstTime()
        
        tableView.tableFooterView?.isHidden = false
        self.startSpinner()
        
        manager.items(sinceID: sinceID, maxID: maxID) { (items, error) in
            if let error = error {
                self.presentError(withTitle: "Oops! 😵", message: error.localizedDescription)
            }

            guard !items.isEmpty else {
                self.stopSpinner()
                
                return
            }

            let validItems = items.filter { !self.items.contains($0) }
            try? RealmProvider.save(items: validItems)
            self.items.append(contentsOf: validItems)

            self.perform(#selector(self.reloadData), with: nil, afterDelay: 1)
        }
    }
    
    func startSpinner() {
        spinner?.startAnimating()
    }
    
    @objc func stopSpinner() {
        spinner?.stopAnimating()
    }
}

extension CatalogViewController: ViewCodable {
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }

    func setupConstraints() {
        tableView.bindFrameToSuperviewBounds()
    }

    func additionalSetup() {
        
    }
}

extension CatalogViewController: ViewModelDelegate {
    func registerCell(anyClass: AnyClass) {
        tableView.register(anyClass: anyClass)
    }

    @objc func reloadData() {
        self.stopSpinner()
        self.viewModel = ItemsViewModel(view: self, items: items)
        
        self.tableView.reloadData()
    }
}

extension CatalogViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSection ?? .zero
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfElements(in: section) ?? .zero
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cellIdentifier = viewModel?.cellIdentifier(at: indexPath),
            let cellData = viewModel?.element(at: indexPath),
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else {
                return UITableViewCell()
        }

        if let fillable = cell as? Fillable {
            fillable.fill(data: cellData)
        }

        return cell
    }
}

extension CatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let viewModel = viewModel,
            let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            
            if indexPath == lastVisibleIndexPath && indexPath.row == viewModel.numberOfElements(in: indexPath.section) - 1 {
                let lastItem = viewModel.element(at: indexPath) as? Item
                
                if UserDefaultsManager.isFirstTime() {
                    self.loadDataFromAPI(maxID: lastItem?.identifier)
                } else {
                    self.loadDataFromCache(afterItem: lastItem)
                }
            }
        }
    }
}
