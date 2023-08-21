//
//  ViewPublishedFiles.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 17.07.2023.
//

import UIKit
import SnapKit

final class ViewPublishedFiles: UIViewController {
// MARK: - Properties
    private let cellPublishedFiles = "cellPublishedFiles"
    private let loader = UIActivityIndicatorView()
    private let viewModel: ViewModelPublishedFilesProtocol = PublishedFilesModel()
    private let cellServis: CellServiseProtocol = CellServise()
    private let netWork: NetWorkProtocol = NetWork()
    private let viewModelRouter: PublishedFiles
    private var nameCell = "name"
// MARK: - tableView
    private var tableView: UITableView = {
    let tableView = UITableView(frame: .zero,
                                style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 80
    return tableView
    }()
// MARK: - init
    init(viewModelRouter: PublishedFiles) {
        self.viewModelRouter = viewModelRouter
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
        showRecentFiles()
        let backButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                          style: .plain,
                                                          target: self,
                                                          action: #selector(back))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
// MARK: - mhetod back
    @objc func back() {
        viewModelRouter.dismiss()
    }
// MARK: - showRecentFiles
    private func showRecentFiles() {
        netWork.showPublishedFiles(completion: { dataFiles in
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
                           forCellReuseIdentifier: cellPublishedFiles)
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
extension ViewPublishedFiles: UITableViewDelegate,
                    UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowSection(section)
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellPublishedFiles,
                                                       for: indexPath) as? Cells,
              let viewModel = viewModel.dataCell.value??.items?[indexPath.row] else {
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
        let alert = cellServis.clickCell(sender: sender, name: name)
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
