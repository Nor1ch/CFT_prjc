//
//  Note+CoreDataProperties.swift
//  CFT_test
//
//  Created by Nor1 on 20.02.2023.
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
    @NSManaged public var fontSizeTitle: Double
    @NSManaged public var fontTitle: String?
    @NSManaged public var fontSizeDescription: Double
    @NSManaged public var fontDescription: String?

}

extension Note : Identifiable {

}
