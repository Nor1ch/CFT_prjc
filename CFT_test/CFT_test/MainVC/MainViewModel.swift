//
//  NoteViewModel.swift
//  CFT_test
//
//  Created by Nor1 on 17.02.2023.
//

import Foundation
import CoreData

class MainViewModel {
    
    
    private let delegate: NSFetchedResultsControllerDelegate?
    private let persistentContainer = NSPersistentContainer(name: "CDNoteModel")

    private lazy var fetchedResultsController: NSFetchedResultsController<Note> = {
        let fetch = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetch.sortDescriptors = [sortDescriptor]
        let fetchResultController = NSFetchedResultsController(fetchRequest: fetch, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = delegate
        return fetchResultController
    }()
    
    init(delegate: NSFetchedResultsControllerDelegate){
        self.delegate = delegate
    }
    
    func loadCoreData(){
        persistentContainer.loadPersistentStores { (store, error) in
            if let error = error {
                print("failed load store")
                print(error)
            } else {
                do {
                    try self.fetchedResultsController.performFetch()
                    if self.fetchedResultsController.fetchedObjects?.count == 0 {
                        let note = Note(entity: NSEntityDescription.entity(forEntityName: "Note", in: self.persistentContainer.viewContext)!, insertInto: self.persistentContainer.viewContext)
                        note.title = "Ваша новая заметка"
                        note.description_note = "Добавьте описание"
                        try? note.managedObjectContext?.save()
                        print("loaded")
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func saveNoteCD(note: Note){
        try? note.managedObjectContext?.save()
    }
    func makeNewNoteCD() -> Note {
        let note = Note.init(entity: NSEntityDescription.entity(forEntityName: "Note", in: persistentContainer.viewContext)!, insertInto: persistentContainer.viewContext)
        note.title = "Ваша новая заметка"
        note.description_note = "Добавьте описание"
        return note
    }
    
    func fetchResultsController() -> NSFetchedResultsController<Note> {
        return fetchedResultsController
    }
    func persistentContainerVM() -> NSPersistentContainer {
        return persistentContainer
    }
}
