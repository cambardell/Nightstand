//
//  Footnote_App.swift
//  Shared
//
//  Created by Cameron Bardell on 2020-12-27.
//

import SwiftUI

@main
struct Footnote_App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            BookList()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                
        }    }

    private func addItem() {
        withAnimation {
            let newItem = Book(context: persistenceController.container.viewContext)
            newItem.dateCreated = Date()
            newItem.id = UUID()


            do {
                try persistenceController.container.viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItem(book: Book) {
        withAnimation {
            persistenceController.container.viewContext.delete(book)
            
            do {
                try persistenceController.container.viewContext.save()
            
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    
    
}
