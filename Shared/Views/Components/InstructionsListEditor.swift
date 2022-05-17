//
//  InstructionsListEditor.swift
//  Cookbook (iOS)
//
//  Created by Jonathan Huber on 5/15/22.
//

import SwiftUI

struct InstructionsListEditor: View {
    @Binding var steps: [String]
    
    private func getStepBinding(forIndex index: Int) -> Binding<String> {
        return Binding<String>(
            get: { steps[index] },
            set: { step in steps[index] = step }
        )
    }
    
    var body: some View {
        Section(header: Text("Instructions")) {
            ForEach(0 ..< steps.count, id: \.self) { index in
                ListItem(step: getStepBinding(forIndex: index), order: Int16(index + 1)) {
                    self.steps.remove(at: index)
                }
            }
            
            AddButton() {
                self.steps.append("")
            }
        }
    }
}

fileprivate struct ListItem: View {
    @Binding var step: String
    
    @State private var placeholderStep: String = "Step"
    
    var order: Int16
    var removeAction: () -> Void
    
    var body: some View {
        HStack {
            Text("\(order).")
                .padding(.trailing, 5)
            
            ZStack(alignment: .leading) {
                if step.isEmpty {
                    TextEditor(text: $placeholderStep)
                        .foregroundColor(Color(UIColor.placeholderText))
                        .padding(.vertical, 5)
                }
                
                TextEditor(text: $step)
                    .padding(.vertical, 5)
            }
        }
        .swipeActions(edge: .trailing) {
            Button(action: {
                removeAction()
                let hapticFeedback = UINotificationFeedbackGenerator()
                hapticFeedback.notificationOccurred(.success)
            }) {
                Image(systemName: "trash.fill")
            }
            .tint(.red)
        }
    }
    
}

fileprivate struct AddButton: View {
    var addAction: () -> Void
    
    var body: some View {
        Button(action: addAction) {
            HStack {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.green)
                    .padding(.horizontal)
                
                Text("add instruction")
            }
        }
    }
}
