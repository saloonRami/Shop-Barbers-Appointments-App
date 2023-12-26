//
//  SelectDocuments.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 04/10/2023.
//

import SwiftUI

struct SelectDocumentsView: View {

    @Binding var SelectService: Bool
    @Binding var NameService: String
//    @Binding var ImageIcon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button {
                self.SelectService.toggle()
            } label: {

                HStack {
                    Text(NameService)
                        .font(.subheadline)
                        .bold()
                        .foregroundStyle(.blue)
                    Spacer()
                    Image(systemName: self.SelectService == true ? "arrow.up.circle.fill":"arrow.down.circle.fill")
                        .resizable()
                        .frame(width: 24,height: 24)
                        .scaledToFill()
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            Divider()
                .frame(height: 1)
                .background(.black)

            if self.SelectService{
                Group{
                    Text(DocumentsRequired(rawValue:NameService.description)?.DoucumentsRequiredInfo ?? "")
                        .font(.subheadline)
                        .lineLimit(5)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .padding([.top,.leading])
                }
                .animation(.interactiveSpring)
            }
        }
    }
}


#Preview {
    SelectDocumentsView(SelectService: .constant(true), NameService: .constant(DocumentsRequired.PersonalProof.rawValue))
}
