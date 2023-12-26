//
//  AddProductsView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/09/2023.
//

import SwiftUI

struct AddProductsView: View {

    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var addProductsViewModel =  AddProductsViewModel()
    @ObservedObject var keyboardHandler : KeyboardFollower

    init(keyboardHandler:KeyboardFollower) {
        self.addProductsViewModel = AddProductsViewModel()
        self.keyboardHandler = keyboardHandler
    }
    var body: some View {
        
        VStack(spacing: 0) {
            ScrollView{
                // Title bar
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
                .padding()
                Group{
                    if !addProductsViewModel.IsnameProducts{
                        ValidationErrorText(text: "Please enter the Products Name")
                    }
                    if !addProductsViewModel.IspriceProducts {
                        ValidationErrorText(text: "Please enter a valid Price")
                    }
                    if !addProductsViewModel.ISquantaity {
                        ValidationErrorText(text: "Add Quantiaty Products")
                    }
                    //                    if !addProductsViewModel.ISimageProducts {
                    //                        ValidationErrorText(text: "add Image To Products")
                    //                    }
                }
                .padding(8)
                
                //                VStack{
                TextFieldView(fieldName: "Name Products", fieldValue: $addProductsViewModel.nameProducts, keyboardEn: .userName,isCenterText:true)
                //                        .padding()
                
                TextFieldView(fieldName: "Name Brand", fieldValue: $addProductsViewModel.nameBrand, keyboardEn: .userName,isCenterText:true)
                //                        .padding()
                // Date and Amount
                HStack {
                    DateAndTimeView(value: $addProductsViewModel.date, name: "Date", isTime: .constant(false))
                    //                            .padding(.top)
                    TextFieldView(fieldName:"Price / JD",fieldValue:$addProductsViewModel.priceProducts, keyboardEn: .phoneNum)
                    //                            .padding(.top)
                    TextFieldView(fieldName:"Quantaty",fieldValue:$addProductsViewModel.quantaity, keyboardEn: .phoneNum)
                    //                            .padding(.top)
                }
                // Memo
                TextFieldView(fieldName: "Memo (Optional)",fieldValue:$addProductsViewModel.info, keyboardEn: .userName,isCenterText:true)
                    .padding()
                
                // Save button
                Button(action: {
                    self.save()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .opacity(addProductsViewModel.isFormInputValid ? 1.0 : 0.5)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color("IncomeCard"))
                        .cornerRadius(10)
                    
                }
                .padding()
                .disabled(!addProductsViewModel.isFormInputValid)
                //                }
                .padding(.top)
            }
            .padding(.horizontal)
        }
    }
    // Save the record using Core Data
    private func save() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddProductsView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductsView(keyboardHandler: KeyboardFollower())
           
    }
}
struct ValidationErrorText: View {

    var iconName = "info.circle"
    var iconColor = Color(red: 251/255, green: 128/255, blue: 128/255)

    var text = ""

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(iconColor)
            Text(text)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.secondary)

            Spacer()
        }
    }
}
