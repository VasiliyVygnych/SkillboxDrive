//
//  ViewControllerAllFiles.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import UIKit
import WebKit
import SnapKit
import SDWebImage

final class ViewControllerAllFiles: UITableViewController {
// MARK: - Properties
    private var cellAllFiles = "cellAllFiles"
    private let loader = UIActivityIndicatorView()
    private let viewModel: ViewModelAllFiles
    
    
    private let cellServis: CellServiseProtocol = CellServise()
    private var servis: ServiseProtocol = Servise()
    
    
    
    var model: [Item]? {
        didSet {
            tableView.reloadData()
        }
    }
// MARK: - init
    init(viewModel: ViewModelAllFiles) {
        self.viewModel = viewModel
        super.init(nibName: nil,
                   bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
        viewModel.dataCell.bind { data in
            self.model = data??.embedded.items
        }
        setupeTable()
        initialLoading()
        setupeButton()
        viewModel.viewWillAppear()
    }
// MARK: - setupeButton
    private func setupeButton() {
        settingButton = UIBarButtonItem(image: UIImage(systemName: "plus.rectangle.on.folder"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(addingFolder))
        settingButton.tintColor = .black
        navigationItem.rightBarButtonItem = settingButton
    }
// MARK: - downloadingAllFiles
    @objc func addingFolder(sender: UIButton) {
        let alert = servis.addingFolder(sender: sender)
        navigationController?.present(alert,
                                      animated: true)
//        tableView.reloadData()
    }
// MARK: - setupeTable
    private func setupeTable() {
        tableView.backgroundColor = .white
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView()
        tableView.register(Cells.self,
                           forCellReuseIdentifier: cellAllFiles)
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
        model?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellAllFiles,
                                                       for: indexPath) as? Cells,
              let viewModel = model?[indexPath.row] else {
        return UITableViewCell()
        }
        loader.stopAnimating()
        cellServis.сonfiguresFiles(cells: cell,
                                      modelCell: viewModel)
        
        
//        cell.headerLabel.text = viewModel.name
//        guard let url = URL(string: viewModel.preview ?? "") else { return cell }
//            cell.imagePreview.sd_setImage(with: url,
//                                     placeholderImage: UIImage(named: "Group"))
        
    
        
        return cell
    }
    
    
// MARK: - screen description
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = model?[indexPath.row] else { return }
        let descriptionVC = DescriptionLastFiles()
        descriptionVC.сonfiguresDescriptionView(modelCell: viewModel)
        descriptionVC.setupeButton(index: indexPath.row)
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(descriptionVC,
                                                 animated: true)
    }
}


