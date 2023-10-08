//
//  Cells.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import UIKit
import SnapKit
import SDWebImage

protocol CellsProtocol: AnyObject {
    func сonfiguresFiles(modelCell: Item)
    
}

class Cells: UITableViewCell {
// MARK: - label and image
    var headerLabel: UILabel = {
    let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15,
                                       weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
    return label
  }()
    var infoLabel: UILabel = {
    let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15,
                                 weight: .light)
        label.textColor = .gray
        label.numberOfLines = 0
    return label
  }()
    var imagePreview: UIImageView = {
    let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
    return image
        }()
// MARK: - init
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        contentView.addSubview(headerLabel)
        contentView.addSubview(infoLabel)
        contentView.addSubview(imagePreview)
        setupeConstraint()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// MARK: - constraint
    private func setupeConstraint() {
        imagePreview.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.left.equalTo(5)
            make.centerY.equalToSuperview()
        }
        headerLabel.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.height.equalTo(20)
            make.left.equalTo(imagePreview.snp.right).inset(-20)
            make.top.equalTo(10)
        }
        infoLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.left.equalTo(imagePreview.snp.right).inset(-20)
            make.top.equalTo(30)
        }
    }
}

extension Cells: CellsProtocol {
    func сonfiguresFiles(modelCell: Item) {
//        headerLabel.text = modelCell.name
//
//
//        guard let url = URL(string: modelCell.preview ?? "") else { return }
//        if let _ = UserDefaults.standard.string(forKey: UserDefaultsKey.saveToken) {
//            imagePreview.sd_setImage(with: url,
//                                     placeholderImage: UIImage(systemName: "magnifyingglass"))
//        }
        
        
//        if let imageUrl = modelCell.preview,
//            let url = URL(string: imageUrl) {
//            var request = URLRequest(url: url)
//            if let token = UserDefaults.standard.string(forKey: UserDefaultsKey.saveToken) {
//                request.setValue("OAuth \(token)",
//                                 forHTTPHeaderField: "Authorization")
//                URLSession.shared.dataTask(with: request) { data, _, _ in
//                    if let data = data, let image = UIImage(data: data) {
//                        DispatchQueue.main.async {
//                            .imagePreview.image = image
//                        }
//                    }
//                }.resume()
//            }
    }
    
    
    
    
    
}
