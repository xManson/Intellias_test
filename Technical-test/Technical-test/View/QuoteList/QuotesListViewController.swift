//
//  QuotesListViewController.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import UIKit


final class QuotesListViewController: BaseViewController {

    private let service: QuoteListService
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    init(service: QuoteListService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
        title = service.market.marketName
        performLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setup() {
        setupUI()
        setupAutolayout()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: QuoteListCell.reuseID, bundle: nil), forCellReuseIdentifier: QuoteListCell.reuseID)
    }

    func setupAutolayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0),
        ])
    }
    
}


//MARK: load data

extension QuotesListViewController {
    
    private func performLoad() {
        Task {
            do {
                hudShow()
                try await service.load()
                check()
                tableView.reloadData()
                hudDismiss()

            } catch {
                hudDismiss()
                if let tError = error as? TError {
                    show(error: tError)
                } else {
                    show(text: error.localizedDescription)
                }
            }
        }
   }
    
    private func check() {
        if service.market.quotes.isEmpty {
            show(text: "No data")
        }
    }
    
}


//MARK: table delegates

extension QuotesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        service.market.quotes.count
    }

    public func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        72
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: QuoteListCell.reuseID) as? QuoteListCell
        if cell == nil {
            cell = QuoteListCell.fromNib()
        }
        let model = service.market.quotes[indexPath.row]
        cell?.delegate = self
        cell?.setup(model: model)
        return cell ?? UITableViewCell()
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = service.market.quotes[indexPath.row]
        let detail = QuoteDetailsViewController(quote: model, service: service)
        navigationController?.pushViewController(detail, animated: true)
    }
    
    
}

//MARK: favourites managment

extension QuotesListViewController: QuoteListCellDelegate {
    
    func favouriteProcess(with model: Quote) {
        if let path = service.market.quotes.firstIndex(where: { $0.symbol == model.symbol }) {
            service.applyFavourites(symbol: model.symbol)
            tableView.reloadRows(at: [IndexPath(row: path, section: 0)], with: .fade)
        }
    }


}

