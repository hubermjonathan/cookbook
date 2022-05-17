//
//  ItemRow.swift
//  Cookbook (iOS)
//
//  Created by Jonathan Huber on 5/17/22.
//

import SwiftUI

struct ItemRow: View {
    @ObservedObject var item: Item
    
    var body: some View {
        HStack {
            Text(item.name ?? Constants.UNKOWN_NAME)
            
            Spacer()
            
            Text(item.amount ?? Constants.UNKOWN_AMOUNT)
                .padding(.trailing, 5)
        }
    }
}
