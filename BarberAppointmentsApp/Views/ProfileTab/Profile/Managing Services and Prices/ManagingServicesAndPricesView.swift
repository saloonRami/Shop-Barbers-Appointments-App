//
//  ManagingServicesAndPricesView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 19/10/2023.
//

import SwiftUI

struct ManagingServicesAndPricesView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var managingServicesVM : ManagingServicesViewModel
    @EnvironmentObject var AppointmentViewModel : AppointmentVM
    @EnvironmentObject var UserBareberViewModel : UserBareberViewModel
    @State var arrayString:[String] = []

    @State
    var task = TaskServise(name: "", servingGoals: [ServicesMenu.hairCut,ServicesMenu.shaving,ServicesMenu.hairDryer])
    @State var servicesMenu: ServicesMenu.AllCases

    @State private var isEditing: Bool = false
    @State private var showNewTask = false

    var body: some View {
        ZStack{
            VStack {

                HStack{

                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()

                    }) {
                        Image(systemName: "chevron.backward.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.purple)
                    }
                    Spacer()
                    Text("Managing Services")
                        .font(.system(size: 34, weight: .black, design: .rounded))
                        .fullScreenCover(isPresented: self.$showNewTask, content: {
                            NavigationView{
                                AddServicesView(servicesMenu: ServicesMenu.allCases, task: self.$task, arrayString: self.$arrayString)
                            }
                        })
                }
                .padding()
                Spacer()

                List{
                    Section(header: Text("Choose the services you want to provide")) {
                        MultiSelector(
                            label: Text("Select Services"),
                            options: servicesMenu,
                            optionToString: { $0.NameStringRawValue },
                            selected: $task.servingGoals
                        )
                    }
                    .onChange(of: task.servingGoals) { newValue in

                        self.arrayString.removeAll()
                        print(self.$task.servingGoals,"New Value \(newValue)")
                        self.arrayString =
                        task.servingGoals.map{ return $0.rawValue}
                    }
                    Section(header:
                                HStack{
                        Text("Services provided by your salon")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        Button(action: {
                            self.isEditing.toggle()
                        }, label: {
                            Text(self.isEditing ? "Add":"Edit")
                                .font(.subheadline)
                                .bold()
                        })
                    }){
                        ForEach($arrayString.indices,id: \.self){ index in
                            ServicesCellView(data: $arrayString[index], isEditing: self.$isEditing,textPrice: .constant("\(ServicesMenu.init(rawValue: arrayString[index])?.priceServices ?? 0 )"), textTime: .constant("\(ServicesMenu.init(rawValue: arrayString[index])?.TimesServices ?? 0 )"))
                        }
                    }
                }
                Button(action: {
                    self.UserBareberViewModel.getUserBarber()

                    for i in 0..<self.$arrayString.count{

                        self.UserBareberViewModel.AddServiceToDataBase(userOwnerID: "",nameService: arrayString[i],priceService: Int(ServicesMenu.init(rawValue: arrayString[i])?.priceServices ?? 0),TimeService: Int(ServicesMenu.init(rawValue: arrayString[i])?.TimesServices ?? 0),index: i)
                    }
                }, label: {
                    Text("Save")
                        .font(.system(size: 24,weight: .bold))
                        .frame(width: 250,height: 50)
                        .foregroundColor(.white)
                        .background(Color.lightBlue)
                        .cornerRadius(6, corners: .allCorners)
                        .cornerRadius(13)
                        .overlay {
                            Rectangle()
                                .stroke()
                                .stroke(lineWidth: 4)
                                .foregroundColor(.white)
                                .cornerRadius(6, corners: .allCorners)
                                .cornerRadius(13)

                        }
                        .shadow(color: .purple.opacity(0.9), radius: 12)
                        .padding(.horizontal)
                })
                .padding(.all)
            }
            .rotation3DEffect(Angle(degrees: showNewTask ? 5 : 0), axis: (x: 1, y: 0, z: 0))
            .offset(y: showNewTask ? -50 : 0)
            .animation(.easeOut)
            .navigationBarBackButtonHidden()
            .listRowInsets(EdgeInsets())
        }
        .onAppear(){
            self.arrayString =
            task.servingGoals.map{ return $0.rawValue}
            self.AppointmentViewModel.numberOfServices =  task.servingGoals.map{ return $0.rawValue}.count
        }
    }
}

#Preview {
    ManagingServicesAndPricesView(servicesMenu: ServicesMenu.allCases)
        .environmentObject(ManagingServicesViewModel())
        .environmentObject(AppointmentVM(numberOfServices: 7))
}

struct BlankView : View {

    var bgColor: Color

    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(bgColor)
        .edgesIgnoringSafeArea(.all)
    }
}

struct NoDataView: View {
    var body: some View {
        Image("welcome")
            .resizable()
            .scaledToFit()
    }
}

