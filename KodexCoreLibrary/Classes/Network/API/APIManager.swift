
//
// APIContants.swift
// BandPass

import Foundation
import SwiftyJSON
import Alamofire

open class APIManager: NSObject {
    public static let sharedInstance = APIManager()
    lazy var httpClient : HTTPClient = HTTPClient()
    public func removeCall(){
        httpClient.removeCall()
    }
    public func Request<T: Decodable , G: Router>(target: G , parentController : BaseViewController = BaseViewController() , success successCallback: @escaping (T?) -> Void , error errorCallback: @escaping (ErrorModel) -> Void  ) {
        HTTPClient.init().postRequest(withApi: target, success: { [self] (data,headers) in
            guard let response = data else {
                parentController.hideLoading()
                errorCallback(ErrorModel.init(code: 401, message: "No Data Found!"))
                return
            }
            let json = JSON(response)
            
            if let status = json.dictionaryValue["message"]?.stringValue,let isSuccess = json.dictionaryValue["success"]?.boolValue,!isSuccess {
                let data = json.dictionaryValue["data"]
                print("Url:\(target.url!)\nParams: \(String(describing:target.parameters))\nResponse: \(data as Any)\nHeaders: \(headers)")//
                parentController.hideLoading()
                errorCallback(ErrorModel.init(code: 203, message: status))
                return
            }
            let message = json.dictionary?["message"]?.rawValue as? String ?? ""
            if DataManager.sharedInstance.token != nil {
                if message == "Unauthenticated."{
                    parentController.hideLoading()
                    errorCallback(ErrorModel.init(code: 420, message: message))
                    return
                }
            }
            let data_model = json.dictionary?["data"]
            successCallback(decodeJson(data_model))
        }) { (error,headers) in
            parentController.hideLoading()
            print("Url:\(target.url!)\nParams: \(String(describing:target.parameters))")//
            errorCallback(ErrorModel.init(code: 500, message: error.description))
        }
    }
    
    public func RequestWithObjectArray<T: Decodable , G: Router>(target: G , parentController : BaseViewController = BaseViewController() , success successCallback: @escaping ([T]?) -> Void , error errorCallback: @escaping (ErrorModel) -> Void  ) {
        HTTPClient.init().postRequest(withApi: target, success: { [self] (data,headers) in
            guard let response = data else {
                parentController.hideLoading()
                errorCallback(ErrorModel.init(code: 401, message: "No Data Found!"))
                return
            }
            let json = JSON(response)
            if let status = json.dictionaryValue["message"]?.stringValue,let isSuccess = json.dictionaryValue["success"]?.boolValue,!isSuccess {
                let data = json.dictionaryValue["data"]
                print("Url:\(target.url!)\nParams: \(String(describing:target.parameters))\nResponse: \(data as Any)\nHeaders: \(headers)")//
                parentController.hideLoading()
                errorCallback(ErrorModel.init(code: 203, message: status))
                return
            }
            let message = json.dictionary?["message"]?.rawValue as? String ?? ""
            if DataManager.sharedInstance.token != nil {
                if message == "Unauthenticated."{
                    parentController.hideLoading()
                    errorCallback(ErrorModel.init(code: 420, message: message))
                    return
                }
            }
            let data_model = json.dictionary?["data"]
            successCallback(decodeJsonForArray(data_model))
        }) { (error,headers) in
            parentController.hideLoading()
            print("Url:\(target.url!)\nParams: \(String(describing:target.parameters))")//
            errorCallback(ErrorModel.init(code: 500, message: error.description))
        }
    }
    
    public func UploadRequest<T: Decodable , G: Router>(target: G , fileURLS : [URL]?, keys : [String] ,parentController : BaseViewController = BaseViewController() , progressCompletation : @escaping (Double?) -> (),success successCallback: @escaping (T?) -> Void , error errorCallback: @escaping (ErrorModel) -> Void  ) {
        HTTPClient.init().withFile(withApi: target, fileUrl: fileURLS, paramName: keys) { (progress) in
            progressCompletation(progress)
        } success: { [self] (data,headers) in
            guard let response = data else {
                parentController.hideLoading()
                errorCallback(ErrorModel.init(code: 401, message: "No Data Found!"))
                return
            }
            let json = JSON(response)
            
            if let status = json.dictionaryValue["message"]?.stringValue,let isSuccess = json.dictionaryValue["success"]?.boolValue,!isSuccess {
                let data = json.dictionaryValue["data"]
                print("Url:\(target.url!)\nParams: \(String(describing:target.parameters))\nResponse: \(data as Any)\nHeaders: \(headers)")//
                parentController.hideLoading()
                errorCallback(ErrorModel.init(code: 203, message: status))
                return
            }
            let message = json.dictionary?["message"]?.rawValue as? String ?? ""
            if DataManager.sharedInstance.token != nil {
                if message == "Unauthenticated."{
                    parentController.hideLoading()
                    errorCallback(ErrorModel.init(code: 420, message: message))
                    return
                }
            }
            let data_model = json.dictionary?["data"]
            successCallback(decodeJson(data_model))
        } failure: { (error,headers) in
            parentController.hideLoading()
            print("Url:\(target.url!)\nParams: \(String(describing:target.parameters))")//
            errorCallback(ErrorModel.init(code: 500, message: error.description))
        }
    }
      func decodeJson<T: Decodable>(_ dataJS: JSON?) -> T?{
        if let data = dataJS?.rawString()?.data(using: .utf8){
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                return model
            } catch {
                print(error as Any)
                return nil
            }
        }else{
            print("Error Parsing")
            return nil
        }
    }
    
    func decodeJsonForArray<T: Decodable>(_ dataJS: JSON?) -> [T]?{
      if let data = dataJS?.rawString()?.data(using: .utf8){
          do {
              let model = try JSONDecoder().decode([T].self, from: data)
              return model
          } catch {
              print(error as Any)
              return nil
          }
      }else{
          print("Error Parsing")
          return nil
      }
  }
}

public class ErrorModel :Codable {
    public var code:Int? = 0
    public var message:String? = ""
    init(code : Int , message : String) {
        self.code = code
        self.message = message
    }
}

