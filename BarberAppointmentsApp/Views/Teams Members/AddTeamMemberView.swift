//
//  AddTeamMemberView .swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 11/11/2023.
//

import SwiftUI

struct AddTeamMemberView: View {


    @State private var SelectedPageView: Int = 0
    
   

    @Namespace private var topID
    @Namespace private var bottomID

    var body: some View {

        VStack(alignment: .leading) {

            VStack(alignment: .leading){
                CollectionInfoTeamView(SelectedPageView: $SelectedPageView)
                Divider()
                    .frame(height: 1)
                    .background(.gray.opacity(0.7))
            }

            VStack{
                TabView(selection: $SelectedPageView){
                    ProfileTeamMemberView()
                        .tabItem {
                        Text("Tab Label 1")
                    }
                    .tag(0)

                    ServicesSelectView()
                        .tabItem { Text("Tab Label 2") }
                        .tag(1)

                    Text("Tab Content 3")
                        .tabItem {
                        Text("Tab Label 3")
                    }
                    .tag(2)

                    Text("Tab Content 4")
                        .tabItem { Text("Tab Label 4") }
                        .tag(3)

                    Text("Tab Content 5")
                        .tabItem { Text("Tab Label 5") }
                        .tag(4)

                } .tabViewStyle(.page(indexDisplayMode: .never))
                    .scrollDisabled(false)
                Button {

                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity,maxHeight: 20)
                            .padding()
                            .cornerRadius(16)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(16)
                        .ignoresSafeArea()
                }
            }

//            VStack{
//
//                Button {
//
//                } label: {
//                    Text("Save")
//                        .frame(maxWidth: .infinity,maxHeight: 20)
//                            .padding()
//                            .cornerRadius(16)
//                        .font(.title)
//                        .bold()
//                        .foregroundColor(.white)
//                        .background(.black)
//                        .cornerRadius(16)
//                        .ignoresSafeArea()
//                }
//            }
            .padding()
            /*.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)*/
        }
        .padding(.vertical)
        .navigationTitle("Add team member")
        .navigationBarTitleDisplayMode(.automatic)
        .navigationBarItems(trailing:
            Image(systemName: "xmark.circle.fill")
            .resizable()
            .scaledToFill()
            .frame(width: 24,height:24)
            .cornerRadius(64)
    )
        .edgesIgnoringSafeArea(.bottom)
    }

}

#Preview {
    NavigationStack{
        AddTeamMemberView()
    }
}

enum AddTeamCollectionsView: Int,CaseIterable{

    case profile = 0
    case Services
    case Locations
    case Settings
    case Commissions

    var descriptionString: String{
        switch self{

        case .profile:
            "Profile"
        case .Services:
            "Services"
        case .Locations:
            "Locations"
        case .Settings:
            "Settings"
        case .Commissions:
            "Commissions"
        }
    }

}

