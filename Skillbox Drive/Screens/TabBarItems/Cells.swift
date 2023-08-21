//
//  Cells.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import UIKit
import SnapKit

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
            make.height.equalTo(60)
            make.width.equalTo(60)
            make.left.equalTo(5)
            make.top.bottom.equalToSuperview()
        }
        headerLabel.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.height.equalTo(50)
            make.left.equalTo(imagePreview).inset(100)
            make.top.equalTo(0)
        }
        infoLabel.snp.makeConstraints { make in
            make.height.equalTo(34)
            make.left.equalTo(imagePreview).inset(100)
            make.top.equalTo(headerLabel).inset(8)
            make.bottom.equalTo(16)
        }
    }
}
