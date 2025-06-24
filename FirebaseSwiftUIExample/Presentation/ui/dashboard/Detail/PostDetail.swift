//
//  PostDetail.swift
//  FirebaseSwiftUIExample
//
//  Created by Aman Attri on 24/06/25.
//

import SwiftUI


struct PostDetail: View {
    
    let item : PostModal
    
    var body: some View {
        VStack(alignment : .leading) {
            Text("id : \(item.id) , title : \(item.title)")
            Spacer()
        }
        .navigationTitle(item.title)
        .frame(maxHeight: .infinity)
        .padding()
    }
}

#Preview {
    PostDetail(item: PostModal(id: 3, title: "Good morning", body: "Post body"))
}
