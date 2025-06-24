//
//  DashbaordView.swift
//  FirebaseSwiftUIExample
//
//  Created by Aman Attri on 10/04/25.
//

import SwiftUI

struct DashbaordView: View {
    
    @StateObject private var viewModal  = DashboardViewModal()
    @StateObject private var locationManager = LocationManager()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModal.isLoading{
                    ProgressView("Loading...")
                } else if let error = viewModal.errorMessage {
                    Text("Error: \(error)").foregroundColor(.red)
                } else {
                    if let location = locationManager.location {
                        Text("Lat: \(location.coordinate.latitude), Lon: \(location.coordinate.longitude)")
                    }else {
                        Text("Request location...").background(Color.red)
                        Button("Request Location Access"){
                            locationManager.checkIfLocationServicesIsEnabled()
                        }
                    }
                    if let status = locationManager.authorizationStatus {
                        switch status {
                        case .authorizedWhenInUse, .authorizedAlways:
                            Text("Location Access Granted")
                        case .denied, .restricted:
                            Text("Location Access Denied")
                        case .notDetermined:
                            Text("Waiting for Permission")
                        @unknown default:
                            EmptyView()
                        }
                    }
                    List(viewModal.posts) { post in
                        VStack (alignment: .leading) {
                            NavigationLink(destination: PostDetail(item: post)){
                                Text(post.title).font(.headline)
                            }
                        }
                        .padding(.bottom , 4)
                    }
                    .listRowInsets(EdgeInsets())
                }
            } .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: UserProfille()){
                            Text("User Profile")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Logout") {
                            logoutUser()
                            dismiss()
                        }
                    }
                }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModal.fetchPosts()
        }
    }
    
    func logoutUser(){
        UserDefaults.standard.removeObject(forKey: AppConstants.PrefKeys.KEY_USER_ID)
    }
}

#Preview {
    DashbaordView()
}
