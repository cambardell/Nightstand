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
    
    @State var showAddBook = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                ListView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                
            }.navigationTitle("Books")
                .safeAreaInset(edge: .bottom) {
                    Button(action: {
                        showAddBook.toggle()
                    }) {
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
        .sheet(isPresented: $showAddBook) {
            AddBookView(showAddBook: $showAddBook)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
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
    static var previews: some View {
        return BookList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct ListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    let persistenceController = PersistenceController.shared
    
    @SectionedFetchRequest<Int16, Book>(
        sectionIdentifier: \.status,
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.status, ascending: true)],
        animation: .default
    ) var sectionedBooks: SectionedFetchResults<Int16, Book>
    
    @State private var searchText = ""
    var query: Binding<String> {
        Binding {
            searchText
        } set: { newValue in
            searchText = newValue
            sectionedBooks.nsPredicate = newValue.isEmpty
            ? nil
            : NSPredicate(format: "title CONTAINS %@ OR author CONTAINS %@", newValue, newValue)
        }
    }
    
    
    var body: some View {
        List {
            ForEach(sectionedBooks) { section in
                Section(header: Text(BookState(rawValue: section.id)?.stringValue ?? "Wishlist")) {
                    ForEach(section) { book in
                        NavigationLink {
                            BookDetailView(book: book, bookViewModel: BookViewModel(book))
                                .environment(\.managedObjectContext, persistenceController.container.viewContext)
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
            
        }.searchable(text: query)

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
}
