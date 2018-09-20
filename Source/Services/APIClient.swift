//
//  APIClient.swift
//  ZilliqaSDK iOS
//
//  Created by Alexander Cyon on 2018-09-20.
//  Copyright © 2018 Open Zesame. All rights reserved.
//

import JSONRPCKit
import APIKit

public protocol APIClient {
    func send<Request>(request: Request, done: @escaping RequestDone<Request.Response>) where Request: JSONRPCKit.Request
}
