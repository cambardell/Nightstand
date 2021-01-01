//
//  BookState.swift
//  Footnote+
//
//  Created by Cameron Bardell on 2020-12-31.
//

import Foundation

public enum BookState: Int16, CaseIterable {
    case wishlist = 0
    case purchased
    case inProgress
    case completed
    
    var stringValue: String {
        switch self {
        case .wishlist:
            return "Wishlist"
        case .purchased:
            return "Purchased"
        case .inProgress:
            return "In Progress"
        case .completed:
            return "Completed"
        }
    }
    
    func rawCoreDataValue() -> Int16 {
        Int16(self.rawValue)
    }
}
