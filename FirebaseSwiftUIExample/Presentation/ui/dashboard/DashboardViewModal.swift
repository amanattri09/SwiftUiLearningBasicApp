//
//  DashboardViewModal.swift
//  FirebaseSwiftUIExample
//
//  Created by Aman Attri on 23/06/25.
//

import Foundation
import Combine

class DashboardViewModal : ObservableObject {
    @Published var posts : [PostModal] = []
    @Published var isLoading = false
    @Published var errorMessage : String?
    private let postRepositary : PostRepositary
    private var cancellables = Set<AnyCancellable>()
    
    init(postRepositary : PostRepositary = PostRepositaryImp()){
        self.postRepositary = postRepositary
    }
    // very default way of consuming api
//    func fetchPosts() {
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
//        isLoading = true
//        errorMessage = nil
//        URLSession.shared.dataTask(with: url) { data , response , error in
//            DispatchQueue.main.async {
//                self.isLoading = false
//                if let error = error {
//                    self.errorMessage = error.localizedDescription
//                    return
//                }
//                guard let data = data else  {
//                    self.errorMessage = "No data received"
//                    return
//                }
//                do {
//                    let posts = try JSONDecoder().decode([PostModal].self, from: data)
//                    self.posts = posts
//                } catch {
//                    self.errorMessage = "failed to decode response"
//                }
//            }
//        }.resume()
//    }
    
    func fetchPostsV2() {
        isLoading = true
        postRepositary.getAllPosts().sink(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }, receiveValue: { posts in
            self.posts = posts
            self.isLoading = false
        })
        .store(in: &cancellables)
    }
}
