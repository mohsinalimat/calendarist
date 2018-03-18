//
//  TodoistService.swift
//  ViperApp
//
//  Created by Romson Preechawit on 15/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

protocol TDRESTServiceProtocol {
    func getAllProjects(completion: @escaping NetworkCompletionHandler<[TDProject]>)
    func getAllLabels(completion: @escaping NetworkCompletionHandler<[TDLabel]>)
    func getTasks(withFilter filters: TDFilter?, completion: @escaping NetworkCompletionHandler<[TDTask]>)
}

class TDRESTService: TDRESTServiceProtocol {
    
    // IMPORTANT: As of SE-0054, ImplicitlyUnwrappedOptional change to complier annotation only
    // This mean that String! is allow to be treated as String but will ALWAYS be treated as String?
    // with ever available.
    // This make "token" interpolated as Optional("...") in our header which cause the request to fail.
    //
    // refer to: https://stackoverflow.com/a/39537558
    private var token: String!
    
    init(token: String) {
        self.token = token
    }
    
    func getAllProjects(completion: @escaping (NetworkResult<[TDProject]>) -> Void) {
        // Include the OAuth token4
        let headers = [
            "Authorization": "Bearer \(token!)"
        ]
        
        // Create a network request using Alamofire.
        // We can wrap this in a NetworkService class so Alamofire can
        // be replaced if necessary. But since this app is so small,
        // we will be keeping it simple for now.
        Alamofire.request(TodolistAPI.projects.url, headers: headers).responseArray { (response: DataResponse<[TDProject]>) in
            
            guard let projects = response.value else {
                completion(.error)
                return
            }
            
            // Return the list of TDProjects
            completion(.success(projects))
        }
    }
    
    func getAllLabels(completion: @escaping (NetworkResult<[TDLabel]>) -> Void) {
        
        let headers = [
            "Authorization": "Bearer \(token!)"
        ]
        
        Alamofire.request(TodolistAPI.labels.url, headers: headers).responseArray { (response: DataResponse<[TDLabel]>) in
            guard let dataArray = response.result.value else {
                completion(.error)
                return
            }
            completion(.success(dataArray))
        }
        
    }
    
    func getTasks(withFilter filters: TDFilter?, completion: @escaping (NetworkResult<[TDTask]>) -> Void) {
        
        // TODO: Need to pass in Filters as well... but how to test?
        
        let headers = [
            "Authorization": "Bearer \(token!)"
        ]
        
        let request = Alamofire.request(TodolistAPI.tasks.url, headers: headers)
        request.responseArray { (response: DataResponse<[TDTask]>) in
            debugPrint(request)
            guard let dataArray = response.result.value else {
                completion(.error)
                return
            }
            completion(.success(dataArray))
        }
        
    }
    
}
