//
//  APIService.swift
//  Github Project
//
//  Created by youssef on 14/11/2022.
//

import Foundation

class APIService {
    
    static let sharedServeice = APIService()

    func getRespository (completion: @escaping(_ Respositories :[Repository]? , _ erorr : Error? )-> Void){
        
        
        guard let url = URL(string: "https://api.github.com/repositories")
        else{return}
        
        let seasion = URLSession.shared
        let request = URLRequest(url: url)
        let task = seasion.dataTask(with: request) {data , response, error  in
            
            guard error == nil else{return}
            
            guard let data = data else {
                return
            }
            
            do{
               
                let decoder = JSONDecoder()
                let response = try decoder.decode([Repository].self, from: data)
                debugPrint(completion)
                completion(response , nil)
                
            } catch {
                debugPrint(error.localizedDescription)
                completion(nil , error )
            }
            
        }
        task.resume()
    }

}
