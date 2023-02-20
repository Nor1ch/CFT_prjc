//
//  UITextView+extension.swift
//  CFT_test
//
//  Created by Nor1 on 20.02.2023.
//

import Foundation
import UIKit
import SnapKit

extension UITextView {
    
    func setupEditingButtons(target: Any, sizeSelector: Selector, fontSelector: Selector) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))
        let sizeButton = UIButton()
        sizeButton.setImage(UIImage(systemName: "textformat.size"), for: .normal)
        sizeButton.layer.borderWidth = 1
        sizeButton.layer.cornerRadius = 10
        sizeButton.layer.borderColor = Constants.Color.greenLight?.cgColor
        let sizeTap = UITapGestureRecognizer(target: target, action: sizeSelector)
        sizeButton.addGestureRecognizer(sizeTap)
        view.addSubview(sizeButton)
        
        let fontButton = UIButton()
        fontButton.setImage(UIImage(systemName: "bold"), for: .normal)
        fontButton.layer.borderWidth = 1
        fontButton.layer.cornerRadius = 10
        fontButton.layer.borderColor = Constants.Color.greenLight?.cgColor
        let fontTap = UITapGestureRecognizer(target: target, action: fontSelector)
        fontButton.addGestureRecognizer(fontTap)
        view.addSubview(fontButton)
        
        fontButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(50)
            make.right.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(2)
        }
        
        sizeButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(50)
            make.right.equalToSuperview().inset(60)
            make.bottom.equalToSuperview().inset(2)
        }
        self.inputAccessoryView = view
    }
}
