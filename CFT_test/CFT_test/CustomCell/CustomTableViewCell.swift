//
//  CustomTableViewCell.swift
//  CFT_test
//
//  Created by Nor1 on 17.02.2023.
//

import Foundation
import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    
    private lazy var containerView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = Constants.Color.greenLight?.cgColor
        view.backgroundColor = Constants.Color.white
        view.layer.shadowColor = Constants.Color.black?.cgColor
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.masksToBounds = false
        return view
    }()
    private lazy var imageViewCell: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(systemName: "person")
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var titleLabelCell: UILabel = {
       let view = UILabel()
        view.text = "Тестовый заголовок"
        view.textAlignment = .center
        return view
    }()
    private lazy var hStackView: UIStackView = {
       let view = UIStackView()
        view.axis = .horizontal
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        makeConstraints()
        backgroundColor = Constants.Color.whiteBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        hStackView.addArrangedSubview(imageViewCell)
        hStackView.addArrangedSubview(titleLabelCell)
        containerView.addSubview(hStackView)
        addSubview(containerView)
    }
    
    func setupCell(title: String, fontSizeTitle: Double, fontTitle: String, image: Data?){
        titleLabelCell.text = title
        switch fontTitle {
        case "system":
            titleLabelCell.font = .systemFont(ofSize: fontSizeTitle)
        case "bold":
            titleLabelCell.font = .boldSystemFont(ofSize: fontSizeTitle)
        case "italic":
            titleLabelCell.font = .italicSystemFont(ofSize: fontSizeTitle)
        default:
            break
        }
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
            make.left.equalToSuperview().offset(10)
        }
        hStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageViewCell.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
    }
}
