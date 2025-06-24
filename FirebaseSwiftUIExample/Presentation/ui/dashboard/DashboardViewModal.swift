//
//  DashboardViewModal.swift
//  FirebaseSwiftUIExample
//
//  Created by Aman Attri on 23/06/25.
//

import Foundation

class DashboardViewModal : ObservableObject {
    @Published var posts : [PostModal] = []
    @Published var isLoading = false
    @Published var errorMessage : String?
    
    func fetchPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        isLoading = true
        errorMessage = nil
        URLSession.shared.dataTask(with: url) { data , response , error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                guard let data = data else  {
                    self.errorMessage = "No data received"
                    return
                }
                do {
                    let posts = try JSONDecoder().decode([PostModal].self, from: data)
                    self.posts = posts
                } catch {
                    self.errorMessage = "failed to decode response"
                }
            }
        }.resume()
    }
    
}
