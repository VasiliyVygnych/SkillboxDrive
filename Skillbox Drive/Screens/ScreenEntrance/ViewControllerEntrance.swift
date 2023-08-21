//
//  ViewControllerEntrance.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import UIKit
import SnapKit

class ViewControllerEntrance: UIViewController {
// MARK: - viewModel initialization
    private var viewModel: ViewModelEntrance
// MARK: - init
    init(viewModel: ViewModelEntrance) {
        self.viewModel = viewModel
        super.init(nibName: nil,
                   bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// MARK: - imageLogoApp
    private var imageLogoApp: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "AppLogo")
        return image
    }()
// MARK: - Button
    private var entranceButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Войти".localized(),
                        for: .normal)
        button.setTitleColor(.white,
                             for: .normal)
        button.tintColor = .blue
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        return button
    }()
// MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.reloadInputViews()
        view.backgroundColor = .white
        view.addSubview(imageLogoApp)
        view.addSubview(entranceButton)
        setupeConstraints()
        entranceButton.addTarget(self,
                                 action: #selector(nextScreen),
                                 for: .touchUpInside)
    }
// MARK: - mhetods
    @objc func nextScreen() {
        viewModel.openAuthorization()
    }
// MARK: - setupeConstraints
    private func setupeConstraints() {
        imageLogoApp.snp.makeConstraints { make in
            make.width.equalTo(195)
            make.height.equalTo(168)
            make.top.equalTo(271.05)
            make.centerX.equalToSuperview()
        }
        entranceButton.snp.makeConstraints { make in
            make.width.equalTo(320)
            make.height.equalTo(50)
            make.bottom.equalTo(-100)
            make.centerX.equalToSuperview()
        }
    }
}
