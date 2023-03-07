//
//  Post.swift
//  Year Long Project (Part 1)
//
//  Created by Sterling Jenkins on 11/2/22.
//
import Foundation

struct Post {
    var title: String
    var bodyText: String
    var date: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: Date())
    }
    var user: String
    var comments: String
}
