//
//  AddTeamMemberView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 12/11/2023.
//

import SwiftUI

struct ProfileTeamMemberView: View {
    @State private var firstnameValue = ""
    @State private var lastnameValue = ""
    @State private var emailValue = ""
    @State private var phoneValue = ""
    @State private var JobValue = ""
    @State private var colors = UIColor.black
    @State private var startDate = ""
    @State private var endDate = ""
    @State private var noteValue = ""
    @State private var selectedColor : Color = .accentColor
    @StateObject private var teamsMembersViewModel = TeamsMembersViewModel()

    let SelectColor: [UIColor] = [.blue,.tintColor,.green,.red,.purple,.yellow,.brown,.black,.darkGray,.gray,.label,.link,.orange,.magenta,.placeholderText,.quaternaryLabel,.systemBlue,.systemFill,.systemBackground
    ]
    var body: some View {

        // Add Photots Profile
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading,spacing: 10.0){
                    Text("Manage your team members personal profile")
                        .bold()
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity,maxHeight: 44)
                        .padding([.top,.bottom],4)

                    //               Image(systemName: "photo.badge.plus.fill")
                    Image(systemName: "camera.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100,height: 100)
                        .padding()
                }

                // First and Last Name Text Field
                HStack(alignment: .center,spacing: 16) {

                    VStack(alignment: .leading){

                        Text("First Name *")
                            .font(.headline)
                            .bold()

                        TextField("", text: $firstnameValue)
                            .frame(maxWidth: .infinity,maxHeight: 16)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(lineWidth: 1)
                            )
                    }

                    Spacer()

                    VStack(alignment: .leading){
                        Text("Last Name *")
                            .font(.headline)
                            .bold()

                        TextField("", text: $lastnameValue)
                            .frame(maxWidth: .infinity,maxHeight: 16)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(lineWidth: 1)
                            )
                    }

                }

                // Email Text Field
                VStack(alignment: .leading){
                    Text("Email *")
                        .font(.headline)
                        .bold()

                    TextField("Enter Your Email", text: $emailValue)
                        .font(.headline)
                        .frame(maxWidth: .infinity,maxHeight: 16)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(lineWidth: 1)
                        )
//                        .onChange(of: emailValue, {
//                            self.teamsMembersViewModel.email = emailValue
//                            self.teamsMembersViewModel.SendEmailLinkToBarber()
//                        })
                }
                // Phone Text Field
                VStack(alignment: .leading){

                    Text("Phone ")
                        .font(.headline)
                        .bold()


                    HStack {
                        Text("962")
                            .frame(maxWidth: 64,maxHeight: 16)
                            .padding()
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.center)
                            .background(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(lineWidth: 1)
                            )
                            .padding(.trailing,-11)


                        TextField("Phonr", text: $emailValue)
                            .frame(maxWidth: .infinity,maxHeight: 16)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(lineWidth: 1)
                            )
                    }
                }
                Spacer()

                // Colors
                VStack{
                    Spacer()
                    ColorPickerView(selectedColor: $selectedColor)
                        .font(.system(size: 24,weight: .black))

                }.padding([.top,.bottom],8)

                Divider()
                    .frame(maxWidth: .infinity,maxHeight: 10)
                    .background(.black)
                    .padding()

                // Email Text Field
                VStack(alignment: .leading){
                    Text("Job title ")
                        .font(.headline)
                        .bold()

                    TextField("", text: $emailValue)
                        .font(.headline)
                        .frame(maxWidth: .infinity,maxHeight: 16)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(lineWidth: 1)
                        )

                    Text("visabile to client online ")
                        .font(.caption2)
                        .foregroundColor(.gray.opacity(0.8))
                        .bold()
                        .padding([.leading,.top],4)
                }


                Divider()
                    .frame(maxWidth: .infinity,maxHeight: 10)
                    .background(.black)
                    .padding()


                VStack(alignment: .leading,spacing: 10){
                    Text("Employment details")
                        .font(.title2)
                        .bold()
                        .padding([.leading,.bottom],4)

                    Text("Manage your team members start date, and employment details")
                        .font(.headline)
                        .foregroundColor(.gray.opacity(0.8))
                        .bold()
                        .padding([.top,.bottom],8)
                }

                // note Text Field

                VStack(alignment: .leading){

                    Text("Notes ")
                        .font(.headline)
                        .bold()

                    TextField("Add a private note only viewable from your team members", text: $emailValue,axis: .vertical)
                        .font(.headline)
                        .frame(maxWidth: .infinity,minHeight: 75.0,maxHeight: .infinity)
                        .lineLimit(5)
                        .multilineTextAlignment(.leading)

                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(lineWidth: 1)
                        )
                }
            }
        }
        .padding(.horizontal)

        .navigationTitle( Text("Profile"))
        .navigationBarItems(leading:
            Button("Share app") {
            teamsMembersViewModel.shareButtonWasTapped()
            self.teamsMembersViewModel.email = emailValue
            self.teamsMembersViewModel.SendEmailLinkToBarber()
        }
            .sheet(isPresented: $teamsMembersViewModel.isSharePresented, onDismiss: {
                       print("Dismiss")
                   }, content: {
                       let promoText = "Check out this great recipe for\("self.recipe?.title") I found on Recipe Rally!"
//                       ActivityViewController(activityItems: [promoText,teamsMembersViewModel.url_domain!])
                       TeamAcceptEmailLinkView(email: emailValue)
                   }))
//        Button(action: {
//            teamsMembersViewModel.shareButtonWasTapped()
//        }, label: {
//            Text("Share")
//        }))
    }
}

#Preview {

    NavigationStack {
        ProfileTeamMemberView()
    }
}

import SwiftUI

struct ColorPickerView: View {

    let colors: [Color] = [.red, .accentColor, .green, .gray, .yellow, .black, .blue, .purple, .brown, .pink]

    @Binding var selectedColor: Color

    var body: some View {

        HStack{
            ForEach(colors,id: \.self) { color in
                Image(systemName: selectedColor == color ? Constants.Icons.recordCircleFill: Constants.Icons.circleFill)
                .foregroundColor(color)
                .clipShape(Circle())

                .onTapGesture {
                    print(color)
                    selectedColor = color
                }
            }
        }
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView( selectedColor:.constant (.gray))
            .environmentObject(TeamsMembersViewModel())
    }
}
