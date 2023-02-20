//
//  EditVC.swift
//  CFT_test
//
//  Created by Nor1 on 17.02.2023.
//

import Foundation
import UIKit
import SnapKit

class EditVC: UIViewController {
    
    var note: Note?
    
    private var fontSizeDescription = 12
    private var fontDescription: UIFont = .systemFont(ofSize: 12)
    private var fontSizeTitle = 12
    private var fontTitle: UIFont = .systemFont(ofSize: 12)
    
    private lazy var imageViewEdit: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(systemName: "person")
        view.layer.cornerRadius = 10
        view.layer.borderColor = Constants.Color.greenLight?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    private lazy var titleLabelEdit: UILabel = {
       let view = UILabel()
        view.text = "Заголовок"
        view.textAlignment = .center
        return view
    }()
    private lazy var descriptionLabelEdit: UILabel = {
       let view = UILabel()
        view.text = "Описание"
        view.textAlignment = .center
        return view
    }()
    private lazy var titleTextViewEdit: UITextView = {
        let view = UITextView()
        view.text = "Заголовок изменить"
        view.textAlignment = .center
        view.layer.cornerRadius = 10
        view.layer.borderColor = Constants.Color.greenLight?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    private lazy var descriptionTextViewEdit: UITextView = {
        let view = UITextView()
        view.text = "Описание заметки очень длинный текст Описание заметки очень длинный текст Описание заметки очень длинный текст Описание заметки очень длинный текст"
        view.textAlignment = .center
        view.layer.cornerRadius = 10
        view.layer.borderColor = Constants.Color.greenLight?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    private lazy var vStackViewTitle: UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
        view.isLayoutMarginsRelativeArrangement = true
        return view
    }()
    private lazy var hStackView: UIStackView = {
       let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        makeConstraints()
        view.backgroundColor = Constants.Color.whiteBackground
        
        if let note = note {
            titleTextViewEdit.text = note.title
            descriptionTextViewEdit.text = note.description_note
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        try? note?.managedObjectContext?.save()
    }
    
    private func setupViews(){
        view.addSubview(vStackView)
        vStackView.addArrangedSubview(hStackView)
        hStackView.addArrangedSubview(imageViewEdit)
        hStackView.addArrangedSubview(vStackViewTitle)
        vStackViewTitle.addArrangedSubview(titleLabelEdit)
        vStackViewTitle.addArrangedSubview(titleTextViewEdit)
        vStackView.addArrangedSubview(descriptionLabelEdit)
        vStackView.addArrangedSubview(descriptionTextViewEdit)
        titleTextViewEdit.delegate = self
        descriptionTextViewEdit.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(returns))
        view.addGestureRecognizer(tap)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(doneTapped))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        descriptionTextViewEdit.setupEditingButtons(target: self, sizeSelector: #selector(doSizeDescription), fontSelector: #selector(doFontDescription))
        titleTextViewEdit.setupEditingButtons(target: self, sizeSelector: #selector(doSizeTitle), fontSelector: #selector(doFontTitle))
    }
    
    private func makeConstraints(){
        vStackView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(350)
        }
        hStackView.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
        imageViewEdit.snp.makeConstraints { make in
            make.width.equalTo(120)
        }
        titleLabelEdit.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        descriptionLabelEdit.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    
    
    @objc private func doSizeDescription(){
        navigationItem.rightBarButtonItem?.isEnabled = true
        if fontSizeDescription != 22 {
            fontSizeDescription += 2
            descriptionTextViewEdit.font = fontDescription.withSize(CGFloat(fontSizeDescription))
        } else {
            fontSizeDescription = 12
            descriptionTextViewEdit.font = fontDescription.withSize(CGFloat(fontSizeDescription))
        }
    }
    @objc private func doFontDescription(){
        navigationItem.rightBarButtonItem?.isEnabled = true
        switch fontDescription.withSize(CGFloat(fontSizeDescription)) {
        case .systemFont(ofSize: CGFloat(fontSizeDescription)):
            fontDescription = .boldSystemFont(ofSize: CGFloat(fontSizeDescription))
            descriptionTextViewEdit.font = fontDescription
        case .boldSystemFont(ofSize: CGFloat(fontSizeDescription)):
            fontDescription = .italicSystemFont(ofSize: CGFloat(fontSizeDescription))
            descriptionTextViewEdit.font = fontDescription
        case .italicSystemFont(ofSize: CGFloat(fontSizeDescription)):
            fontDescription = .systemFont(ofSize: CGFloat(fontSizeDescription))
            descriptionTextViewEdit.font = fontDescription
        default:
            break
        }
    }
    
    
    @objc private func doSizeTitle(){
        navigationItem.rightBarButtonItem?.isEnabled = true
        if fontSizeTitle != 22 {
            fontSizeTitle += 2
            titleTextViewEdit.font = fontTitle.withSize(CGFloat(fontSizeTitle))
        } else {
            fontSizeTitle = 12
            titleTextViewEdit.font = fontTitle.withSize(CGFloat(fontSizeTitle))
        }
    }
    @objc private func doFontTitle(){
        navigationItem.rightBarButtonItem?.isEnabled = true
        switch fontTitle.withSize(CGFloat(fontSizeTitle)) {
        case .systemFont(ofSize: CGFloat(fontSizeTitle)):
            fontTitle = .boldSystemFont(ofSize: CGFloat(fontSizeTitle))
            titleTextViewEdit.font = fontTitle
        case .boldSystemFont(ofSize: CGFloat(fontSizeTitle)):
            fontTitle = .italicSystemFont(ofSize: CGFloat(fontSizeTitle))
            titleTextViewEdit.font = fontTitle
        case .italicSystemFont(ofSize: CGFloat(fontSizeTitle)):
            fontTitle = .systemFont(ofSize: CGFloat(fontSizeTitle))
            titleTextViewEdit.font = fontTitle
        default:
            break
        }
    }

    
    
    @objc private func doneTapped(){
        view.endEditing(true)
        
        note?.title = titleTextViewEdit.text
        note?.description_note = descriptionTextViewEdit.text
        try? note?.managedObjectContext?.save()
        navigationController?.popViewController(animated: true)
    }
    @objc private func returns(){
        view.becomeFirstResponder()
        view.endEditing(true)
    }
}

extension EditVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
}
