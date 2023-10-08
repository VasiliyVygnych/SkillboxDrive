//
//  ViewPublishedFiles.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 17.07.2023.
//

import UIKit
import SnapKit

final class ViewPublishedFilesNoFiles: UIViewController {
// MARK: - Properties
    private var loader = UIActivityIndicatorView()
    private var viewModel: ViewModelPublishedNoFilesProtocol = PublishedNoFilesModel()
    private var viewModelRouter: PublishedFilesNoFiles
    
    
    
    
// MARK: - label & image & button
    var imageGroup7: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Group7")
        image.contentMode = .scaleAspectFit
        return image
    }()
    var headerNofileLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = .systemFont(ofSize: 15,
                                       weight: .semibold)
        headerLabel.textColor = .black
        headerLabel.numberOfLines = 0
        headerLabel.textAlignment = .center
        headerLabel.text = "У вас пока нет опубликованных файлов".localized()
        return headerLabel
    }()
    var buttonNextScreen: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Обновить".localized(),
                        for: .normal)
        button.setTitleColor(.black,
                             for: .normal)
        button.tintColor = .blue
        button.titleLabel?.shadowColor = .red
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        return button
    }()
// MARK: - init
    init(viewModelRouter: PublishedFilesNoFiles) {
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
        initialView()
        setupeConstraints()
        initialLoading()
        setupeButton()
    }
// MARK: - setupeButton
    private func setupeButton() {
        let backButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                          style: .plain,
                                                          target: self,
                                                          action: #selector(back))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        buttonNextScreen.addTarget(self,
                                   action: #selector(nextScreen),
                                   for: .touchUpInside)
    }
// MARK: - mhetods dismiss
    @objc func back() {
        viewModelRouter.dismiss()
    }
// MARK: - initialView
    private func initialView() {
        view.backgroundColor = .white
        navigationItem.title = "Опубликованные файлы".localized()
        view.addSubview(headerNofileLabel)
        view.addSubview(imageGroup7)
        view.addSubview(buttonNextScreen)
        navigationController?.toolbar.isHidden = true
    }
// MARK: - nextScreen
    @objc func nextScreen() {
//        loader.startAnimating()
        if viewModel.dataCell.value == nil {
            // обновить request
//            loader.stopAnimating()
        } else {
            viewModelRouter.publishedFiles()
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
        headerNofileLabel.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.top.equalTo(500)
            make.centerX.equalToSuperview()
        }
        imageGroup7.snp.makeConstraints { make in
            make.width.equalTo(149)
            make.height.equalTo(147)
            make.top.equalTo(300)
            make.centerX.equalToSuperview()
        }
        buttonNextScreen.snp.makeConstraints { make in
            make.width.equalTo(350)
            make.height.equalTo(50)
            make.bottom.equalTo(-100)
            make.centerX.equalToSuperview()
        }
    }
}
