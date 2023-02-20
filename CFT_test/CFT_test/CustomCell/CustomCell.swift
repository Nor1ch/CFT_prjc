//
//  CustomCell.swift
//  CFT_test
//
//  Created by Nor1 on 16.02.2023.
//

import Foundation
import SnapKit
import UIKit

class CustonCell: UICollectionViewCell {
    
    static let identifier = "CustomCell"
    
    private lazy var cellImage: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(systemName: "person")
        return view
    }()
    private lazy var cellTitleLabel: UILabel = {
       let view = UILabel()
        view.text = "TEST TEST TEST"
        view.numberOfLines = 0
        return view
    }()
    private lazy var cellDescriptionLabel: UILabel = {
       let view = UILabel()
        view.text = "ASDasdasdafafAAAHSHHDHFGGSUDHQOWJDKALSKFLAHFKJASDLKASJLKFAHFLk"
        view.numberOfLines = 3
        return view
    }()
    private lazy var vStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        makeConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        vStackView.addArrangedSubview(cellTitleLabel)
        vStackView.addArrangedSubview(cellDescriptionLabel)
        addSubview(cellImage)
        addSubview(vStackView)
    }
    
    private func makeConstraints(){
        cellImage.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        vStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalTo(cellImage.snp.right)
        }
    }
    func setupWidth(view: UICollectionView){
        self.widthAnchor.constraint(equalToConstant: view.bounds.size.width - 30).isActive = true
    }
}
