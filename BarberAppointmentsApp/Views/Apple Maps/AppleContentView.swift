//
//  AppleConta.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 04/11/2023.
//

import SwiftUI

struct AppleContentView: View {

    @StateObject var viewModel: ContentViewModel
    @FocusState var isFocusedTextField : Bool

    var body: some View {
//        NavigationView {
            VStack(alignment: .leading, spacing: 0) {

                TextField("Type address", text: $viewModel.searchableText)
                    .padding()
                    .autocorrectionDisabled()
                    .focused($isFocusedTextField)
                    .font(.title)
                    .onReceive(
                        viewModel.$searchableText.debounce(
                            for: .seconds(0.1),
                            scheduler: DispatchQueue.main
                        )
                    ) {
                        viewModel.searchAddress($0)
                    }
                    .background(Color.init(uiColor: .systemBackground))
                    .overlay {
                        ClearButton(text: $viewModel.searchableText)
                            .padding(.trailing)
                            .padding(.top, 8)
                    }
                    .onAppear {
                        isFocusedTextField = true
                    }

                List(self.viewModel.results) { address in
                    AddressRow(address: address)
                        .listRowBackground(backgroundColor)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)

            }
            .background(backgroundColor)
            .edgesIgnoringSafeArea(.bottom)
//        }
//        .navigationTitle(Text("Set your location"))
    }
    var backgroundColor: Color = Color.init(uiColor: .systemGray6)
}

#Preview {
    AppleContentView(viewModel: ContentViewModel())
        .environmentObject(ContentViewModel())
}

struct ClearButton: View {

    @Binding var text: String

    var body: some View {
        if text.isEmpty == false {
            HStack {
                Spacer()
                Button {
                    text = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                }
                .foregroundColor(.secondary)
            }
        } else {
            EmptyView()
        }
    }
}


struct AddressRow: View {

    let address: AddressResult

    var body: some View {
        NavigationLink {
            AppleMapView(address: address)
        } label: {
            VStack(alignment: .leading) {
                Text(address.title)
                Text(address.subtitle)
                    .font(.caption)
            }
        }
        .padding(.bottom, 2)
    }
}
