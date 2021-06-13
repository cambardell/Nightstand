//
//  ContentView.swift
//  Shared
//
//  Created by Cameron Bardell on 2020-12-27.
//

import SwiftUI
import CoreData

struct BookList: View {
    let persistenceController = PersistenceController.shared
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var selectedBook: Book?
    @State var searchText = ""

    @SectionedFetchRequest<Int16, Book>(
        sectionIdentifier: \.status,
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.dateCreated, ascending: true)],
        animation: .default
    )
    private var sectionedBooks
    
    var body: some View {

        NavigationView {
            VStack {
                List {
                    ForEach(sectionedBooks) { section in
                        Section(header: Text(BookState(rawValue: section.id)?.stringValue ?? "test")) {
                            ForEach(section) { book in
                                NavigationLink {
                                    Text(book.title ?? "Title")
                                } label: {
                                    BookItemView(book: book)
                                }
                                .swipeActions {
                                    Button(role: .destructive) {
                                        deleteItem(books: [book])
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }

                            }
                        }
                    }
                }
                .searchable(text: $searchText)

            }.navigationTitle("Books")
                .ignoresSafeArea()

        }
        .safeAreaInset(edge: .bottom) {
            Button(action: addItem) {
                Label("Add Book", systemImage: "plus")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .tint(.accentColor)
            .padding()
            .background(.thinMaterial)
        }


    }
    
    private func deleteItem(books: [Book]) {
        withAnimation {
            books.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

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
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Title"
        book.dateCreated = Date()
        return BookList(selectedBook: .constant(book)).preferredColorScheme(.dark).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
