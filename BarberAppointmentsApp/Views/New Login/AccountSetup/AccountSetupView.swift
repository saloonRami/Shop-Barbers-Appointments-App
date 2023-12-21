//
//  AccountSetupView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/11/2023.
//

import SwiftUI

struct AccountSetupView: View {

    @State private var ProgressValue: Float = 0.0
    @State private var isLoading: Bool = false
    @State private var selectionTab = 0

    @FocusState private var isFocusedTextField: Bool
    @State  var IsEmptyData : Bool = false

    var body: some View {

        NavigationView {

            VStack{
                HeaderAccountSetup(ProgressValue: $ProgressValue,selectTab:$selectionTab,isFocusedTextField: _isFocusedTextField)

                VStack {
                    TabView(selection: $selectionTab) {

                        BusniessNameView(OnEmailCount: {data in
                            print(data)
                            self.IsEmptyData = data.description.count < 4 ? true : false
                        })
                            .contentShape(Rectangle()).gesture(DragGesture())  // << here !!
                            .tag(0)

                        ServicesSelectView()
                            .contentShape(Rectangle()).gesture(DragGesture())  // << here !!
                            .tag(1)

                        TeamSizeView()
                            .contentShape(Rectangle()).gesture(DragGesture())  // << here !!
                            .tag(2)

                        AppleContentView(viewModel: ContentViewModel(), isFocusedTextField: _isFocusedTextField)
                            .contentShape(Rectangle()).gesture(DragGesture())
                            .tag(3)

                        Text(" Which software are you currently using?")
                            .contentShape(Rectangle()).gesture(DragGesture())
                            .tag(4)

                        Text("How did you hear about App?")
                            .contentShape(Rectangle()).gesture(DragGesture())
                            .tag(5)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }.frame(minWidth: .zero,maxWidth: .infinity,minHeight: 200,maxHeight: .infinity)
                VStack{

                    // Add Divider
                    Divider()
                        .frame(height: 4)
                        .background(.gray.opacity(0.2))

                    // Create Button
                    Button(action: {
                        self.isLoading = selectionTab == 5 ? true : false
                        selectionTab = (selectionTab == 5 ? selectionTab : selectionTab + 1) % 6
                        ProgressValue =  Float((Double(selectionTab) / 5.0))
                        self.isFocusedTextField = false
                    }, label: {
                        Text(self.isLoading ? "Loading......": selectionTab == 5 ? "Finish" : "Next")
                                .frame(width: 320,height: 16)
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .background(.black)
                                .cornerRadius(16)

                    })

                    .disabled( IsEmptyData ? false: true)
                    .opacity( IsEmptyData ? 1.0 : 0.6)
                    .padding(.top)
                }
                .fullScreenCover(isPresented: self.$isLoading){
                    TabHomeView()
                    .environmentObject(UserBareberViewModel())
                }
            }
    
        }
    }
}

#Preview {
    AccountSetupView(IsEmptyData: true)
        .environmentObject(UserBareberViewModel())
}

