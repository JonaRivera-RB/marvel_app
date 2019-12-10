//
//  HeroeAPI.swift
//  Marvel app
//
//  Created by Misael Rivera on 24/11/19.
//  Copyright © 2019 Misael Rivera. All rights reserved.
//

import UIKit

public struct HeroeAPI {
    
    let _getRequest = GetDataHttp()
    
    func getHeroes(toPage page:String?, heroesDownloaded: @escaping(_ status:Bool, _ heroes:[Heroe]?, _ totalHero:Int?, _ error: Error?) -> () ) {
        
        var urlComponents = URLComponents(string: Routes.URLMARVEL + Routes.characters)
        urlComponents?.queryItems = [
        URLQueryItem(name: "apikey", value: "d329be63b9ebccebaf007906bc33ea8d"),
        URLQueryItem(name: "hash", value: "45915367939993da005ee5e59068c3b4"),
        URLQueryItem(name: "ts", value: "1"),
        URLQueryItem(name: "offset", value: page ?? "0"),
        URLQueryItem(name: "limit", value: "10")
        ]
        
        _getRequest.url = urlComponents?.url //URL(ur: urlComponents?.url)
        _getRequest.header = false
        _getRequest.forData { (data, json, error, success) in
            DispatchQueue.main.async {
                if success {
                    if let status = json?["status"] as? String, status == "Ok", let data = json?["data"] as? [String:AnyObject], let results = data["results"] as? [Any] {
                        
                        var heroes = [Heroe]()
                        let totalHero = data["total"] as! Int
                        
                        for heroe in results {
                            let firstObject = heroe as? [String : Any]
                            
                            let heroName = firstObject?["name"] as? String ?? ""
                            let thumbnail = firstObject?["thumbnail"] as? [String : Any]
                            let path = thumbnail?["path"] as? String ?? ""
                            let imageExtension = thumbnail?["extension"] as? String ?? ""
                            
                            print("name: \(String(describing: heroName))")
                            print("path: \(String(describing: path))")
                            let newHeroe = Heroe(name: heroName, urlImage: path, imageExt: imageExtension)
                            heroes.append(newHeroe)
                            
                        }
                        heroesDownloaded(ResponseStatus.OK, heroes, totalHero, nil)
                        return
                    }
                }
                heroesDownloaded(ResponseStatus.Error, nil, nil, nil)
                return
            }
        }
    }
}
