//
//  NetworkManager.swift
//  CountriesAPI
//
//  Created by Артем Соколовский on 06.05.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let headersForAlamofire: HTTPHeaders = [
        //insert your headers from rapidAPI (Countries Cities API Documentation)
    ]
    
    func fetchAlamofireCountryList(countryAPI: String, _ completion: @escaping ([Dictionary<String, String>.Element]) -> Void) {
        let jsonURL = countryAPI + "list"
        
        AF.request(jsonURL, headers: headersForAlamofire).responseData { response in
            debugPrint(response)
            
            guard let json = response.data else { return }
            do {
                let countryList = try JSONDecoder().decode(CountryList.self, from: json)
                let sortedCountryList = countryList.countries.sorted { return $0.1 < $1.1 }
                completion(sortedCountryList)
            } catch let error {
                print(error)
            }
            
        }
    }
    
    
    func fetchAlamofireCountryDetails(countryAPI: String, shortName: String, _ completion: @escaping (CountryDetail, Data) -> Void) {
    
        let jsonURL = countryAPI + shortName
        
        AF.request(jsonURL, headers: headersForAlamofire).responseData { response in
            debugPrint(response)
            
            guard let json = response.data else { return }
            do {
                let countryDetail = try JSONDecoder().decode(CountryDetail.self, from: json)
                guard let imageData = self.fetchImage(from: countryDetail.flag.file) else { return }
                completion(countryDetail, imageData)
            } catch let err {
                print(err)
            }
            
        }
    }
    
    func fetchImage(from url: String?) -> Data? {
        guard let stringURL = url else { return nil }
        print(stringURL)
        guard let imageURL = URL(string: stringURL) else { return nil }
        print(imageURL)
        return try? Data(contentsOf: imageURL)
    }
    
}
