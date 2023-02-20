//
//  MainVC.swift
//  CFT_test
//
//  Created by Nor1 on 16.02.2023.
//

import Foundation
import UIKit
import SnapKit
import CoreData

class MainVC: UIViewController {
    
    private var viewModel: MainViewModel?
    
    private lazy var tableView: UITableView = {
       let view = UITableView()
        view.backgroundColor = Constants.Color.whiteBackground
        view.separatorStyle = .none
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        makeConstraints()
        viewModel = MainViewModel(delegate: self)
        viewModel?.loadCoreData()
    }
    
    private func setupView(){
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        view.addSubview(tableView)
        
        title = "Заметки"
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addTapped)), animated: true)
    }
    
    private func makeConstraints(){
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    @objc private func addTapped(){
        let vc = EditVC()
        let note = viewModel?.makeNewNoteCD()
        vc.note = note
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - data source и delegate tableview
extension MainVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.fetchResultsController().sections?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = viewModel?.fetchResultsController().sections {
            return sections[section].numberOfObjects
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier) as? CustomTableViewCell
        if let item = viewModel?.fetchResultsController().object(at: indexPath){
        cell?.setupCell(title: item.title ?? "nil", image: nil)
        }
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let note = viewModel?.fetchResultsController().object(at: indexPath) {
            viewModel?.persistentContainerVM().viewContext.delete(note)
            try? viewModel?.persistentContainerVM().viewContext.save()
            }
        }
    }
}

extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EditVC()
        vc.note = viewModel?.fetchResultsController().object(at: indexPath)
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


//MARK: - делегат Core Data
extension MainVC: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
        
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                if let note = viewModel?.fetchResultsController().object(at: indexPath){
                let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell
                cell?.setupCell(title: note.title ?? "nil", image: nil)
                }
            }
        }
    }
}
