//
//  ViewControllerLastFiles.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

//добавить обновлени если тянукть страницу вниз
//добавить детальный просмотр файлов


import UIKit

final class ViewControllerLastFiles: UITableViewController {
// MARK: - Properties
    private var cellRecentFiles = "cellRecentFiles"
    private let loader = UIActivityIndicatorView()
    private let viewModel: ViewModelLastFiles
    
    
    
    private let cellServis: CellServiseProtocol = CellServise()
    
    
    var model: [Item]? {
        didSet {
            tableView.reloadData()
        }
    }
    
// MARK: - init
init(viewModel: ViewModelLastFiles) {
    self.viewModel = viewModel
        super.init(nibName: nil,
                    bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title  = "Последние файлы".localized()
        viewModel.dataCell.bind { data in
            self.loader.startAnimating()
            self.model = data??.embedded.items
        }
        setupeTable()
        initialLoading()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewWillAppear()
    }
// MARK: - setupeTableView
    private func setupeTable() {
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 60
        tableView.register(Cells.self,
                           forCellReuseIdentifier: cellRecentFiles)
    }
// MARK: - initialLoading
    private func initialLoading() {
        view.addSubview(loader)
        loader.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.centerX.equalToSuperview()
        }
    }
// MARK: - override func tableView
    override func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        model?.count ?? 0
    }
    override func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellRecentFiles,
                                                       for: indexPath) as? Cells,
              let viewModel = model?[indexPath.row] else {
        return UITableViewCell()
        }
        loader.stopAnimating()
        view.willRemoveSubview(loader)
        cellServis.сonfiguresFiles(cells: cell,
                                         modelCell: viewModel)
        return cell
    }
    
    
    
    
    
// MARK: - screen description
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = model?[indexPath.row] else { return }
        let descriptionVC = DescriptionLastFiles()
        descriptionVC.сonfiguresDescriptionView(modelCell: viewModel)
        descriptionVC.setupeButton(index: indexPath.row)
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(descriptionVC,
                                                 animated: true)
    }
}
