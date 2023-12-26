//
//  CollectionInfoTeamView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 12/11/2023.
//

import SwiftUI

struct CollectionInfoTeamView: View {

    @State private var  teamCollectionsView = AddTeamCollectionsView.allCases
    @Binding var SelectedPageView: Int

    var body: some View {

        ScrollViewReader { proxy in

            ScrollView(.horizontal,showsIndicators: false){
                LazyHGrid(rows: [GridItem(.flexible())],spacing: 12) {
                    ForEach(teamCollectionsView,id: \.self){ service in

                        Text(service.descriptionString)
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(SelectedPageView == service.rawValue ? .white:.black)
                            .padding()
                            .frame(maxWidth: .infinity,maxHeight: 36)
                            .background(
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill()
                                        .foregroundColor(SelectedPageView == service.rawValue ? .blue:.white)

                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 2)
                                        .foregroundColor(SelectedPageView == service.rawValue ? .blue: .blue)
                                }
                            )
                            .shadow(color: .gray, radius: 10)
                            .onTapGesture {
                                withAnimation(.spring) {
                                    if SelectedPageView < service.rawValue {
                                        SelectedPageView = service.rawValue  % 6
                                        proxy.scrollTo(SelectedPageView + 1)
                                    }else{
                                        SelectedPageView = service.rawValue  % 6
                                        proxy.scrollTo(SelectedPageView - 1)
                                    }
                                }
                            }
                            .id(service.rawValue)
                    }
                }
                .padding(.horizontal)
            }
            .frame(minWidth: .zero, idealWidth: .infinity, maxWidth: .infinity, minHeight: 36, idealHeight: 60, maxHeight: 60, alignment: .leading)
            .defaultScrollAnchor(.leading)
            .scrollContentBackground(.visible)
            .background(.clear)
        }
        .scrollClipDisabled(true)

    }
}

#Preview {
    CollectionInfoTeamView(SelectedPageView: .constant(0))
}
