//
//  API.swift
//  Marvel app
//
//  Created by Misael Rivera on 24/11/19.
//  Copyright © 2019 Misael Rivera. All rights reserved.
//

import Foundation

struct ResponseStatus{
    static let OK = true
    static let Error = false
}

func nsdataToJSON(_ data: Data) -> [String:AnyObject]? {
    do {
        return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
    } catch  _{
        print("dataString = \(NSString(data: data, encoding:String.Encoding.utf8.rawValue)!)")
        return nil
    }
}

class PostDataHttp {
    var url = URL(string: " ")
    let json:AnyObject? = nil
    var paramString = " "
    var header = false
    let _memory = Memory()
    
    func forData(_ completion: @escaping(_ data:String?, _ json:[String:AnyObject]?,_ error: NSError?, _ success:Bool) ->()) {
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
//        if header {
//            if let token = _memory.getAccessToken() as? String{
//                print("Bearer \(token)")
//                request.allHTTPHeaderFields = ["Authorization": "Bearer " + token]
//                request.addValue("application/json", forHTTPHeaderField: "Accept")
//            }
//        }
        print(url!)
        print(paramString)
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            DispatchQueue.main.async (execute: {
                if error != nil{
                    completion(nil, nil,error as NSError?, ResponseStatus.Error)
                    return
                }
                
                if let data = data {
                    if let rs = response as? HTTPURLResponse{
                        if data.count>0{
                            if let json = nsdataToJSON(data){
                                print(json)
                                completion(nil,json,error as NSError?, ResponseStatus.OK)
                            }
                        }
                    }
                }
                completion(nil,nil,nil, ResponseStatus.Error)
                return
            })
        })
        task.resume()
        
    }
    
}

class GetDataHttp {
    var url = URL(string: " ")
    let json:AnyObject? = nil
    var paramString = " "
    var header = false
    let _memory = Memory()
    
    func forData(_ completion: @escaping(_ data:String?, _ json:[String:AnyObject]?,_ error: NSError?, _ success:Bool) ->()) {
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
     
        print(url!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            DispatchQueue.main.async (execute: {
                if error != nil{
                    completion(nil, nil,error as NSError?, ResponseStatus.Error)
                    return
                }
                
                if let data = data {
                    if let rs = response as? HTTPURLResponse{
                        if data.count>0{
                            if let json = nsdataToJSON(data){
                                print(json)
                                completion(nil,json,error as NSError?, ResponseStatus.OK)
                            }
                        }
                    }
                }
                completion(nil,nil,nil, ResponseStatus.Error)
                return
            })
        })
        task.resume()

    }
    
}
