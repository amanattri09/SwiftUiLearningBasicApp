//
//  PostDetailViewModel.swift
//  FirebaseSwiftUIExample
//
//  Created by Aman Attri on 25/06/25.
//

import Combine

class PostDetailViewModel : ObservableObject {
    
    @Published var post : PostModal?
    @Published var errorMessage : String?
    @Published var isLoading = false
    
    private let repositary : PostRepositary
    private var cancellables = Set<AnyCancellable>()
    
    init( repositary: PostRepositary = PostRepositaryImp()) {
        self.repositary = repositary
    }
    
    
    func getPostDetail(id : String){
        isLoading = true
        repositary.getPostDetail(id).sink(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }, receiveValue: { post in
            self.post = post
            self.isLoading = false
        })
        .store(in: &cancellables)
    }
    
    
}
