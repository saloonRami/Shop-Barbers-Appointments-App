//
//  ServicesShopView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 17/11/2023.
//

import SwiftUI

struct ServicesShopView: View {
    
    @State var ServicesProvider = CategoryServicesProvidesList.allCases
    
    @State private var SelectedPageView: Int = 0
    var body: some View {

        NavigationView {

            ScrollViewReader(content: { proxy in

                VStack(alignment: .leading,spacing: 5.0){
                    ScrollView(.horizontal,showsIndicators: false){
                        LazyHGrid(rows: [GridItem(.flexible())],spacing: 12) {
                            ForEach(ServicesProvider.indices, id: \.self) { count in

                                Text(CategoryServicesProvidesList(rawValue: count)?.CategoryServicesName ?? "")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(SelectedPageView == count ? .white:.black)
                                    .padding()
                                    .frame(maxWidth: .infinity,maxHeight: 36)
                                    .background(
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill()
                                                .foregroundColor(SelectedPageView == count ? .blue:.white)

                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(lineWidth: 2)
                                                .foregroundColor(SelectedPageView == count ? .blue: .blue)
                                        }
                                    )
                                    .shadow(color: .gray, radius: 10)
                                    .onTapGesture {
                                        withAnimation(.spring) {
                                            if SelectedPageView < count {
                                                SelectedPageView = count
                                                proxy.scrollTo(count + 1,anchor: .top)
                                            }else{
                                                SelectedPageView = count
                                                proxy.scrollTo(count - 1)
                                            }
                                        }
                                    }

                                    .id(count)
                            }
                        }
                    }
            }.frame(height: 80)
                .padding()

                VStack(alignment: .leading, spacing: 5.0){
                    List(ServicesProvider.indices,id: \.self){ service in

                        Section {

                            ForEach((CategoryServicesProvidesList(rawValue: service)?.ServicesWithCategory())!,id: \.self){ dataService in
                                Text(dataService.description)

                            }
                            .onAppear {
                                withAnimation {
                                    SelectedPageView = service
                                    proxy.scrollTo(service, anchor: .top) }
                            }
                            .id(service)

                        } header: {
                            VStack {
                                Text(CategoryServicesProvidesList(rawValue: service)?.CategoryServicesName ?? "")
                                    .font(.title2)
                                    .bold()
                                    .multilineTextAlignment(.leading)
                            }
                            .frame(maxWidth: .infinity,maxHeight: 100,alignment: .leading)
                            .padding(.vertical)
                        }

                    }

                }

            })
        }
    }
}

#Preview {
    ServicesShopView()
}
