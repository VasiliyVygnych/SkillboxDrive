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
    private var viewModel: ViewModelLastFilesProtocol = LastFilesModel()
    
    private let servis: ServiseProtocol = Servise()
    private let cellServis: CellServiseProtocol = CellServise()
    private let netWork: NetWorkProtocol = NetWork()
    private let viewModelRouter: ViewModelLastFiles
    
    
    
// MARK: - init
init(viewModelRouter: ViewModelLastFiles) {
    self.viewModelRouter = viewModelRouter
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
        setupeTable()
        initialLoading()
        initialisation()
    }
    
    
    
    
    
// MARK: - initialisation
    private func initialisation() {
        netWork.downloadingAllFiles(completion: { dataFiles in
            DispatchQueue.main.async {
                self.loader.startAnimating()
                guard let model = dataFiles else { return }
                self.viewModel.dataCell.value = model
                self.tableView.reloadData()
            }
        })
    }
    
    
    
    
// MARK: - setupeTableView
    private func setupeTable() {
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 60
        tableView.register(Cells.self,
                           forCellReuseIdentifier: cellRecentFiles)
        tableView.dataSource = self
        tableView.delegate = self
    }
// MARK: - initialLoading
    private func initialLoading() {
        view.addSubview(loader)
        loader.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
// MARK: - override func tableView
    override func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowSection(section)
    }
    override func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellRecentFiles,
                                                       for: indexPath) as? Cells,
              let viewModel = viewModel.dataCell.value??.embedded.items[indexPath.row] else {
        return UITableViewCell()
        }
        loader.stopAnimating()
        view.willRemoveSubview(loader)
        cellServis.сonfiguresFiles(cells: cell,
                                         modelCell: viewModel)
        return cell
    }  
// MARK: - screen description
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel.dataCell.value??.embedded.items[indexPath.row] else { return }
        let descriptionVC = DescriptionLastFiles()
        descriptionVC.сonfiguresDescriptionView(modelCell: viewModel)
        descriptionVC.setupeButton(index: indexPath.row)
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(descriptionVC,
                                                 animated: true)
    }
}
