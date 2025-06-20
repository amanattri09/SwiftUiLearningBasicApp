//
//  LoginView.swift
//  FirebaseSwiftUIExample
//
//  Created by Aman Attri on 17/03/25.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var isValidEmail = false
    @State private var isPasswordValid = false
    @State private var errorMessage = ""
    @State private var selection  : String? = nil
    @State private var isLoading   = false
    @State private var showRegisterUserAlert  = false
    
    let NAV_DASHBOARD = "dashboard"
    let NAV_REGISTER = "register"
    let NAV_FORGOT_PASSWORD = "forgot_password"
    
    
    var body: some View {
        //varibles
        let isFormValid = isValidEmail && isPasswordValid
        
        NavigationView {
            
            VStack(alignment : .leading) {
                NavigationLink(destination: DashbaordView(), tag: NAV_DASHBOARD , selection: $selection){
                    EmptyView()
                }
                
                NavigationLink(destination: RegisterView(), tag: NAV_REGISTER , selection: $selection){
                    EmptyView()
                }
                NavigationLink(destination: ForgotPassword(), tag: NAV_FORGOT_PASSWORD , selection: $selection){
                    EmptyView()
                }
                VStack {
                    Image("Unlock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
                .frame(maxWidth: .infinity)
                
                //username
                Text("Log in").font(.poppins(fontstyle: .title)).fontWeight(.bold).padding(.top)
                TextField("Email",text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .onChange(of: username){ oldValue , newValue in
                        validateEmail(newValue)
                    }
                    .padding(.top)
                
                // show error message for username
                if errorMessage.count != 0 {
                    Text(errorMessage).foregroundColor(.red).padding(.top,4)
                }
                
                // password
                TextField("Password",text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .onChange(of: password){ oldvalue , newValue in
                        validatePassword(newValue)
                    }
                // forgot password
                Button(action: {
                    selection = NAV_FORGOT_PASSWORD
                }){
                    Text("Forgot Password?")
                }
                .padding(.top)
                
                //show error message for error
                Button(action: {
                    handleLogin()
                }, label: {
                    Text("Login").font(.headline).foregroundColor(.white)
                        .frame( height: 50)
                        .frame(maxWidth: .infinity)
                        .background(isFormValid ? Color.blue : Color.gray)
                        .cornerRadius(10)
                        .padding(.top,24)
                })
                .frame(maxWidth : .infinity)
                .disabled(!isFormValid)
                .padding(.top)
                // loading view for api call
                if isLoading
                {
                    VStack{
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }.frame(maxWidth:  .infinity).padding(.top,8)
                }
                
                Button(action: {
                    selection = NAV_REGISTER
                }){
                    Text("Register")
                }
                .padding(.top)
            }
            .padding()
            .frame(maxHeight: .infinity , alignment: .top )
            .alert("User not registerd", isPresented: $showRegisterUserAlert){
                Button("Register",role: .cancel) {
                    selection = NAV_REGISTER
                }
                Button("Dismiss",role:.destructive){
                    showRegisterUserAlert = false
                }
            } message: {
                Text("Would you like to register user?")
            }
        }
    }
    
    func handleLogin(){
        isLoading = true
        Auth.auth().signIn(withEmail: username,password: password) { result , error in
            if let error = error as NSError? {
                errorMessage = error.localizedDescription
                if error.domain == AuthErrorDomain {
                    if (AuthErrorCode(rawValue: error.code) == .userNotFound) {
                        showRegisterUserAlert = true
                    }
                }
            } else {
                errorMessage = ""
                selection = NAV_DASHBOARD
            }
            isLoading = false
        }
    }
    
    func validateEmail(_ email : String){
        let validator = EmailValidator()
        if validator.isValidEmail(email) {
            isValidEmail = true
            errorMessage = ""
        } else {
            isValidEmail = false
            errorMessage = "Invalid email format"
        }
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
