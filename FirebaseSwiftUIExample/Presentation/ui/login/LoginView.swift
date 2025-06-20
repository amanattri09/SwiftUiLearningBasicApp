//
//  LoginView.swift
//  FirebaseSwiftUIExample
//
//  Created by Aman Attri on 17/03/25.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var isValidEmail = false
    @State private var isPasswordValid = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(alignment : .leading) {
            //username
            Text("User Name").font(.title).fontWeight(.bold).padding(.top , 50)
            TextField("Enter your password",text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .onChange(of: username){ oldValue , newValue in
                    validateEmail(newValue)
                }
            
            // show error message for username
            if !isValidEmail {
                Text(errorMessage).foregroundColor(.red).padding(.top , 5)
            }
            
            // password
            Text("Password").font(.title).fontWeight(.bold)
            TextField("Enter your password",text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .onChange(of: password){ oldvalue , newValue in
                    
                }
            //show error message for error
            Spacer()
            Button(action: {
                handleLogin()
            }, label: {
                Text("Login").font(.headline).foregroundColor(.white)
                    .frame(width: 200 , height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.top , 20)
            })
            .frame(maxWidth : .infinity)
            .disabled(!isValidEmail || !isPasswordValid)
        }
        .padding()
    }
    
    func handleLogin(){
        
    }
    
    func validateEmail(_ email : String){
//        if isValidEmail(email) {
//            isValidEmail = true
//            errorMessage = ""
//        } else {
//            isValidEmail = false
//            errorMessage = "Invalid email format"
//        }
        isValidEmail = true
    }
    
    func validatePassword(_ password : String) {
        if password.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
            isPasswordValid = true
        }else {
            isPasswordValid = false
        }
    }
    
}

#Preview {
    LoginView()
}
