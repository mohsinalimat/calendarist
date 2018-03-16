//
//  TodoistService.swift
//  ViperApp
//
//  Created by Romson Preechawit on 15/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

typealias ErrorCompletionHandler = ((_ error: NSError) -> Void)?

protocol TDRestServiceProtocol {
    func getAllProjects(_ errorHandler: ErrorCompletionHandler, successHandler: @escaping ([TDProject]) -> Void)
    func getAllLabels(_ errorHandler: ErrorCompletionHandler, successHandler: @escaping ([TDLabel]) -> Void)
    func getTasks(withFilter filters: TDFilter?, errorHandler: ErrorCompletionHandler, successHandler: @escaping ([TDTask]) -> Void)
}

class TDRESTService {
    
    private var token: String!
    
    init(token: String) {
        self.token = token
    }
    
}
