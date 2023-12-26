//
//  PersonalProfileView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 22/09/2023.
//

import SwiftUI


struct PersonalProfileView: View {

    @Binding  var urlImage : URL?
    @Binding  var name : String
    @Binding  var email : String

    var body: some View {
        VStack{
            AsyncImage(url: urlImage) { image in
                image.resizable()
            } placeholder: {
//                Image(systemName: "person.plus")
//                    .resizable()
//                    .scaledToFit()
//                    .foregroundColor(.gray)
                ProgressView()
            }.frame(width: 124, height: 124, alignment: .center)
                .progressViewStyle(.circular)
                .clipShape(Circle())
                .overlay{
                    Circle().stroke(.white, lineWidth: 4)
                }
                .shadow(radius: 7)
                .padding(.horizontal)


            Text("Edit")
                .font(.subheadline)
                .bold()
                .padding(.bottom,1)
                .padding(.horizontal)

            Text(name)
                .font(.title3)
                .bold()
                .lineLimit(1)
                .multilineTextAlignment(.center)
                .padding(.top,3)
                .padding(.bottom,4)
                .padding(.horizontal)
            Text(email)
                .font(.subheadline)
                .bold()
                .foregroundColor(.gray.opacity(0.7))
                .padding(.bottom,12)
                .padding(.horizontal)
        }
//        .padding(.horizontal)
    }
}


struct PersonalProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalProfileView(urlImage: .constant(URL(string: "")), name: .constant("Name"), email: .constant("rami@yahoo.com"))
    }
}
