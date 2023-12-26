//
//  CreateShopCustomerView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 08/09/2023.
//

import SwiftUI
import Combine
struct CreateShopCustomerView: View {
    let d = infoCustomer
    @State var NameBrand = [String]()
    @State var EmailCustomer : String = ""
    @State var Price : String = ""
    @State var quantity : String = ""
    @ObservedObject  var AdminVM : AdminViewModel
    var body: some View {
        NavigationView{
            Form{
                Text("Create Customer")
                    .font(.largeTitle)
                    .bold()
                Section(header: Text("Store owner information" )) {
                    ForEach(d.StoreOwenerCustomer.indices, id: \.self) { index in
                        ProductsTextFeildView(TextFeildValue: self.$AdminVM.ValueTextFeild[index], Name:d.StoreOwenerCustomer[index] , keyboardEn: .defaults)
                    }
                    Button {
                        self.AdminVM.createUser()
                    } label: {
                        Text("Create Customer")
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .bold()
                    }
                    .padding()


                }
                Section(header: Text("Shop information" )) {
                    ForEach(d.Shopdata!.indices, id: \.self) { index in

//                        ProductsTextFeildView(NameProducts: self.$AdminVM.ValueTextFeild[index], Name:d.Shopdata[index] , keyboardEn: .defaults)

                    }
                    SelectPhotosView()
                }
                Section(header: Text("Legal Information" )) {
                    ForEach(d.LegaInformation ?? [""], id: \.self) { data in
                        Text(data)
                            .bold()
//                        ProductsTextFeildView(NameProducts: $NameBrand, Name: data, keyboardEn: .defaults)
                    }
                }
            }
        }
    }
}

struct CreateShopCustomerView_Previews: PreviewProvider {
    static var previews: some View {
        CreateShopCustomerView(AdminVM: AdminViewModel())
            .previewDevice(PreviewDevice(rawValue: "Mac Catalyst"))
//            .environmentObject(AdminViewModel())
//            .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch)"))
    }
}

final class AddShopCutomerViewModel : ObservableObject{
    @Published var Name : String = ""
    @Published var EmailCustomer : String = ""
    @Published var PhoneNumber : String = ""
    @Published var ShopName : String = ""
}
struct CustomerTextFeildModel{

    var StoreOwenerCustomer : [String]
    var IconImageStoreOwnerCustomer : [String]
    var StoreOwenerCustomer_keyBoard : [keyboardEnm]?
    var Shopdata: [String]?
    var LegaInformation: [String]?
}
let infoCustomer = CustomerTextFeildModel(StoreOwenerCustomer: ["Name","Email","Password","User Name","Phone Number","Name Shop","Locations"], IconImageStoreOwnerCustomer: ["person.circle.fill","envelope.circle.fill","lock.circle.fill","person.badge.key.fill","iphone.circle.fill","scissors.circle.fill","location.circle.fill"], StoreOwenerCustomer_keyBoard: [.userName,.email,.password,.userName,.phoneNum,.defaults,.Location], Shopdata: ["Phone Numberl","Owner_user"],LegaInformation: ["Commercial Registration No","personal identification"])

let createBarberShopCollection = CustomerTextFeildModel(StoreOwenerCustomer:["Name","Email","Password","User Name","Phone Number","Name Shop","Locations"], IconImageStoreOwnerCustomer:["person.circle.fill","envelope.circle.fill","lock.circle.fill","person.badge.key.fill","iphone.circle.fill","scissors.circle.fill","location.circle.fill"], StoreOwenerCustomer_keyBoard: [.userName,.email,.password,.userName,.phoneNum,.defaults,.Location])
