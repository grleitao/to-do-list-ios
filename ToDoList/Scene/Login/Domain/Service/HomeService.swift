//
//  HomeService.swift
//  ToDoList
//
//  Created by Gustavo Rodrigues Leitao on 28/11/24.
//

import Alamofire

class HomeService {

    func loginUser(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        let url = "https://api-nodejs-todolist.herokuapp.com/user/login"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: LoginResponse.self) { response in
            switch response.result {
            case .success(let loginResponse):
                print("Login bem-sucedido: \(loginResponse.message)")
                print("Token: \(loginResponse.token)")
                completion(.success(loginResponse))
            case .failure(let error):
                print("Erro no login: \(error)")
                completion(.failure(error))
            }
        }
    }
}

struct LoginResponse: Codable {
    let message: String
    let token: String
}
