//
//  DescriptionLastFiles.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych  on 28.07.2023.
//

import UIKit
import SnapKit
import PDFKit

class DescriptionLastFiles: UIViewController {
// MARK: - properties
    private let viewModel: DescriptionViewProtocol = DescriptionViewModel()
    
    
    
    
    private let netWork: NetWorkProtocol = NetWork()
    private let cellServis: CellServiseProtocol = CellServise()
    
    
    
    
    private let loader = UIActivityIndicatorView()
    private let appearance = UINavigationBarAppearance()
    private let gestureRecognizer = UITapGestureRecognizer()
    private var cell = "cell"
    private var nameCell = "name"
    
    
    
    var pdfView = PDFView()
    var pdfDocument = PDFDocument()
    var totalPageCount = 0
    
    
    
    
    
    var model: [Item]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    
// MARK: - tableView
    private var tableView: UITableView = {
    let tableView = UITableView()
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
        viewModel.dataCell.bind { data in
            self.loader.startAnimating()
            self.model = data??.embedded.items
        }
        setupeTable()
        setupeView()
        setupeConstraints()
        
    }
    private func setupeView() {
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.standardAppearance = self.appearance
        settingButton.tintColor = .black
        backButton.tintColor = .black
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
// MARK: - сonfiguresDescriptionView
    func сonfiguresDescriptionView(modelCell: Item) {
        viewModel.сonfiguresDescriptionView(cell: self,
                                            modelCell: modelCell)
        
        viewModel.viewWillAppear(name: modelCell.path)
        
        guard let header = modelCell.name else { return }
        navigationItem.title = header
        nameCell = header
//        self.openPDFFiles()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
// MARK: - openPDFFiles
    func openPDFFiles() {
        pdfView = PDFView(frame: view.bounds)
//        pdfView.backgroundColor = .red
        view.addSubview(pdfView)
        guard let path = Bundle.main.url(forResource: nameCell,
                                         withExtension: "pdf") else { return }
        pdfDocument = PDFDocument(url: path)!
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        pdfView.displayMode = .singlePage
        pdfView.displayDirection = .vertical
        pdfView.usePageViewController(true)
        totalPageCount = 0
        if let total = pdfView.document?.pageCount {
            totalPageCount = total
        }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(countPages),
                                               name: NSNotification.Name.PDFViewPageChanged,
                                               object: nil)
        countPages()
    }
    @objc func countPages() {
        let currentPageNumber = pdfDocument.index(for: pdfView.currentPage!)+1
        let totalPages = "\(currentPageNumber)/\(totalPageCount)"
        title = "PDF Viewer \(totalPages)"
    }
    
    
    
    
    
    
    
    
    
    
// MARK: - setupeTableView
    private func setupeTable() {
        view.addSubview(tableView)
        tableView.backgroundColor = .red
        tableView.register(Cells.self,
                            forCellReuseIdentifier: cell)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
// MARK: - setupeButton
     func setupeButton(index: Int) {
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
        print("name: \(name)")
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
extension DescriptionLastFiles: UITableViewDelegate,
                    UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
//        viewModel.numberOfRowSection(section)
        model?.count ?? 0
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cell,
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = model?[indexPath.row] else { return }
        let decsriptionView = DescriptionFolder()
        decsriptionView.сonfiguresDescriptionFolder(modelCell: model)
        decsriptionView.setupeButton(index: indexPath.row)
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(decsriptionView,
                                                 animated: true)
    }
}
