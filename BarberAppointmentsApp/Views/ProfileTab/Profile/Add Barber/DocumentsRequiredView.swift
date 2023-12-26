//
//  DocumentsRequiredView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 04/10/2023.
//

import SwiftUI

struct DocumentsRequiredView: View {

    @State private var NameDocuments: DocumentsRequired = .ProofWork
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var SelectDocuments : Bool = false
    @State private var SelectBarberInfo: Bool = false
    @State private var SelectProofWork: Bool = false
    @State private var IsNext: Bool = false

    var body: some View {
        NavigationStack{
            VStack{
                VStack {
                    Image(systemName: "list.bullet.clipboard.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64,height: 64)
                        .padding([.bottom],24)

                    Text("The required documents")
                        .font(.title2)
                        .bold()
                        .frame(width: 600.0, height: 20.0)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.blue)
                        .padding(.vertical)
                        .padding(.horizontal)
                        .background(Color.gray.opacity(0.1))
                        .padding()

                    Text("Before starting, please prepare the following documents")
                        .font(.subheadline)
                        .lineLimit(2)
                        .bold()
                        .multilineTextAlignment(.leading)
                        .padding()

                }
                VStack{
                    SelectDocumentsView(SelectService: self.$SelectDocuments, NameService: .constant(DocumentsRequired.PersonalProof.rawValue))

                    SelectDocumentsView(SelectService: self.$SelectBarberInfo, NameService: .constant(DocumentsRequired.Barberinformation.rawValue))

                    SelectDocumentsView(SelectService: self.$SelectProofWork, NameService: .constant(DocumentsRequired.ProofWork.rawValue))
                }
                VStack{
                    NavigationLink {
                        VerfiyPhoneNumberView(additionsTitle: "Barber ",isBackButton:false)
                    } label: {
                        Text("Next")
                            .font(.title)
                            .bold()
                            .frame(width: 350,height: 50)
                            .foregroundStyle(.white)
                            .background(.blue)
                            .cornerRadius(16, corners: .allCorners)
                            .padding([.top,.bottom],12)
                    }
                }
            }
            .padding()
        }
    }
}
#Preview {
    DocumentsRequiredView()
        .environmentObject(VerifyPhoneViewModel())
}

enum DocumentsRequired:String, CaseIterable{
    case PersonalProof = "Personal proof of the barber"
    case Barberinformation = "Barber information"
    case ProofWork = "Proof of work"

    var DoucumentsRequiredInfo: String{
        switch self{

        case .PersonalProof: return "You must have a personal ID,\n work permit or passport"
        case .Barberinformation: return "You must have an effective phone number for the barber and make sure that you can access the activation code./n/n You must have the email of the barber that you want to add to your salon and information about him. "
        case .ProofWork: return "If he has experience certificates "
        }
    }
    var imageIcon:String{
        switch self{
        case .PersonalProof: return "dryer_icon"
        case .Barberinformation: return "color-hair"
        case .ProofWork: return "cut_icon"
        }
    }
}

