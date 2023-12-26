//
//  MultiSelectionView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 19/10/2023.
//

import SwiftUI

struct MultiSelectionView<Selectable: Identifiable & Hashable>: View {
    let options: [Selectable]
    let optionToString: (Selectable) -> String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var selected: Set<Selectable>

    @State var isSelectAnyCheck: Bool = false

    var body: some View {
        List {
            ForEach(options) { selectable in
                Button(action: { toggleSelection(selectable: selectable) }) {
                    HStack {
                        Text(optionToString(selectable)).foregroundColor(.black)
                        Spacer()
                        if selected.contains(where: { $0.id == selectable.id }) {
                            Image(systemName: "checkmark").foregroundColor(.accentColor)
                        }
                    }
                }.tag(selectable.id)
                    .onDisappear(){
                        if !optionToString(selectable).isEmpty{
                            self.isSelectAnyCheck = true
                        }else{
                            self.isSelectAnyCheck = false
                        }
                    }
            }
        }.listStyle(.sidebar)
            .navigationTitle("Selected Services")
            .navigationBarItems(trailing:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: self.isSelectAnyCheck == true ?  "checkmark.circle.fill":"checkmark.circle").foregroundColor(.green)
                    .font(.system(size: 24,weight: .bold))
                    .padding()
            }))
            .onAppear(){
                if !selected.isEmpty{
                    self.isSelectAnyCheck = true
                }else{
                    self.isSelectAnyCheck = false
                }
            }
    }

    private func toggleSelection(selectable: Selectable) {
        if let existingIndex = selected.firstIndex(where: { $0.id == selectable.id }) {
            selected.remove(at: existingIndex)

            if selected.isEmpty{
                self.isSelectAnyCheck.toggle()
            }
        } else {
            selected.insert(selectable)
            self.isSelectAnyCheck = true
        }
    }
}

struct MultiSelectionView_Previews: PreviewProvider {
    struct IdentifiableString: Identifiable, Hashable {
        let string: String
        var id: String { string }
    }

    @State static var selected: Set<IdentifiableString> = Set(["A", "C"].map { IdentifiableString(string: $0) })

    static var previews: some View {
        NavigationView {
            MultiSelectionView(
                options: ["A", "B", "C", "D"].map { IdentifiableString(string: $0) },
                optionToString: { $0.string },
                selected: $selected
            )
        }
    }
}
