//
//  Network.swift
//  FarceBookTheApp
//
//  Created by jwilson on 11/14/17.
//  Copyright © 2017 jwilson. All rights reserved.
//

import Foundation







class Network {

    var tokenId = "40CC242F-5FB9-4559-9F46-9283EF0A7C61"

    static var shared = Network()
    func getUserList() {
        let getURL = URL(string: "https://obscure-crag-65480.herokuapp.com/users")!
        var getReq = URLRequest(url: getURL)
        getReq.httpMethod = "GET"
        getReq.addValue(tokenId, forHTTPHeaderField: "token")
        let getTask = URLSession(configuration: .ephemeral).dataTask(with: getReq) { (d, response, error) in
            if error != nil {
                print(error!)
            }
            if response != nil {
                print(response!)
            }
            let users = try! JSONDecoder().decode(Array<String>.self, from: d!)
            print(users)
        }
        getTask.resume()
    }

    func getDirect() {
        let getURL = URL(string: "https://obscure-crag-65480.herokuapp.com/direct")!
        var getReq = URLRequest(url: getURL)
        getReq.httpMethod = "GET"
        getReq.addValue(tokenId, forHTTPHeaderField: "token")
        let getTask = URLSession(configuration: .ephemeral).dataTask(with: getReq) { (d, response, error) in
            if error != nil {
                print(error!)
            }
            if response != nil {
                print(response!)
            }
            print(String(data: d!, encoding: .utf8)!)
            let dm = try! JSONDecoder().decode(Array<DirectMessage>.self, from: d!)
            }
        getTask.resume()
    }

    func postDirectMessage(directMessage: DirectMessage) {
        let getURL = URL(string: "https://obscure-crag-65480.herokuapp.com/direct")!
        var getReq = URLRequest(url: getURL)
        getReq.httpMethod = "POST"
        getReq.addValue(tokenId, forHTTPHeaderField: "token")
        let directMessageJson = try! JSONEncoder().encode(directMessage)
        getReq.httpBody = directMessageJson
        let getTask = URLSession(configuration: .ephemeral).dataTask(with: getReq) { (d, response, error) in
            if error != nil {
                print(error!)
            }
            if response != nil {
                print(response!)
            }
            print(String(data: d!, encoding: .utf8)!)
        }
        getTask.resume()
    }

    func postMessage(message: Message) {
        let getURL = URL(string: "https://obscure-crag-65480.herokuapp.com/messages")!
        var getReq = URLRequest(url: getURL)
        getReq.httpMethod = "POST"
        getReq.addValue(tokenId, forHTTPHeaderField: "token")
        let messageJson = try! JSONEncoder().encode(message)
        getReq.httpBody = messageJson
        let getTask = URLSession(configuration: .ephemeral).dataTask(with: getReq) { (d, response, error) in
            if error != nil {
                print(error!)
            }
            if response != nil {
                print(response!)
            }
            print(String(data: d!, encoding: .utf8)!)
        }
        getTask.resume()
    }

    func getMessages(completion: @escaping ([Message]) -> ()) {
        let getURL = URL(string: "https://obscure-crag-65480.herokuapp.com/messages")!
        var getReq = URLRequest(url: getURL)
        getReq.httpMethod = "GET"
        getReq.addValue(tokenId, forHTTPHeaderField: "token")
        let getTask = URLSession(configuration: .ephemeral).dataTask(with: getReq) { (d, response, error) in
            if error != nil {
                print(error!)
            }
            if response != nil {
                print(response!)
            }
            print(String(data: d!, encoding: .utf8)!)
            let messages = try! JSONDecoder().decode(Array<Message>.self, from: d!)
            DispatchQueue.main.async {
                completion(messages)
            }
            for m in messages {
                print("\(m.user) said")
                print(m.text)
                print("at \(m.date) o-clock")
                print("with id \(m.id)")
                print("liked by: ")
                for use in m.likedBy {
                    print(use)
                }
            }
        }
        getTask.resume()
    }

    func login(){
        let postURL = URL(string: "https://obscure-crag-65480.herokuapp.com/login")!
        var request = URLRequest(url: postURL)
        let login = Login(name: "robert.grosso", password: "cd3uyknjvuk")
        request.httpBody = try! JSONEncoder().encode(login)
        request.httpMethod = "POST"
        let postTask = URLSession(configuration: .ephemeral).dataTask(with: request) { (d, response, error) in
            if error != nil {
                print(error!)
            }
            if response != nil {
                print(response!)
            }
            let uuid = try! JSONDecoder().decode(Id.self, from: d!)
            print(uuid.token)
            self.tokenId = uuid.token
        }
        postTask.resume()
    }
}




