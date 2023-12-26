//
//  SelectPhotosView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 05/09/2023.
//

import SwiftUI

struct SelectPhotosView: View {
    @State  private var photoSet = samplePhotos

    @State private var selectedPhotos: [Photo] = []
    @State private var selectedPhotoId: UUID?
    @Namespace private var photoTransition

    @State private var image = UIImage()
    @State private var imageArray = [UIImage()]
    @State private var showSheet = false


    var body: some View {
        VStack(alignment: .center){
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 72,height: 72)
                .clipShape(Circle())
                .foregroundColor(.darkBlue)
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
                .overlay(
                    Button(action: {
                        print("Select Photos")
                        self.showSheet = true
                    }, label: {
                        Text("")
                    })
                )
                .shadow(radius: 7)

            Text("Select Photos")
                .lineLimit(1)
                .font(.system(.title,weight: .heavy))
                .bold()
                .foregroundColor(.black)
                .padding(.top,4)

            ScrollViewReader { scrollProxy in
                ScrollView(.horizontal,showsIndicators: false) {
                    LazyHGrid(rows: [GridItem()]) {
                        ForEach(photoSet) { photo in
                            Image(photo.name)
                                .resizable()
                                .scaledToFill()
                                .frame(minWidth: 0,maxWidth: 200)
                                .frame(height: 100)
//                                .cornerRadius(3.0)
                                .clipShape(Circle())
                                .overlay {
                                    Circle().stroke(.gray, lineWidth: 1)
                                }
                                .matchedGeometryEffect(id: photo.id, in: photoTransition)
                                .onTapGesture {
                                    selectedPhotos.append(photo)
                                    selectedPhotoId = photo.id
                                    if let index = photoSet.firstIndex(where: { $0.id == photo.id }) {
                                        photoSet.remove(at: index)
                                    }
                                }
                                .padding()
                        }
                    }
                }
                .frame(height: !selectedPhotos.isEmpty ? 0 : 100 )
                .padding()
                .background(!selectedPhotos.isEmpty ? .clear: Color(.systemGray6.withAlphaComponent(0.4)))
                .cornerRadius(5)
            }
        }
        .sheet(isPresented: $showSheet, content: {
            ImagePicker(sourceType: .photoLibrary,selectedImage: self.$image)

        })
        .onAppear(){
            self.imageArray.append(self.image)
        }
        .animation(.interactiveSpring())
    }
}

struct SelectPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPhotosView()
    }
}

struct Photo:Identifiable{
var id = UUID()
var name: String
}
let samplePhotos = (1...5).compactMap { Photo(name: "\($0)") }

