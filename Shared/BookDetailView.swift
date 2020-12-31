//
//  BookDetailView.swift
//  Footnote+
//
//  Created by Cameron Bardell on 2020-12-27.
//

import SwiftUI

struct BookDetailView: View {
    @Binding var selectedBook: Book?
    
    @State var title: String
    @State var author: String = "Author"
    @State var status: BookState
    
    var body: some View {
        
        GeometryReader { geometry in
            HStack {
                VStack(alignment: .leading) {
                    TextField("Title", text: $title)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.largeTitle)
                        
                    
                    TextField("Author", text: $author)
                        .font(.title)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    Picker(selection:
                            $status, label: Text("Status")) {
                        ForEach(BookState.allCases, id: \.rawValue) { type in
                            Text(type.stringValue)
                                .tag(type)
                        }
                    }.pickerStyle(DefaultPickerStyle())
                    .frame(width: 150)
                    
                    Text("Description Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                        
                    
                    Spacer()
                }
                .frame(width: geometry.size.width / 2)
                
                VStack {
                    HStack {
                        Text("Quote List").font(.title)
                        Spacer()
                        
                        Button(action: {
                            print("New Quote")
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(.footnoteRed)
                        }
                    }
                    Spacer()
                }
                Spacer()
                
            }.padding()
        }
        
    }
}

enum BookState: Int16, CaseIterable {
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

struct BookDetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Title"
        book.dateCreated = Date()
        return BookDetailView(selectedBook: .constant(book), title: book.title!, status: BookState(rawValue: 0)!)
    }
}
