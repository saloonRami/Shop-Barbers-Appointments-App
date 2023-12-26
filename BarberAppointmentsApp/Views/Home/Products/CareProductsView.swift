//
//  CareProductsView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/09/2023.
//

import SwiftUI
import CoreData

struct CareProductsView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StoreProducts.namePro, ascending: true)],
        animation: .default)
    private var items: FetchedResults<StoreProducts>
    @EnvironmentObject var DataModel : ModelData

    @AppStorage("appearances") var appearance: Appearance = .automatic

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                MenuBar(tilte: .constant("Personal Finance")) {
//                    AddProductsView(keyboardHandler: KeyboardFollower())
                    AddHairProductsView()
                        .environment(\.managedObjectContext, self.viewContext)
                        .preferredColorScheme(appearance.getColorScheme())
                }
                .listRowInsets(EdgeInsets())

                ForEach(DataModel.categories.keys.sorted(),id:\.self) { key in
                    ProductsCareRow(ProductsName: key, items: DataModel.categories[key]!)
                }
                .onDelete(perform: deleteItems)
            }
//            .scrollDisabled(false)
        }
    }
    private func addItem() {
        withAnimation {
            let newItem = StoreProducts(context: viewContext)
            let random = Int.random(in: 0...100)
            newItem.namePro = "Products\(random)"

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct CareProductsView_Previews: PreviewProvider {
    static var previews: some View {
        CareProductsView()
            .environmentObject(ModelData())
            .environmentObject(SettingStore())
    }
}


struct MenuBar<Content>: View where Content: View {
    @State private var showPaymentForm = false
    @Binding var tilte:String
    let modalContent: () -> Content

    var body: some View {
        ZStack(alignment: .trailing) {
            HStack(alignment: .center) {
                Spacer()

                VStack(alignment: .center) {
                    Text(Date.today.string(with: "EEEE, MMM d, yyyy"))
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(tilte)
                        .font(.title)
                        .fontWeight(.black)
                }

                Spacer()
            }

            Button(action: {
                self.showPaymentForm = true
            }) {
                Image(systemName: "plus.circle")
                    .font(.title)
                    .foregroundColor(.primary)
            }
            .padding()
            .fullScreenCover(isPresented: self.$showPaymentForm, onDismiss: {
                self.showPaymentForm = false
            }) {
                self.modalContent()
            }
//            .sheet(isPresented: self.$showPaymentForm, onDismiss: {
//                self.showPaymentForm = false
//            }) {
//                self.modalContent()
//            }
        }
        .background(.red)

    }
}
