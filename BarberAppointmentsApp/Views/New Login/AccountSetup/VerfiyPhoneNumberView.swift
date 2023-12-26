//
//  VerfiyPhoneNumberView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 21/09/2023.
//

import SwiftUI

struct VerfiyPhoneNumberView: View {

    @State var PhoneNumber : String = ""
    @State var IsVerfiyPhoneNumber: Bool = false

    @EnvironmentObject  var VerfiyPhoneVM  : VerifyPhoneViewModel
    @ObservedObject private var userRegistrationViewModel = UserRegistrationViewModel()

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var additionsTitle: String?
    var isBackButton : Bool = true
    var body: some View {

        NavigationStack{
            VStack {

                VStack{
                    Text("Enter Phone" + " " + "\(additionsTitle ?? " ")"  + "Number")
                        .font(.title3)
                        .bold()
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .padding(.leading)
                        .padding(.bottom,4)
                    Text("Enter your number to create a new account or log in")
                        .font(.caption)
                        .bold()
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .padding(.leading)
                        .padding(.bottom,4)
                }
                .padding()

                VStack{
                    PhoneNumberView(PhoneNumber: self.$VerfiyPhoneVM.PhoneNumber, Name: .constant("Phone Number"), keyboardEn: .defaults)

                    RequirementTextView(iconName: "lock",iconColor:  Color(red: 251/255, green: 128/255, blue: 128/255),text: "It must contain 9 numbers", textSecandary: "Add your phone number without the first zero", isStrikeThrough: self.VerfiyPhoneVM.IsVerfiyPhoneNumber,textThrough:self.VerfiyPhoneVM.IsFirstIndexPhoneZero)
                        .padding(.horizontal)
                }

                VStack{

                    Button(action: {
                        self.VerfiyPhoneVM.VerifyPhoneNumber()

                        self.IsVerfiyPhoneNumber.toggle()

                    }) {
                        Text("Send the code via SMS")

                            .font(.system(size: 16,weight: .black))
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 280,height: 64)
                            .lineLimit(1)
                            .multilineTextAlignment(.center)
                            .background(Color.darkGreen)
                            .cornerRadius(16)
                            .cornerRadius(16, corners: .allCorners)
                            .padding(.bottom,44)
                            .shadow(color: .white,radius: 5)
                    }
                    .sheet(isPresented: self.$IsVerfiyPhoneNumber, content: {
                        VerfiyCodePhoneView()
                        //                        .environmentObject(ShopBarberViewModel())

                    })
                    .padding()
                }
                .onAppear(){
                    VerfiyPhoneVM.LoginProvider(password: self.VerfiyPhoneVM.password)
                }
                .offset(y:250)
            }

                .navigationBarItems(leading:

                    Button(action: {
//                     self.settingStore.showCheckInOnly = self.showCheckInOnly
//                     self.settingStore.displayOrder = self.selectedProducts
//                     self.settingStore.maxPriceLevel = self.maxPriceLevel
                        self.presentationMode.wrappedValue.dismiss()

                }, label: {
                    if isBackButton{
                        Image(systemName: "chevron.backward.circle.fill")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                            .scaledToFill()
                            .padding([.top, .leading, .bottom])

                    }}) )

        }
    }
}

struct VerfiyPhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        VerfiyPhoneNumberView()
            .environmentObject(VerifyPhoneViewModel())
    }
}

//extension View {
//  // Mojtaba Hosseini
//  // stackoverflow.com/questions/56760335/round-specific-corners-swiftui
//  /// Round specified corners
//  func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
//    clipShape( RoundedCorner(radius: radius, corners: corners) )
//  }
//}

//struct RoundedCorner: Shape {
//  var radius: CGFloat = .infinity
//    var corners: UIRectCorner = .allCorners
//
//  func path(in rect: CGRect) -> Path {
//    let path = UIBezierPath(
//      roundedRect: rect,
//      byRoundingCorners: corners,
//      cornerRadii: CGSize(width: radius, height: radius)
//    )
//    return Path(path.cgPath)
//  }
//}
