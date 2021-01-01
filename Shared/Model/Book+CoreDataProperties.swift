//
//  Book+CoreDataProperties.swift
//  Footnote+
//
//  Created by Cameron Bardell on 2020-12-31.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var dateCreated: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var status: Int16
    @NSManaged public var quote: NSSet?

}

// MARK: Generated accessors for quote
extension Book {

    @objc(addQuoteObject:)
    @NSManaged public func addToQuote(_ value: Quote)

    @objc(removeQuoteObject:)
    @NSManaged public func removeFromQuote(_ value: Quote)

    @objc(addQuote:)
    @NSManaged public func addToQuote(_ values: NSSet)

    @objc(removeQuote:)
    @NSManaged public func removeFromQuote(_ values: NSSet)

}

extension Book : Identifiable {

}
