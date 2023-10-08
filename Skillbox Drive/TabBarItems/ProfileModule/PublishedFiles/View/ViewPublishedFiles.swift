//
//  ViewPublishedFiles.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 17.07.2023.
//

import UIKit
import SnapKit

final class ViewPublishedFiles: UITableViewController {
// MARK: - Properties
    private let cellPublishedFiles = "cellPublishedFiles"
    private let loader = UIActivityIndicatorView()
    private let cellServis: CellServiseProtocol = CellServise()
    private let viewModel: PublishedFiles
    
    
    private var nameCell = "name"
    

    var model: [Files]? {
        didSet {
            tableView.reloadData()
        }
    }

// MARK: - init
    init(viewModel: PublishedFiles) {
        self.viewModel = viewModel
        super.init(nibName: nil,
                   bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title  = "Последние файлы".localized()
        setupeTable()
        initialLoading()
        viewModel.dataCell.bind { data in
            self.loader.startAnimating()
            self.model = data??.items
        }
        setupeBarButtonItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewWillAppear()
    }
    private func setupeBarButtonItem() {
        let backButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                          style: .plain,
                                                          target: self,
                                                          action: #selector(back))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
// MARK: - mhetod back
    @objc func back() {
        viewModel.dismiss()
    }
// MARK: - setupeTable
    private func setupeTable() {
        tableView.backgroundColor = .white
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView()
        tableView.register(Cells.self,
                           forCellReuseIdentifier: cellPublishedFiles)
    }
// MARK: - initialLoading
    private func initialLoading() {
        view.addSubview(loader)
        loader.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.centerX.equalToSuperview()
        }
    }
    override func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        model?.count ?? 0
    }
    override  func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellPublishedFiles,
                                                       for: indexPath) as? Cells,
              let viewModel = model?[indexPath.row] else {
        return UITableViewCell()
        }
        let button = cellButton(index: indexPath.row)
        cell.addSubview(button)
        button.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
        }
        loader.stopAnimating()
        view.willRemoveSubview(loader)
        cellServis.сonfiguresPublishedFiles(cells: cell,
                                            modelCell: viewModel)
        return cell
    }
// MARK: - cellСlick убрать в модель
    @objc func cellСlick(_ sender: UIButton)  {
//        print("\(sender.tag) ячейка")
        let name = nameCell //имя файла
        let alert = cellServis.clickCell(sender: sender,
                                         name: name)
        navigationController?.present(alert,
                                      animated: true)
    }
//MARK: - cellButton
    func cellButton(index: Int) -> UIView {
        let cellButton: UIButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
        cellButton.translatesAutoresizingMaskIntoConstraints = false
        cellButton.addTarget(self,
                                action: #selector(cellСlick),
                                for: .touchUpInside)
        cellButton.setImage(UIImage(systemName: "ellipsis"),
                                for: .normal)
        cellButton.tintColor = .black
        cellButton.tag = index
        view.addSubview(cellButton)
        return cellButton
    }
}
