//
//  GetClothesSize.swift
//  FitsMe
//
//  Created by Sergey Romanchuk on 21/04/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation

extension NetworkManager{
    
    func getClothesSize(complition: @escaping (_ data: [ClothesSize]?, _ error: String?) -> ()){
        print("Start getClothesSize")
        //don't know how to fix enum Void ass type - so added ()
        router.request(.clothesSize(())) { (data, response, error) in
            if error != nil{
                complition(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse{
                let result = self.handleNetworkResponse(response)
                guard let responseData = data else {
                    complition(nil, NetworkResponse.noData.rawValue)
                    return
                }
                
                
                switch result{
                case .success:
                    print("Success getClothesSize")
                    do {
                        let apiResponse = try JSONDecoder().decode(SizeDataResponse.self, from: responseData)
                        guard let sizearray:[ClothesSize] = apiResponse.response as? [ClothesSize] else {return}
                        print(sizearray)
                        complition(sizearray, nil)
                        
                    }catch{
                        print("Something goes wrong")
                        complition(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    
                    
                case .failure(_):
//                    do {
                        complition(nil, /*self.handleNetworkSpecificErrors(code*/nil)
//                    } catch {
//                        complition(nil, NetworkResponse.unableToDecode.rawValue)
//                    }
                    
                    
                    
                    
                }
                
                
                
            }
            
            
            
        }
        
        
        
        
        print("AAAA")
        
        
        
    }
}
