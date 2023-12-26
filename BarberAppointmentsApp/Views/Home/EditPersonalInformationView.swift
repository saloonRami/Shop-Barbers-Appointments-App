//
//  PersonalInformationView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 21/09/2023.
//

import SwiftUI

struct EditPersonalInformationView: View {
    
    @EnvironmentObject var ProfileViewModel : ProfileSettingsViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var Edit: String

     @State var textValue : String

     @State var NameFromFirebase : String = ""


    var body: some View {
        VStack{

            VStack{
                Text("Update Your \(Edit)")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .padding()

                Text("Adding your name makes it easier for barbers to know and recognize you")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .bold()
                    .padding(.vertical)
            }
            Text("\(Edit)")
                .font(.title)
                .lineLimit(0)
                .edgesIgnoringSafeArea(.all)
                .multilineTextAlignment(.leading)
                .foregroundColor(.gray.opacity(0.8))
            HStack{
                TextField(self.textValue, text: $textValue)
                    .font(.headline)
                    .bold()
                    .padding()

                Button(action: {
                    self.textValue = ""
                    self.NameFromFirebase = ""
                }) {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24,height: 24)
                        .foregroundColor(.black)
                        .padding()
                }
            }
            .overlay{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 0.5)
                    .foregroundColor(.gray)
                    .shadow(color: Color.gray.opacity(0.4),radius: 3,x: 1,y: 2)
            }
            Button {
                ProfileViewModel.GetFuncProfileForUpdate(num: Edit, TextFieldValue: self.textValue)
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Update")
                    .font(.title3)
                    .frame(width: 400,height: 60)
                    .bold()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(9)
                    .padding(.top,144)

            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
        .navigationBarTitle("Edit \(Edit)")
        .task(priority: .high, {
            self.ProfileViewModel.GetUserProfile()
        })
    }
}

struct EditPersonalInformationView_Previews: PreviewProvider {
    static var previews: some View {
        EditPersonalInformationView(Edit: "Name", textValue: "Rami alaidy", NameFromFirebase: "Rami ")
            .environmentObject(ProfileSettingsViewModel())
    }
}
