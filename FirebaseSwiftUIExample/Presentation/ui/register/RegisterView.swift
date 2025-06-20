//
//  RegisterView.swift
//  FirebaseSwiftUIExample
//
//  Created by Aman Attri on 10/04/25.
//

import SwiftUI
import AVFoundation
import FirebaseAuth

struct RegisterView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var isValidEmailAddress = false
    @State private var isPasswordValid = false
    @State private var errorMessage = ""
    @State private var selection : String? = nil
    @State private var cameraAuthorized = false
    @State private var showAlert = false
    @State private var isFormValid = false
    @State private var isLoading = false
    @State private var isUserRegistered = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        //variables
        let isFormValid = isValidEmailAddress && isPasswordValid
        NavigationView{
            VStack(alignment: .leading){
                VStack{
                    Image("Unlock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }.frame(maxWidth: .infinity)
                // username
                Text("Register").font(.poppins(fontstyle: .title)).fontWeight(.bold).padding(.top)
                TextField("Email", text: $email).textFieldStyle(RoundedBorderTextFieldStyle()).autocapitalization(.none).keyboardType(.emailAddress)
                    .onChange(of: email) { oldValue , newValue in
                        isValidEmailAddress = validateEmail(newValue)
                    }
                TextField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle()).autocapitalization(.none).keyboardType(.emailAddress)
                    .padding(.top)
                    .onChange(of: password){ oldValue , newValue in
                        isPasswordValid = newValue.count > 5
                    }
                if errorMessage.count > 0 {
                    Text(errorMessage).foregroundColor(Color.red)
                }
                Button(action: {
                    registerUser()
                }, label: {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isFormValid ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top,24)
                })
                .disabled(!isFormValid)
                .padding(.top)
                .frame(maxWidth: .infinity)
                if isLoading {
                    VStack{
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }.frame(maxWidth:  .infinity).padding(.top,8)
                }
            }.padding().frame(maxHeight: .infinity,alignment: .top)
        }
        .alert("User Registered Successfully", isPresented: $isUserRegistered){
            Button("Login now", action: {
                dismiss()
            })
        } message: {
            Text("User has been registered successfully.You can login now")
        }
    }
    
    func registerUser(){
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { result , error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                isUserRegistered = true
            }
            isLoading = false
        }
    }
}

#Preview {
    RegisterView()
}
