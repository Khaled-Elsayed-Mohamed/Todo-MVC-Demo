import Foundation
import Alamofire

class APIManager {
    // MARK :- Login
    class func login(with email: String, password: String, completion: @escaping (_ error: Error?, _ loginData: LoginResponse?) -> Void) {
        
        let headers: HTTPHeaders = [HeaderKeys.contentType: "application/json"]
        let params: [String: Any] = [ParameterKeys.email: email,
                                     ParameterKeys.password: password]
        
        AF.request(URLs.login, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: headers).response {
            response in
            guard response.error == nil else {
                print(response.error!)
                completion(response.error, nil)
                return
            }
            
            guard let data = response.data else {
                print("didn't get any data from API")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let loginData = try decoder.decode(LoginResponse.self, from: data)
                completion(nil, loginData)
            } catch let error {
                completion(error, nil)
                print(error)
            }
        }
    }
    // MARK :- Register
    class func register(with user: Register, completion: @escaping (_ error: Error?, _ registerData: LoginResponse?) -> Void) {
        guard let name = user.name,
            let email = user.email,
            let password = user.password,
            let age = user.age else {return}
        
        let headers: HTTPHeaders = [HeaderKeys.contentType: "application/json"]
        let params: [String: Any] = [ParameterKeys.email: email,
                                     ParameterKeys.password: password,
                                     ParameterKeys.name: name,
                                     ParameterKeys.age: age]
        
        AF.request(URLs.register, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: headers).response {
            response in
            guard response.error == nil else {
                print(response.error!)
                completion(response.error, nil)
                return
            }
            
            guard let data = response.data else {
                print("didn't get any data from API")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let loginData = try decoder.decode(LoginResponse.self, from: data)
                completion(nil, loginData)
            } catch let error {
                completion(error, nil)
                print(error)
            }
        }
    }
    // MARK:- addTask
    class func addTast(with description: String, completion: @escaping (Bool) -> Void) {
        
        
        let headers: HTTPHeaders = [HeaderKeys.authorization: "Bearer \(UserDefaultsManager.shared().token!)" ,HeaderKeys.contentType: "application/json"]
        let params: [String: Any] = ["description": description]
            
            AF.request(URLs.task, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: headers).response {
                response in
                guard response.error == nil else {
                    print(response.error!)
                    completion(false)
                    return
                }
                completion(true)
        }
    }
    // MARK:- Get Task
    class func getAllTasks(completion: @escaping (_ error: Error?, _ taskResponse: TaskResponse?) -> Void) {
        
        let headers: HTTPHeaders = [HeaderKeys.authorization: "Bearer \(UserDefaultsManager.shared().token!)" ,HeaderKeys.contentType: "application/json"]
        
        AF.request(URLs.task, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: headers).response {
            response in
            guard response.error == nil else {
                print(response.error!)
                completion(response.error, nil)
                return
            }
            
            guard let data = response.data else {
                print("didn't get any data from API")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let taskResponse = try decoder.decode(TaskResponse.self, from: data)
                completion(nil, taskResponse)
            } catch let error {
                print(error)
            }
        }
    }
    // MARK:- Get user info
    class func getUserData(completion: @escaping (_ error: Error?, _ UserData: UserData?) -> Void) {
        
        
        let headers: HTTPHeaders = [HeaderKeys.authorization: "Bearer \(UserDefaultsManager.shared().token!)"]
        
        AF.request(URLs.getUser, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: headers).response {
            response in
            guard response.error == nil else {
                print(response.error!)
                completion(response.error, nil)
                return
            }
            
            guard let data = response.data else {
                print("didn't get any data from API")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let userData = try decoder.decode(UserData.self, from: data)
                completion(nil, userData)
            } catch let error {
                completion(error, nil)
                print(error)
            }
        }
    }
    // MARK:- Log out
    class func logout(completion: @escaping (Bool) -> Void) {
        
        
        let headers: HTTPHeaders = [HeaderKeys.authorization: "Bearer \(UserDefaultsManager.shared().token!)"]
        
            
            AF.request(URLs.logout, method: HTTPMethod.post, parameters: nil, encoding: JSONEncoding.default, headers: headers).response {
                response in
                guard response.error == nil else {
                    print(response.error!)
                    completion(false)
                    return
                }
                completion(true)
        }
    }
    // MARK:- Delete task
    class func deleteTask(with id: String, completion: @escaping (Bool) -> Void) {
        
        let headers: HTTPHeaders = [HeaderKeys.authorization: "Bearer \(UserDefaultsManager.shared().token!)"]
        
            
            AF.request("\(URLs.task)/\(id)", method: HTTPMethod.delete, parameters: nil, encoding: JSONEncoding.default, headers: headers).response {
                response in
                guard response.error == nil else {
                    print(response.error!)
                    completion(false)
                    return
                }
                completion(true)
        }
    }
    // MARK:- Upload Image
    class func uploadImage(with image: UIImage, completion: @escaping (Bool) -> Void) {
        
        let headers: HTTPHeaders = [HeaderKeys.authorization: "Bearer \(UserDefaultsManager.shared().token!)"]
        guard let imageData = image.jpegData(compressionQuality: 0.7) else { return }
        
        AF.upload(multipartFormData: { (formdata) in
            formdata.append(imageData, withName: "avatar", fileName: "/home/ali/Mine/c/nodejs-blog/public/img/blog-header.jpg", mimeType: "blog-header.jpg")
        }, to: URLs.uploadImage, headers: headers).response {
            response in
            guard response.error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    // MARK:- Get Image
    class func getImage(with id: String, completion: @escaping (Error?, Data?) -> Void) {
        
        AF.request(URLs.user + "/\(id)" + "/avatar", method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response {
                response in
                guard response.error == nil else {
                    print(response.error!)
                    completion(response.error, nil)
                    return
                }
            guard let data = response.data else {
                print("no data")
                return
            }
                completion(nil, data)
        }
    }
    
}
