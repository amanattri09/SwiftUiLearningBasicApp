//
//  PostRepositary.swift
//  FirebaseSwiftUIExample
//
//  Created by Aman Attri on 25/06/25.
//

import Combine

protocol PostRepositary {
    func getPostDetail(_ id:String) -> AnyPublisher<PostModal , Error>
    func getAllPosts() -> AnyPublisher<[PostModal], Error>
}
