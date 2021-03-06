//
//  APIRequest.swift
//  PokemonAPI_Swift
//
//  Created by Motoki Onayama on 2021/10/09.
//

import Foundation
import Alamofire

class APIRequest {
    
    static var shared = APIRequest()
    
    private let baseUrl = "https://pokeapi.co/api/v2/pokemon/"
    
    func get<T:Decodable>(path: String, prams: Parameters, type: T.Type, completion: @escaping (T) -> Void) {
        
        let path = path
        let url = baseUrl + path
        
        let request = AF.request(url, method: .get, parameters: prams)
        request.response { response in
            
            let statusCode = response.response!.statusCode
            
            do {
                if statusCode <= 300 {
                    guard let data = response.data else { return }
                    
                    let decode = JSONDecoder()
                    let value = try decode.decode(T.self, from: data)
                    completion(value)
                }
            } catch {
                print("変換に失敗しました：", error)
                print(response.debugDescription)
            }
            switch statusCode {
            case 400:
                print(response.description)
            case 401:
                print(response.description)
            case 403:
                print(response.description)
            case 404:
                print(response.description)
            default:
                break
            }
        }
    }
}
