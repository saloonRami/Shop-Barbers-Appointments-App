//
//  AddHairProductsView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 05/09/2023.
//

import SwiftUI

struct AddHairProductsView: View {

    @State var NameBrand : String = ""
    @State var InfoPoducts : String = ""
    @State var Price : String = ""
    @State var quantity : String = ""
    @State private var maxPriceLevel = 1000
    @State private var showCheckInOnly = false
    @State private var selectedProducts = ProductsAvailableModel.Shampoo

    @State private var image = UIImage()
    @State private var showSheet = false

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var settingStore: SettingStore
    
    var body: some View {

        NavigationView{
            Form {
                Section(header: Text("Select Profucts")) {

                    Picker(selection: $selectedProducts,label:  Text("Display order")
                        .foregroundColor(.blue)
                    ) {
                        ForEach(ProductsAvailableModel.allCases,id: \.self) { productsType in
                            Text(productsType.text)
                        }
                    }
                }

                Section(header: Text("Brand")) {
                    ProductsTextFeildView(TextFeildValue: $NameBrand, Name: "Brand Name", keyboardEn: .defaults)

                    ProductsTextFeildView(TextFeildValue: $InfoPoducts, Name: "Info Name", keyboardEn: .defaults)
                }
                Section(header: Text("Price and Quantity")) {
                    HStack{
                        VStack{
                            Text("Price")
                                .font(.title3)
                                .bold()
                            ProductsTextFeildView(TextFeildValue: $Price, Name: "The Price Is The JD", keyboardEn: .price)
                        }
                        .padding()
                        VStack{
                            Text("Quantity")
                                .font(.title3)
                                .bold()
                            ProductsTextFeildView(TextFeildValue: $quantity, Name: "Quantity", keyboardEn: .quantaity)
                        }
                        .padding()
                    }
                }
                Section(header: Text("Take Photos For Products")) {
                    SelectPhotosView()
                    HStack{
                        Text("Change photo")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.262745098, green: 0.0862745098, blue: 0.8588235294, alpha: 1)), Color(#colorLiteral(red: 0.5647058824, green: 0.462745098, blue: 0.9058823529, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(16)
                            .foregroundColor(.white)
                            .onTapGesture {
                                showSheet = true
                            }

                        Image(uiImage: self.image)
                            .resizable()
                            .cornerRadius(50)
                            .padding(.all, 4)
                            .frame(width: 100, height: 100)
                            .background(Color.black.opacity(0.2))
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .padding(8)
                    }
                    .sheet(isPresented: $showSheet) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                    }
                }

                Section(header: Text("Quantity")) {
                    Toggle(isOn: self.$showCheckInOnly) {
                        Text("Show Check-in Only")
                    }
                    Stepper(onIncrement: {
                        self.maxPriceLevel += 1
                        if self.maxPriceLevel > 5 {
                            self.maxPriceLevel = 5
                        }
                    }, onDecrement: {
                        self.maxPriceLevel -= 1
                        if self.maxPriceLevel < 1 {
                            self.maxPriceLevel = 1
                        }  }) {
                            Text("Quantity \(maxPriceLevel) Product") }
                }
            }
            .navigationTitle("Settings")
            .navigationBarItems(trailing:
                                    Button(action: {
                self.settingStore.showCheckInOnly = self.showCheckInOnly
                self.settingStore.displayOrder = self.selectedProducts
                self.settingStore.maxPriceLevel = self.maxPriceLevel
                self.presentationMode.wrappedValue.dismiss()

            }, label: {
                Text("Save")
                    .foregroundColor(.black)
                    .padding()
            }) )
            .onAppear {

                self.selectedProducts = self.settingStore.displayOrder
                self.showCheckInOnly = self.settingStore.showCheckInOnly
                self.maxPriceLevel = self.settingStore.maxPriceLevel
            }
        }
    }
}

struct AddHairProductsView_Previews: PreviewProvider {
    static var previews: some View {
        AddHairProductsView()
            .environmentObject(SettingStore())
    }
}




struct HeaderView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text("Add a new product")
                .font(.system(.largeTitle, design: .rounded))
            //                        .lineLimit(0)
                .fontWeight(.black)
            Spacer()

            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "multiply")
                    .font(.title)
                    .foregroundColor(.primary)
                    .padding()
            }
        }
        .padding(.top)
    }
}

