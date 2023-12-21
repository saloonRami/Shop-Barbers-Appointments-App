//
//  TeamSizeView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 04/11/2023.
//

import SwiftUI
struct TeamSizeModel:Identifiable{
    var id = UUID()
    var name:String
}
struct TeamSizeView: View {

  private let teamSize = [
        TeamSizeModel(name:"It's justme"),
        TeamSizeModel(name:"2-5 people"),
        TeamSizeModel(name:"8-9 people"),
        TeamSizeModel(name:"10+ people")
    ]

    @State private var selected : Set<String> = []

    var body: some View {

        VStack(alignment: .leading,spacing: 16) {

            VStack(alignment: .leading,spacing: 12){
                Text("What's your team size?")
                    .font(.title2)
                    .bold()
                Text("This will help us set up your calendar correctly. Don't worry, this doesn't change the price - you can have unlimited team members for free on App!.")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray.opacity(0.9))
            }.padding([.bottom],16)

//            List(teamSize, selection: $selected){ size in
            VStack(alignment:.leading,spacing: 24){

                ForEach(teamSize) { size in
                    TeamSizeRow(sizeName: size.name, selected: $selected)
                }
            }.padding(.horizontal)
                .foregroundColor(.black)
            Spacer()
            Text(selected.first?.description ?? "")
        }.padding()
    }
    private func GetRangeTeam(){

    }
}

#Preview {
    TeamSizeView()
}

struct TeamSizeRow: View {

     var sizeName: String
    @Binding var selected: Set<String>

    var body: some View {

        Button(action: {
            if !selected.isEmpty {
                selected.removeAll()
            }
            if !selected.insert(sizeName).inserted {
                selected.remove(sizeName)
            }
        }, label: {
            HStack(alignment: .center,spacing: 16) {

                Circle()
                    .stroke(lineWidth: 2.0)
                    .frame(width: 16,height: 24)
                    .foregroundColor(.green)
                    .overlay(
                        Circle()
                            .fill()
                            .scaleEffect(CGSize(width: 0.65, height: 0.65))
                            .foregroundColor(selected.contains(sizeName) ?  Color.green: Color.white)
                    )
                Text(sizeName)
                    .fontWeight(.bold)
            }
        })
    }
}
