//
//  PersonalInformationView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 21/09/2023.
//

import SwiftUI

struct PersonalInformationView: View {

    let AllPersonalEdit = infoCustomer

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var ProfileViewModel : ProfileSettingsViewModel
    @State private var image = UIImage()
    @State private var isSelsetImage: Bool = false
    @Binding var imageProfile : URL?

    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Spacer()
                    Button {
                        self.isSelsetImage = true
                    } label: {
                        PersonalProfileView(urlImage: self.$ProfileViewModel.photoURL, name: self.$ProfileViewModel.display_name, email: self.$ProfileViewModel.email)
                    }
                    .sheet(isPresented: self.$isSelsetImage) {
//                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                        PhotoPicker()
                    }

                    Spacer()
                }
                Form{
                    ForEach(self.AllPersonalEdit.StoreOwenerCustomer.indices, id: \.self) { index in
                        NavigationLink {
                            EditPersonalInformationView(Edit: self.AllPersonalEdit.StoreOwenerCustomer[index], textValue: self.ProfileViewModel.ValueTextFeild[index])
                        } label: {
                            HStack{
                                Image(systemName: self.AllPersonalEdit.IconImageStoreOwnerCustomer[index])
                                    .scaledToFill()
//                                    .padding(.leading)
                                Text(self.AllPersonalEdit.StoreOwenerCustomer[index])
                                    .font(.headline)
                                    .multilineTextAlignment(.leading)
                                    .bold()
                                    .padding(.horizontal,16.0)
                            }
                        }
                        .padding()
                    }
//                    .padding()
                }
            }
            .onAppear(){
                self.ProfileViewModel.GetUserProfile()
            }
            .onChange(of: self.image) { newValue in
                self.ProfileViewModel.uploadMedia(image: newValue) { urls in
                    self.ProfileViewModel.photoURL = URL(string: urls?.first?.description ?? "")
                    print(urls?.first!.description ?? "")
                }
            }
            .navigationTitle("Personal Information")

            // Back Button
            
//            .navigationBarItems(leading:
//                                    Button(action: {
////                self.settingStore.showCheckInOnly = self.showCheckInOnly
////                self.settingStore.displayOrder = self.selectedProducts
////                self.settingStore.maxPriceLevel = self.maxPriceLevel
//                self.presentationMode.wrappedValue.dismiss()
//
//            }, label: {
//                Image(systemName: "chevron.backward.circle.fill")
//                    .font(.title)
//                    .bold()
//                    .foregroundColor(.black)
//                    .scaledToFill()
//                    .padding([.top, .leading, .bottom])
//            }) )
        }
    }
}

struct PersonalInformationView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInformationView( imageProfile: .constant(URL.init(string: "")))
            .environmentObject(ProfileSettingsViewModel())
    }
}
