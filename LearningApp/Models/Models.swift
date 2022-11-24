//
//  Models.swift
//  LearningApp
//
//  Created by Fidan Oruc on 25.08.22.
//

import Foundation

struct Module: Identifiable, Decodable{
    
    var id: String = ""
    var category: String = ""
    var content: Content = Content() //"content": {} it is content object
    var test: Test = Test() //"test": {} it is test object
}

struct Content: Identifiable, Decodable{
    var id: String = ""
    var image: String = ""
    var time: String = ""
    var description: String = ""
    var lessons: [Lesson] = [Lesson]()
}

struct Lesson: Identifiable, Decodable{
    var id: String = ""
    var title: String = ""
    var video: String = ""
    var duration: String = ""
    var explanation: String = ""
}

struct Test: Identifiable, Decodable{
    var id: String = ""
    var image: String = ""
    var time: String = ""
    var description: String = ""
    var questions: [Question] = [Question]()
}
struct Question: Identifiable, Decodable{
    var id: String = ""
    var content: String = ""
    var correctIndex: Int = 0
    var answers: [String] = [String]()
}

struct User{
    var name: String = ""
    var lastModule: Int?
    var lastLesson: Int?
    var lastQuestion: Int?
}
