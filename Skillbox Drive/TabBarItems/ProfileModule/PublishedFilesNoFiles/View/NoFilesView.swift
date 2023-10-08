//
//  NoFilesView.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 08.10.2023.
//

import UIKit
import SnapKit

class NoFilesView: UIView {
    
    private var viewModel: ViewModelPublishedNoFilesProtocol = PublishedNoFilesModel()
    private var viewModelRouter: PublishedFilesNoFiles?
    
   private var imageGroup7: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Group7")
        image.contentMode = .scaleAspectFit
        return image
    }()
    private var headerNofileLabel: UILabel = {
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
    private var reloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Обновить".localized(),
                        for: .normal)
        button.setTitleColor(.black,
                             for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        return button
    }()
    private var backButtom: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black,
                             for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
       return button
    }()

    init() {
        super.init(frame: .zero)
        initialization()
        setupeConstraint()
        setupeButton()
        self.backgroundColor = .white
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NoFilesView {
    func initialization() {
        self.addSubview(headerNofileLabel)
        self.addSubview(imageGroup7)
        self.addSubview(reloadButton)
        self.addSubview(backButtom)
    }
    func setupeButton() {
        reloadButton.addTarget(self,
                               action: #selector(reloadView),
                               for: .touchUpInside)
        backButtom.setBackgroundImage(UIImage(systemName: "chevron.backward"),
                                      for: .normal)
    }
    @objc func back() {
        print("back")
        viewModelRouter?.dismiss()
    }
    @objc func reloadView() {
        print("reloadView")
    }
    func setupeConstraint() {
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
        reloadButton.snp.makeConstraints { make in
            make.width.equalTo(350)
            make.height.equalTo(50)
            make.bottom.equalTo(-100)
            make.centerX.equalToSuperview()
        }
        backButtom.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.height.width.equalTo(50)
            make.left.equalTo(20)
        }
    }
}

