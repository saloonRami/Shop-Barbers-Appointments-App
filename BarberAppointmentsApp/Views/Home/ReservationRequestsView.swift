//
//  ReservationRequestsView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/09/2023.
//

import SwiftUI

struct ReservationRequestsView: View {
    @AppStorage("appearances") var appearance: Appearance = .automatic
    @State var  aa = ["Reservation Requests","Reservation","Requests"]
    let image: UIImage
    @Binding var isShowContent: Bool
   
    var body: some View {
        NavigationStack{
            List{
                ForEach(aa.indices,id: \.self) { index in
                    
                    NavigationLink(destination: {}) {
                        ReservationViewCell(aa:$aa[index], isShowContent: $isShowContent)
                    }
                }
            }
            .onAppear(){
//             let _ = ManageAPI.GetCurrentShopOwner()
            }
            .background()
        }
    }

}

struct ReservationRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationRequestsView(image: UIImage(systemName: "person.circle.fill")!, isShowContent: .constant(true))
    }
}

struct ReservationViewCell: View {
    @Binding var aa : String
    @Binding var isShowContent: Bool
    var body: some View {
        HStack{
            Image(systemName:"person.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 24, height: 24)
                .border(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), width: self.isShowContent ? 0 : 1)
                .cornerRadius(15)
                .padding()
            Text(aa)
                .fontWeight(.bold)
                .fontWeight(.heavy)
                .padding()
        }
    }
}
