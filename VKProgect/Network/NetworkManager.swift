//
//  NetworkManager.swift
//  VKProgect
//
//  Created by Дмитрий Голубев on 14.07.2022.
//

import Foundation
final class NetworkManager{
    static let shared = NetworkManager()
    let urlString = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
    
    private init() {}
    
    func featchServices(complition: @escaping ([Service])->Void){
        if let url = URL(string: urlString){
            let task = URLSession.shared.dataTask(with: url) { data, responce, error in
                if let unwrappedData = data{
                    do{
                        let object = try JSONDecoder().decode(Object.self, from: unwrappedData)
                        complition(object.body.services)
                    } catch let error{
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    func featchImageData(with urlString: String, complition: @escaping (Data) -> Void){
        
        if let url = URL(string: urlString){
            let task = URLSession.shared.dataTask(with: url) { data, responce, error in
                if error != nil {
                    return
                }
                guard let data = data else { return }
                complition(data)
                
            }
            task.resume()
        }
    }
}
