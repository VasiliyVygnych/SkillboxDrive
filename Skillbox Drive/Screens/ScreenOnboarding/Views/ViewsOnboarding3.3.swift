//
//  ViewsOnboarding3.3.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import UIKit

final class ViewsOnboarding3_3: UIViewController {
// MARK: - viewModel initialization
    private var viewModel: ViewModelOnboarding
// MARK: - init
    init(viewModel: ViewModelOnboarding) {
        self.viewModel = viewModel
        super.init(nibName: nil,
                    bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
// MARK: - Labels
    private var headerThreeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17) //заменить на шрифт из фигма
        label.textColor = .black
        label.text = "Делитесь вашими файлами с другими" .localized()
        return label
    }()
// MARK: - imageLogoApp
    private var imageGroups: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "Group11")
        return image
    }()
    private var imageTransition: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "On-3")
        return image
    }()
// MARK: - entranceButton
    private var nextScreenButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Далее".localized(),
                        for: .normal)
        button.setTitleColor(.white,
                             for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        return button
        }()
// MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(headerThreeLabel)
        view.addSubview(imageGroups)
        view.addSubview(imageTransition)
        view.addSubview(nextScreenButton)
        setupeConstraints()
        nextScreenButton.addTarget(self,
                            action: #selector(nextScreen),
                            for: .touchUpInside)
    }
// MARK: - mhetods
    @objc func nextScreen() {
        viewModel.openEntrance()
    }
// MARK: - setupeConstraints
    private func setupeConstraints() {
        headerThreeLabel.snp.makeConstraints { make in
            make.width.equalTo(240)
            make.height.equalTo(60)
            make.top.equalTo(439)
            make.centerX.equalToSuperview()
        }
        imageGroups.snp.makeConstraints { make in
            make.width.equalTo(149)
            make.height.equalTo(147)
            make.top.equalTo(228)
            make.centerX.equalToSuperview()
        }
        imageTransition.snp.makeConstraints { make in
            make.width.equalTo(45)
            make.height.equalTo(8.41)
            make.top.equalTo(620.12)
            make.centerX.equalToSuperview()
        }
        nextScreenButton.snp.makeConstraints { make in
            make.width.equalTo(320)
            make.height.equalTo(50)
            make.bottom.equalTo(-100)
            make.centerX.equalToSuperview()
        }
    }
}
