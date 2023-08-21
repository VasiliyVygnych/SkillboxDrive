//
//  ViewControllerAllFiles.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import UIKit
import WebKit
import SnapKit

final class ViewControllerAllFiles: UIViewController {
// MARK: - Properties
    private var cellAllFiles = "cellAllFiles"
    private let loader = UIActivityIndicatorView()
    private var viewModel: ViewModelAllFilesProtocol = AllFilesModel()
    private let cellServis: CellServiseProtocol = CellServise()
    private var servis: ServiseProtocol = Servise()
    private let netWork: NetWorkProtocol = NetWork()
    private let viewModelRouter: ViewModelAllFiles
// MARK: - init
    init(viewModelRouter: ViewModelAllFiles) {
        self.viewModelRouter = viewModelRouter
        super.init(nibName: nil,
                   bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// MARK: - tableView
    private var tableView: UITableView = {
    let tableView = UITableView(frame: .zero,
                                style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 80
    return tableView
    }()
// MARK: - button
    private var settingButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        return button
    }()
// MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title  = "Все файлы".localized()
        setupeTable()
        initialLoading()
        downloadingAllFiles()
        settingButton = UIBarButtonItem(image: UIImage(systemName: "plus.rectangle.on.folder"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(addingFolder))
        settingButton.tintColor = .black
        navigationItem.rightBarButtonItem = settingButton
        viewModel.updateView = { [ weak self ] in
            self?.tableView.reloadData()
        }
    }
// MARK: - downloadingAllFiles
    @objc func addingFolder(sender: UIButton) {
        let alert = servis.addingFolder(sender: sender)
        navigationController?.present(alert,
                                      animated: true)
    }
// MARK: - downloadingAllFiles
    private func downloadingAllFiles() {
        netWork.downloadingAllFiles(completion: { dataFiles in
            DispatchQueue.main.async {
                self.loader.startAnimating()
                guard let model = dataFiles else { return }
                self.viewModel.dataCell.value = model
                self.tableView.reloadData()
            }
        })
    }
// MARK: - setupeTable
    private func setupeTable() {
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.register(Cells.self,
                           forCellReuseIdentifier: cellAllFiles)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
// MARK: - initialLoading
    private func initialLoading() {
        view.addSubview(loader)
        loader.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
// MARK: - extension TableView
extension ViewControllerAllFiles: UITableViewDelegate,
                    UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowSection(section)
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellAllFiles,
                                                       for: indexPath) as? Cells,
              let viewModel = viewModel.dataCell.value??.embedded.items[indexPath.row] else {
        return UITableViewCell()
        }
        loader.stopAnimating()
        cellServis.сonfiguresFiles(cells: cell,
                                      modelCell: viewModel)
        return cell
    }
// MARK: - screen description
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel.dataCell.value??.embedded.items[indexPath.row] else { return }
        let descriptionVC = DescriptionLastFiles()
        descriptionVC.сonfiguresDescriptionView(modelCell: viewModel)
        descriptionVC.setupeButton(index: indexPath.row)
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(descriptionVC,
                                                 animated: true)
    }
}
