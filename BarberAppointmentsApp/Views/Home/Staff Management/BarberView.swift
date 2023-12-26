//
//  BarberView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/09/2023.
//

import SwiftUI

struct BarberView: View {
    init(){
        UISegmentedControl.appearance().selectedSegmentTintColor = .gray
           UISegmentedControl.appearance().tintColor = .green
       }

    @State var segment = ["Booking dates","Permanence monitoring"]
    @State private var selectedFlavor: Flavor = .chocolate

    @EnvironmentObject var AddBarberVM : AddBarberViewModel
    @EnvironmentObject var StaffViewModel :  StaffManagementViewModel
    var body: some View {

        NavigationStack {

            List{
                SegimentListView(selectedFlavor: self.$selectedFlavor)
                ListViewAddBarber(data: self.$StaffViewModel.barberModel)
                    .environmentObject(StaffManagementViewModel())

            }
            .navigationTitle("Staff Management")
            .foregroundColor(.white)
        }
        .onAppear(){
            self.StaffViewModel.GetBarbersFromShop_barber()
        }
    }
}

struct BarberView_Previews: PreviewProvider {
    static var previews: some View {
            BarberView()
            .environmentObject(AddBarberViewModel())
            .environmentObject(StaffManagementViewModel())
    }
}
enum Flavor: String, CaseIterable, Identifiable {
    case chocolate, vanilla, strawberry
    var id: Self { self }
}

struct SegimentListView: View {
    @Binding var selectedFlavor: Flavor
    var body: some View {

        VStack{
            Picker("Flavor", selection: $selectedFlavor) {
                Text("Chocolate")
                    .foregroundColor(.white)
                    .tag(Flavor.chocolate)

                Text("Vanilla").tag(Flavor.vanilla)
                Text("Strawberry").tag(Flavor.strawberry)
            }
            .pickerStyle(.segmented)
        }
    }
}
