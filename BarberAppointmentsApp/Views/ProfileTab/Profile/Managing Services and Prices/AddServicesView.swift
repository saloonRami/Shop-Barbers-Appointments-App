//
//  AddServicesView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 19/10/2023.
//

import SwiftUI
import Combine
import Foundation

let allGoals: [Goal] = [Goal(name: "Learn Japanese"), Goal(name: "Learn SwiftUI"), Goal(name: "Learn Serverless with Swift")]

struct AddServicesView: View {
    var subscriptions = Set<AnyCancellable>()
    @State var servicesMenu: ServicesMenu.AllCases
    @Binding var task : TaskServise
    @Binding var arrayString:[String]

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.backward.circle.fill")
                        .font(.system(.title,weight: .bold))
                })
                Spacer()
                Text("Edit Task")
                    .font(.system(.title,weight: .bold))
                Spacer()

                Button(action: {}, label: {
                    Text( "Edit")
                        .font(.system(.headline,weight: .bold))
                })
            }
            .padding()
            List {

                Section(header: Text("Choose the services you want to provide")) {
                    MultiSelector(
                        label: Text("Select Services"),
                        options: servicesMenu,
                        optionToString: { $0.rawValue },
                        selected: $task.servingGoals
                    )
                }
                .onChange(of: task.servingGoals) { newValue in

                    self.arrayString.removeAll()
                    print(self.$task.servingGoals,"New Value \(newValue)")
                    self.arrayString =
                    task.servingGoals.map{ return $0.rawValue}
                }
                ForEach(arrayString,id: \.self){ data in

                    Text(data)
                        .onTapGesture {
                            print(ServicesMenu.init(rawValue: data)?.priceServices ?? "")
                        }
                }
            }
        }
    }
}

#Preview {  
    NavigationView {
        AddServicesView(servicesMenu: ServicesMenu.allCases, task:.constant(TaskServise(name: "", servingGoals: .init(minimumCapacity: 9))), arrayString: .constant([]) )
    }
}

enum ServicesMenu: String,CaseIterable,Identifiable{

//    static var allCases: [ServicesMenu] = []

    var id: String { self.rawValue }

    case hairCut
    case hairColor
    case hairDryer
    case shaving
    case SkinCleaning
    case OutStore
    case bridal


    var NameStringRawValue : String{
        
        switch self{
        case .hairCut: return "Hair Cut"
        case .hairColor: return "Hair Coloring"
        case .hairDryer: return "Hair dryer"
        case .shaving: return "Shaving The Beard"
        case .SkinCleaning: return "Skin cleaning"
        case .OutStore: return "Out-of-store service"
        case .bridal: return "Haircut For Events And Weddings"
        }
    }
    var priceServices:Int16{

        switch self{
        case .hairCut:
            return 5
        case .hairColor:
            return 20
        case .hairDryer:
            return 4
        case .shaving:
            return 3
        case .SkinCleaning:
            return 15
        case .OutStore:
            return 25
        case .bridal:
            return 35
        }
    }

    var TimesServices: Int16{
        switch self{

        case .hairCut:
            return  30
        case .hairColor:
            return 45
        case .hairDryer:
            return 15
        case .shaving:
            return 60
        case .SkinCleaning:
            return 75
        case .OutStore:
            return 60 * 3
        case .bridal:
            return 60 * 4
        }
    }
}

struct Goal: Hashable, Identifiable {
    var name: String
    var id: String { name }
}

struct TaskServise {
    var name: String
    var servingGoals: Set<ServicesMenu>
}


