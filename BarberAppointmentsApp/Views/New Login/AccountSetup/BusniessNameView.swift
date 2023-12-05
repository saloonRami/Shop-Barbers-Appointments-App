//
//  BusniessNameView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/11/2023.
//

import SwiftUI

struct BusniessNameView: View {

    @State private var textName: [String] = ["Business name","Website (Optional)"]

    @State private var emailText: [String] = Array(repeating: "", count: 2)
//    @State var IsEmptyData: Bool

    var  OnEmailCount : (Int) -> ()

    var body: some View {


        VStack{

            VStack(alignment: .leading,spacing: 10) {
                Text("What's your business name?")
                    .font(.title2)
                    .bold()

                Text("This is the brand name your clients will see. Your billing and legal name can be added later.")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray.opacity(0.9))
            }
            VStack{
                ForEach(self.textName.indices,id: \.self) { index in
                    CreateTextFeildCell(text: $textName[index], textValue: $emailText[index])
//                        .onReceive(emailText.publisher, perform: { dataValue in
//                            OnEmailCount(dataValue.description.count)
//                        })
                        .onChange(of: emailText[index], { error, text in
                            OnEmailCount(text.count)
                            print(error.count,text.count)
                        })
                        .padding([.top],8)

                }
            }.padding(.top,16)
            Spacer()
        }.padding()
    }
}

#Preview {
    BusniessNameView(OnEmailCount: {_ in } )
}
