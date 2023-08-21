//
//  DescriptionFolder.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych  on 11.08.2023.
//

import UIKit
import SnapKit

class DescriptionFolder: UIViewController {
// MARK: - properties
    private var cell = "cell"
    private let loader = UIActivityIndicatorView()
    private let viewModel: VMForFolderDescriptionProtocol = VMForFolderDescription()
    private let netWork: NetWorkProtocol = NetWork()
    private let cellServis: CellServiseProtocol = CellServise()
    private let appearance = UINavigationBarAppearance()
    private let gestureRecognizer = UITapGestureRecognizer()
    private var nameCell = "name"
// MARK: - tableView
    private var tableViews: UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .grouped)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.rowHeight = 80
        return tableView
        }()
// MARK: - labels & image & Button
     var descriptionLabels: UILabel = {
       let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = .systemFont(ofSize: 15,
                                            weight: .light)
         label.textColor = .white
         label.numberOfLines = 0
         label.textAlignment = .center
        return label
    }()
     var imagePreview: UIImageView = {
        let image = UIImageView()
         image.translatesAutoresizingMaskIntoConstraints = false
         image.contentMode = .scaleAspectFit
        return image
    }()
    private var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "trash"),
                        for: .normal)
        button.setTitleColor(.white,
                             for: .normal)
        button.tintColor = .white
        return button
    }()
    private var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.and.arrow.up"),
                        for: .normal)
        button.setTitleColor(.white,
                             for: .normal)
        button.tintColor = .white
        return button
    }()
    private var settingButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        return button
    }()
    private var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        return button
    }()
// MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(descriptionLabels)
        view.addSubview(imagePreview)
        view.addSubview(deleteButton)
        view.addSubview(shareButton)
        viewModel.updateView = { [ weak self ] in
            self?.tableViews.reloadData()
        }
//        view.addGestureRecognizer(gestureRecognizer)
        setupeConstraints()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance = appearance
    }
// MARK: - сonfiguresDescriptionView
    func сonfiguresDescriptionFolder(modelCell: Item) {
        viewModel.сonfiguresDescriptionFolder(cell: self,
                                            modelCell: modelCell)
        guard let header = modelCell.name else { return }
        navigationItem.title = header
        nameCell = header
        netWork.showFolder(name: modelCell.path) { dataFiles in
            DispatchQueue.main.async {
                self.loader.startAnimating()
                self.appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
                self.navigationItem.standardAppearance = self.appearance
                self.settingButton.tintColor = .black
                self.backButton.tintColor = .black
                self.setupeTable()
                guard let model = dataFiles else { return }
                self.viewModel.dataCell.value = model
                self.setupeTable()
                self.tableViews.reloadData()
            }
        }
        loader.stopAnimating()
    }
// MARK: - setupeTableView
    private func setupeTable() {
        view.addSubview(tableViews)
        tableViews.backgroundColor = .white
        tableViews.register(Cells.self,
                            forCellReuseIdentifier: cell)
        tableViews.dataSource = self
        tableViews.delegate = self
        tableViews.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
// MARK: - setupeButton
     func setupeButton(index: Int){
        settingButton = UIBarButtonItem(image: UIImage(systemName: "pencil"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(renameFile))
        settingButton.tag = index
        settingButton.tintColor = .white
        navigationItem.rightBarButtonItem = settingButton
        backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                          style: .plain,
                                                          target: self,
                                                          action: #selector(back))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
        deleteButton.addTarget(self,
                                 action: #selector(removeFile),
                                 for: .touchUpInside)
        deleteButton.tag = index
        shareButton.addTarget(self,
                                 action: #selector(shareFile),
                                 for: .touchUpInside)
        shareButton.tag = index
        gestureRecognizer.addTarget(self,
                                    action: #selector(didTap))
    }
// MARK: - @objc back
    @objc func back() {
        tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
// MARK: - @objc renameFile
    @objc private func renameFile() {
        let name = nameCell
        let alert =  cellServis.renameFile(name: name)
        navigationController?.present(alert,
                                      animated: true)
    }
// MARK: - removeFile
    @objc func removeFile(sender: UIButton) {
        let name = nameCell
        let alert =  cellServis.removeFile(name: name)
        navigationController?.present(alert,
                                      animated: true)
    }
// MARK: - shareFile
    @objc func shareFile(sender: UIButton) {
//        let name = nameCell
        let alert =  cellServis.shareFile(sender: sender)
        navigationController?.present(alert,
                                      animated: true)
    }
// MARK: - didTap
    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: imagePreview.superview)
        if (imagePreview.layer.presentation()?.frame.contains(tapLocation))! {
            UIView.animate(withDuration: 0.5) {
//                self.imagePreview.alpha = 0
//                self.imagePreview.increaseSize(5)
//                self.imagePreview.scalesLargeContentImage = true
//                self.imagePreview.contentScaleFactor = 50
                print("tap in image")
            }
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
// MARK: - setupeConstraints
    private func setupeConstraints() {
        imagePreview.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        descriptionLabels.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(140)
        }
        deleteButton.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.bottom.equalTo(-50)
            make.right.equalTo(-30)
        }
        shareButton.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.bottom.equalTo(-50)
            make.left.equalTo(30)
        }
    }
}
// MARK: - extension TableView
extension DescriptionFolder: UITableViewDelegate,
                    UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowSection(section)
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cell,
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = viewModel.dataCell.value??.embedded.items[indexPath.row] else { return }
        let decsriptionView = DescriptionLastFiles()
        decsriptionView.сonfiguresDescriptionView(modelCell: model)
        decsriptionView.setupeButton(index: indexPath.row)
        tableView.reloadData()
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(decsriptionView,
                                                 animated: true)
    }
}
