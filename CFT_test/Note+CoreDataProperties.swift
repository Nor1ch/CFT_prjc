//
//  Note+CoreDataProperties.swift
//  CFT_test
//
//  Created by Nor1 on 17.02.2023.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var image: Data?
    @NSManaged public var title: String?
    @NSManaged public var description_note: String?

}

extension Note : Identifiable {

}
