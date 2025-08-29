//
//  UserProfille.swift
//  FirebaseSwiftUIExample
//
//  Created by Aman Attri on 24/06/25.
//

import SwiftUI
import PhotosUI

struct UserProfille: View {
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var showPhotoPicker = false
    @State private var selectedImage : UIImage? = nil
    @State private var showImagePickerAlert : Bool = false
    @State private var showCamera : Bool = false
    
    var body: some View {
        VStack (){
            ZStack(alignment: .bottomTrailing){
                if let image = selectedImage {
                    Image(uiImage: image).resizable()
                        .scaledToFit()
                        .frame(width:400,height: 400)
                }else{
                    Image("avatar").resizable().frame(width:400,height: 400)
                }
                Image("edit_profile")
                    .resizable()
                    .frame(width: 48,height: 48)
                    .padding()
                    .onTapGesture {
                        showImagePickerAlert = true
                    }
            }
            Spacer()
        }
        .navigationTitle("User Profile")
        .padding(.top)
        .photosPicker(isPresented: $showPhotoPicker, selection: $selectedItem)
        .onChange(of: selectedItem){ oldItem , newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                }
            }
        }
        .confirmationDialog("Choose an Option", isPresented: $showImagePickerAlert, titleVisibility: .visible) {
            Button("Pick image from gallery") {
                showPhotoPicker = true
            }
            Button("Take photo from Camera") {
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    showCamera = true
                }else {
                    showPhotoPicker = true
                }
            }
        }
        .sheet(isPresented: $showCamera, content: {
            ImagePickerCustom(sourceType: .camera, selectedImage: $selectedImage)
        })
        
    }
}

#Preview {
    UserProfille()
}
