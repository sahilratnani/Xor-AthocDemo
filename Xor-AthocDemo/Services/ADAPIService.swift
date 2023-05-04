//
//  ADAPIService.swift
//  Xor-AthocDemo
//
//  Created by Sahil Ratnani on 29/04/23.
//

import Foundation

class ADAPIService {
    ///User Verification API call
    class func verifyUserDetails(user: User, completion: @escaping ((Result<Any, Error>)->())) {
        var seconds = 0
        let apiResponseTime = 30
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            seconds += 1
            if seconds == apiResponseTime {
                completion(.success(user))
                timer.invalidate()
            }
        }
    }
}
