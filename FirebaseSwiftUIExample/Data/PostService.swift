//
//  UserService.swift
//  FirebaseSwiftUIExample
//
//  Created by Aman Attri on 25/06/25.
//

import Foundation
import Combine

protocol PostServiceProtocol {
    func getPostDetail(id:String) -> AnyPublisher<PostModal , Error>
}

class PostService : PostServiceProtocol{
    func getPostDetail(id : String) -> AnyPublisher<PostModal, any Error> {
        let url = URL(string: "\(AppConstants.Api.BASE_URL)/posts/\(id)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: PostModal.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
