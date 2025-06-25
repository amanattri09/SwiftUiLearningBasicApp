//
//  PostRepositaryImp.swift
//  FirebaseSwiftUIExample
//
//  Created by Aman Attri on 25/06/25.
//

import Foundation
import Combine

class PostRepositaryImp : PostRepositary {
    
    private let service : PostServiceProtocol
    
    init(service: PostServiceProtocol = PostService()) {
        self.service = service
    }
    
    func getPostDetail(_ id: String) -> AnyPublisher<PostModal, any Error> {
        return service.getPostDetail(id: id)
    }
}
