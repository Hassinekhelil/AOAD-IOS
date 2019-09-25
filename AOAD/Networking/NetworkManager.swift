//
//  NetworkManager.swift
//  AOAD
//
//  Created by Hassine on 30/08/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager: NSObject {
    
    class func getStatisticsMenu(url: String, completion: @escaping (_ error: Error?, _ success: String?)->Void){
        
        Alamofire.request(url, method: .post, parameters: nil)
            .responseString(encoding: String.Encoding.utf8) { response in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        print(data)
                        completion(nil, data)
                    }
                    
                case .failure(_):
                    print("Error message:\(String(describing: response.result.error))")
                    completion(nil, response.result.error as? String)
                    break
                }
        }
    }
    
    class func getMarkersPositions(param: NSDictionary, completion: @escaping (_ error: Error?, _ success: [Pib_class])->Void){
        let url = Constants.pib_secteur_date
        let parametres = param as! Parameters
        Alamofire.request(url,
                          method: .post,
                          parameters: parametres)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    print(error)
                    break
                case .success(let responseObject):
                    var list: [Pib_class] = []
                    let json = JSON(responseObject)
                    
                    for index in 0..<json.count {
                        list.append(Pib_class(data: json[index]))
                    }
                    completion(nil,list)
                    break
                }
        }
    }
    
    class func getCopuntries(url: String, completion: @escaping (_ error: Error?, _ success: [Country])->Void){
        Alamofire.request(url,
                          method: .post,
                          parameters: nil)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    print(error)
                    break
                case .success(let responseObject):
                    var list: [Country] = []
                    let json = JSON(responseObject)
                    
                    for index in 0..<json.count {
                        list.append(Country(data: json[index]))
                    }
                    completion(nil,list)
                    break
                }
        }
    }
    
    class func getSubmenu(param: NSDictionary, completion: @escaping (_ error: Error?, _ success: String)->Void){
        let url = Constants.get_submenu
        let parametres = param as! Parameters
        Alamofire.request(url,
                          method: .post,
                          parameters: parametres)
            .validate()
            .responseString(encoding: String.Encoding.utf8) { response in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        print(data)
                        completion(nil, data)
                    }
                    
                case .failure(_):
                    print("Error message:\(String(describing: response.result.error))")
                    completion(nil, (response.result.error as? String)!)
                    break
                }
        }
    }
    
    class func getStatisticData(param: NSDictionary, completion: @escaping (_ error: Error?, _ success: JSON)->Void){
        let url = Constants.get_statistic_data
        let parametres = param as! Parameters
        Alamofire.request(url,
                          method: .post,
                          parameters: parametres)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    print(error)
                    break
                case .success(let responseObject):
                    completion(nil,JSON(responseObject))
                    break
                }
        }
    }
    
    class func getCommunicationOffice(param: NSDictionary, completion: @escaping (_ error: Error?, _ success: [CommunicationOffice])->Void){
        let url = Constants.get_communication_office
        let parametres = param as! Parameters
        Alamofire.request(url,
                          method: .post,
                          parameters: parametres)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    print(error)
                    break
                case .success(let responseObject):
                    var list: [CommunicationOffice] = []
                    let json = JSON(responseObject)
                    
                    for index in 0..<json.count {
                        list.append(CommunicationOffice(data: json[index]))
                    }
                    completion(nil,list)
                    break
                }
        }
    }
    
    
    class func getMinistires(param: NSDictionary, completion: @escaping (_ error: Error?, _ success: [Ministrie])->Void){
        let url = Constants.get_departments
        let parametres = param as! Parameters
        Alamofire.request(url,
                          method: .post,
                          parameters: parametres)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    print(error)
                    break
                case .success(let responseObject):
                    var list: [Ministrie] = []
                    let json = JSON(responseObject)
                    
                    for index in 0..<json.count {
                        list.append(Ministrie(data: json[index]))
                    }
                    completion(nil,list)
                    break
                }
        }
    }
}
