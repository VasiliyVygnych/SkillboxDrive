//
//  ViewControllerProfile.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.

import UIKit
import Charts
import SnapKit

final class ViewControllerProfile: UIViewController, ChartViewDelegate {
// MARK: - Properties
    private var loader = UIActivityIndicatorView()
    let viewModel: ViewModelProfilInputProtocol
    let servis: ServiseProtocol = Servise()
    
    var model: ProfileFiles? {
        didSet {
            loader.stopAnimating()
        }
    }
       

// MARK: - label & PieChartView & button
    var pieView: PieChartView = {
       let pieView = PieChartView()
        pieView.translatesAutoresizingMaskIntoConstraints = false
        pieView.chartDescription.enabled = false
        pieView.drawEntryLabelsEnabled = false
        pieView.holeRadiusPercent = 0.6
        pieView.isUserInteractionEnabled = false
        return pieView
    }()
    private var headerProfileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15,
                                       weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
//        label.text = "10 gb"
        return label
    }()
    private var buttonNextScreen: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Опубликованные файлы".localized(),
                        for: .normal)
        button.setTitleColor(.black,
                             for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 6
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        return button
    }()
// MARK: - init
    init(viewModel: ViewModelProfile) {
        self.viewModel = viewModel
        super.init(nibName: nil,
                   bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.dataCell.bind { data in
            self.loader.startAnimating()
            self.model = data
        }
        initialView()
        initialLoading()
        setupeButton()
        setupeConstraints()
        setupePieView()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewWillAppear()
    }
// MARK: - setupeButton
    private func setupeButton() {
        let exitButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"),
                                                          style: .plain,
                                                          target: self,
                                                          action: #selector(exit))
        exitButton.tintColor = .black
        navigationItem.rightBarButtonItem = exitButton
        buttonNextScreen.addTarget(self,
                            action: #selector(nextScreen),
                            for: .touchUpInside)
    }
// MARK: - exitProfile
    @objc func exit(sender: UIButton) {
        self.exitProfile(sender: sender)
//        test()
    }
    

// MARK: - test
    private func test() {
//        guard let model = viewModel.dataCell.value else { return }
//
//        let totalGB = (model.totalSpace/1073741824) //общий объем - диска для лейбла
//        print("общий объем диска: \(totalGB) ГБ")
//
//        let used: Double = Double(model.usedSpace/1048576) // размер файлов пользователя - для лейбла пи
//        print("размер файлов пользователя: \(used) МБ")
//
//        let totalGb: Double = Double(model.totalSpace/1073741824)
//        let usedMb: Double = Double(model.usedSpace/1048576)
//        let usedGB: Double = Double(usedMb*0.0010) //занято - для шкалы
//        print("размер файлов пользователя: \(usedGB) ГБ")
//        let resultGb = (totalGb-usedGB) //свободно - для шкалы и для лейбла пи
//        print("остаток на диске: \(resultGb) ГБ") //0.029
//
//        headerProfileLabel.text = "\(resultGb) ГБ"
    }
// MARK: - initialView
    private func initialView() {
        view.backgroundColor = .white
        navigationItem.title = "Профиль".localized()
        view.addSubview(headerProfileLabel)
        view.addSubview(buttonNextScreen)
        view.addSubview(pieView)
        pieView.delegate = self
    }
// MARK: - nextScreen
    @objc func nextScreen() {
//        loader.startAnimating()
        if viewModel.dataCell.value == nil {
            viewModel.publishedFiles()
//            loader.stopAnimating()
        } else {
            viewModel.noPublishedFiles()
        }
    }
// MARK: - initialLoading
    private func initialLoading() {
        view.addSubview(loader)
        loader.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.centerX.equalToSuperview()
        }
    }
// MARK: - setupePieView
    func setupePieView() {
        
        var entries = [PieChartDataEntry]()
                
        entries.append(PieChartDataEntry(value: viewModel.occupiedSpace,
                                         label: "\(viewModel.usedSpace) МБ Занято"))
        entries.append(PieChartDataEntry(value: viewModel.freeSpace,
                                         label: "\(viewModel.totalSpace) GB Свободно"))
        let set = PieChartDataSet(entries: entries)
        guard let colorOccupied = UIColor(named: "LightPink") else { return }
        guard let colorFreely = UIColor(named: "LightGray") else { return }
        let entriesOccupied = colorOccupied
        let entriesFreely = colorFreely
        set.colors = [entriesOccupied,
                      entriesFreely]
        set.drawValuesEnabled = false
        set.valueTextColor = UIColor(ciColor: .black)
        set.valueLineVariableLength = false
        let data = PieChartData(dataSet: set)
        pieView.data = data
    }
// MARK: - setupeConstraints
    private func setupeConstraints() {
        pieView.snp.makeConstraints { make in
            make.height.equalTo(300)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.top.equalTo(150)
        }
        headerProfileLabel.snp.makeConstraints { make in
//            make.width.equalTo(200)
            make.top.equalTo(600) //325
            make.centerX.equalToSuperview()
        }
        buttonNextScreen.snp.makeConstraints { make in
            make.width.equalTo(350)
            make.height.equalTo(45)
            make.top.equalTo(480)
            make.centerX.equalToSuperview()
        }
    }
}







