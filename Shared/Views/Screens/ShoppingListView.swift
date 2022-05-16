//
//  ShoppingListView.swift
//  Cookbook (iOS)
//
//  Created by Jonathan Huber on 5/13/22.
//

import SwiftUI

struct ShoppingListView: View {
    private var dataController: DataController = DataController.shared
    
    var items: FetchedResults<Item>
    
    init(items: FetchedResults<Item>) {
        self.items = items
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Category.allCases, id: \.self) { category in
                    Section(header: Text(category.rawValue)) {
                        ForEach(items.filter { item in item.category == category.rawValue }) { item in
                            HStack {
                                Text(item.name!)
                                
                                Spacer()
                                
                                Text(item.amount!)
                                    .padding(.trailing, 5)
                            }
                            .contentShape(Rectangle())
                            .swipeActions(edge: .trailing) {
                                Button(action: {
                                    removeItem(item: item)
                                    let hapticFeedback = UINotificationFeedbackGenerator()
                                    hapticFeedback.notificationOccurred(.success)
                                }) {
                                    Image(systemName: "trash.fill")
                                }
                                .tint(.red)
                            }
                            
                        }
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("Shopping List")
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: AddItemView()) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

extension ShoppingListView {
    private func removeItem(item: Item) {
        dataController.delete(item)
    }
}
