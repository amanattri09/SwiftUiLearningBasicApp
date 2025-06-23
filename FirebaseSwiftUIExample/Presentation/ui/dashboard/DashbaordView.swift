//
//  DashbaordView.swift
//  FirebaseSwiftUIExample
//
//  Created by Aman Attri on 10/04/25.
//

import SwiftUI

struct DashbaordView: View {
    
    @StateObject private var viewModal  = DashboardViewModal()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModal.isLoading{
                    ProgressView("Loading...")
                } else if let error = viewModal.errorMessage {
                    Text("Error: \("eror is ")").foregroundColor(.red)
                } else {
                    List(viewModal.posts) { post in
                        VStack (alignment: .leading) {
                            Text(post.title).font(.headline)
                        }
                        .padding(.bottom , 4)
                    }
                    .listRowInsets(EdgeInsets())
                }
            }
        }
        .navigationTitle("Posts")
        .onAppear {
            viewModal.fetchPosts()
        }
    }
}

#Preview {
    DashbaordView()
}
