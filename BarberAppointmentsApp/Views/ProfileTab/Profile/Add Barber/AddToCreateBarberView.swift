//
//  AddToCreateBarberView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 23/09/2023.
//

import SwiftUI

struct AddToCreateBarberView: View {

    @StateObject var AddBarberViewModel : AddBarberViewModel

let textNameCollection = createBarberShopCollection
    var body: some View {
        NavigationStack{

            List{
                ForEach(textNameCollection.StoreOwenerCustomer.indices, id: \.self) { index in
                    HStack{
                        ProductsTextFeildView(TextFeildValue:self.$AddBarberViewModel.ValueTextFeild[index], imageIcon: textNameCollection.IconImageStoreOwnerCustomer[index], Name: textNameCollection.StoreOwenerCustomer[index].description, keyboardEn: (self.textNameCollection.StoreOwenerCustomer_keyBoard?[index])!)
//                            .padding(.vertical)
                    }
                }
            }
            VStack{
                Button {
                    self.AddBarberViewModel.AddBarberToDataBase()
                } label: {
                    Text("Create Barber")
                        .font(.headline)
                        .frame(width: 250,height: 50)
                        .bold()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .multilineTextAlignment(.center)
                        .cornerRadius(9, corners: .allCorners)
                }
//                .padding(.horizontal)
            }
            .background(.clear)
            .padding([.top,.leading],4)
            .navigationTitle("Add New Barber ")
        }
    }
}

struct AddToCreateBarberView_Previews: PreviewProvider {
    static var previews: some View {
        AddToCreateBarberView(AddBarberViewModel: AddBarberViewModel.init())
            .environmentObject(AddBarberViewModel())
    }
}
