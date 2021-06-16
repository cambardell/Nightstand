//
//  Book+CoreDataClass.swift
//  Footnote+
//
//  Created by Cameron Bardell on 2020-12-31.
//
//

import Foundation
import CoreData

@objc(Book)
public class Book: NSManagedObject {
    public var quoteArray: [Quote] {
        let set = quote as? Set<Quote> ?? []
        return set.sorted {
            $0.dateCreated ?? Date() < $1.dateCreated ?? Date()
        }
    }
}
