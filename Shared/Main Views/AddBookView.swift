//
//  AddBookView.swift
//  Footnote+
//
//  Created by Cameron Bardell on 2021-06-13.
//

import SwiftUI
import CoreData

struct AddBookView: View {

    let persistenceController = PersistenceController.shared
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var bookViewModel = BookViewModel(nil)
    @Binding var showAddBook: Bool
    
    var body: some View {
        NavigationView {

            Form {
                TextField("Title", text: $bookViewModel.title)
                TextField("Author", text: $bookViewModel.author)

                Picker("Status", selection: $bookViewModel.status) {
                    ForEach(BookState.allCases, id: \.self) {
                        Text($0.stringValue)
                    }
                }
                .pickerStyle(.automatic)

                ColorPicker("Color", selection: $bookViewModel.color, supportsOpacity: false)

            }
            .navigationTitle("Add a new book")


        }
        .safeAreaInset(edge: .bottom, content: {
            Button(action: saveBook) {
                Label("Save", systemImage: "book.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .padding()
            .tint(bookViewModel.color)
        })

    }

    func saveBook() {
        let book = Book(context: persistenceController.container.viewContext)

        book.dateCreated = bookViewModel.dateCreated
        book.id = bookViewModel.id
        book.status = bookViewModel.status.rawValue
        book.title = bookViewModel.title
        book.author = bookViewModel.author
        book.colorAsHex = UIColor(bookViewModel.color).toHexString()

        do {
            try viewContext.save()
            showAddBook.toggle()
        } catch {
            print("Not saved")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Title"
        book.dateCreated = Date()
        return Group {
            AddBookView(showAddBook: .constant(true))
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
