//
//  TodoistService.swift
//  ViperApp
//
//  Created by Romson Preechawit on 16/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation

protocol TodoistModuleProtocol {
    func getAllTasks(completion: @escaping NetworkCompletionHandler<[TDTask]>)
    func getAllLabels(completion: @escaping NetworkCompletionHandler<[TDLabel]>)
    func getAllProjects(completion: @escaping NetworkCompletionHandler<[TDProject]>)
}

class TodoistModule: TodoistModuleProtocol {
    
    var token: String?
    
    var tdOAuthService: TDOAuthService!
    var tdSyncService: TDRESTService!
    
    // TODO: change to completion handler
    func authenticate() {
        tdOAuthService = TDOAuthService()
        
        // try to get token
        tdOAuthService.initiateOAuth(error: nil) { (access_token) in
            self.token = access_token
            tdSyncService = TDRESTService(token: token!)
        }
    }
    
    func isAuthenticated() -> Bool {
        return token != nil
    }
    
    func getAllTasks(completion: @escaping NetworkCompletionHandler<[TDTask]>) {
        if !isAuthenticated() {
            // FIXME: should throw exception or redirect user to login page
            authenticate()
        }
        tdSyncService.getTasks(withFilter: nil, completion: completion)
    }
    
    func getAllLabels(completion: @escaping (NetworkResult<[TDLabel]>) -> Void) {
        if !isAuthenticated() {
            // FIXME: should throw exception or redirect user to login page
            authenticate()
        }
        tdSyncService.getAllLabels(completion: completion)
    }
    
    func getAllProjects(completion: @escaping (NetworkResult<[TDProject]>) -> Void) {
        if !isAuthenticated() {
            // FIXME: should throw exception or redirect user to login page
            authenticate()
        }
        tdSyncService.getAllProjects(completion: completion)
    }
    
    
}
