//
//  AddbarberShopView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 22/09/2023.
//

import SwiftUI

struct AddbarberShopView: View {

    @EnvironmentObject var AddBarberVM : AddBarberViewModel 

    @State  var Shop_info : Barber?

    @State var isShowCreateBarber: Bool = false
    var body: some View {
        NavigationStack{
            List{
                Section(header: Text("Add Your Barber")) {

                    ListViewAddBarber(data: self.$AddBarberVM.barberArry)
                    Button {
                        self.isShowCreateBarber.toggle()

                    } label: {
                        HStack{
                            Image(systemName: "plus.circle.fill")
                                .font(.largeTitle)
                                .scaledToFill()
                                .aspectRatio(1 / 1, contentMode: .fill)

                            Text("Add Your Barber Shop")
                                .bold()
                                .padding()
                        }
                    }
                }.fullScreenCover(isPresented: self.$isShowCreateBarber, content: {
                    DocumentsRequiredView()
//                    AddToCreateBarberView(AddBarberViewModel: AddBarberVM)
                }) 
            }
            .onAppear(){
//                self.AddBarberVM.GetDataShopBarber()
            }
            .navigationTitle("Add Barber")
        }
    }
}

struct AddbarberShopView_Previews: PreviewProvider {
    static var previews: some View {
        AddbarberShopView()
            .environmentObject(AddBarberViewModel())
    }
}

