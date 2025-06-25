//
//  PostDetail.swift
//  FirebaseSwiftUIExample
//
//  Created by Aman Attri on 24/06/25.
//

import SwiftUI


struct PostDetail: View {
    
    let item : PostModal
    @StateObject private var postDetailViewModal = PostDetailViewModel()
    
    var body: some View {
        VStack(alignment : .leading) {
            if postDetailViewModal.isLoading {
                ProgressView()
            } else if let post = postDetailViewModal.post {
                Text("id : \(post.id) , title : \(post.title)")
            } else if let error = postDetailViewModal.errorMessage {
                Text("error is \(error)").foregroundColor(Color.red)
            }
            Spacer()
        }
        .navigationTitle(item.title)
        .frame(maxHeight: .infinity)
        .padding()
        .onAppear{
            postDetailViewModal.getPostDetail(id: String(item.id))
        }
    }
}

#Preview {
    PostDetail(item: PostModal(id: 3, title: "Good morning", body: "Post body"))
}
