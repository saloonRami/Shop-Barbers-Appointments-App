//
//  HomeTabMainView.swift
//  BarberAppointmentsApp
//
//  Created by Rami Alaidy on 21/12/2023.
//

import SwiftUI

struct HomeTabMainView: View {
    @State var selected: Int = 0
    @EnvironmentObject var UserBarberModelData : UserBareberViewModel
    @EnvironmentObject var approveTimerManger : ApproveTimerManager
    
    @AppStorage("IsProducts") var IsProducts: Bool = false
    @AppStorage("IsOwner") var IsOwner: Bool = true

    var body: some View {
        NavigationView {
            TabView{
//                ReservationRequestsView(image: UIImage(systemName: "person.circle.fill")!, isShowContent: .constant(true))
                AddTeamMemberView()
                    .tabItem{
                        VStack{
                            Image(systemName: "bookmark.circle.fill")
                            Text("My Order")
                        }
                    }
                    .tag(0)

                if IsProducts{
                    CareProductsView()
                        .tabItem {
                            VStack{
                                Image(systemName: "cart.circle.fill")
                                Text(" Care Products")
                            }
                        }
                        .tag(1)
                }
                if IsOwner{
                    AprroveTimerView(approveTimerManager:approveTimerManger).environmentObject(ApproveTimerManager())

                        .tabItem {
                            VStack{
                                Image(systemName: "scissors.circle.fill")
                                Text("Proof Daily Work")
                            }
                        }
                        .tag(2)
                }
                BarberView()
                    .tabItem {
                        VStack{
                            Image(systemName: "scissors.circle.fill")
                            Text("Staff Management")
                        }
                    }
                    .tag(3)

                ProfileView(name: "Date", valueDate: Date.today)
                    .environmentObject(UserBarberModelData)
                    .tabItem {
                        VStack{
                            Image(systemName: "person.circle.fill")
                            Text("My Profile")
                        }
                    }
                    .onAppear(){
                        let _: () = self.UserBarberModelData.getUserBarber()
                        print( self.UserBarberModelData.UserBarberModerl as Any)
                    }
                    .tag(4)
            }
            .preferredColorScheme(.light)
            .onAppear() {
                UITabBar.appearance().barTintColor = .white
                guard  UserBarberModelData.UserBarberModerl.isOwner != nil else{return}
                 self.IsOwner = UserBarberModelData.UserBarberModerl.isOwner!
            }
        }
    }
}

#Preview {
    HomeTabMainView()
        .environmentObject(ApproveTimerManager())
        .environmentObject(UserBareberViewModel())
}
