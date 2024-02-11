//
//  Currency.swift
//  CurrencyManagement
//
//  Created by Melih Yesilyurt on 11.02.2024.
//

import Foundation
import Alamofire

struct CurrencyExchangeResponse: Codable {
    var success: Bool
    var terms: String
    var privacy: String
    var query: Query
    var info: Info
    var result: Double
}

struct Query: Codable {
    var from: String
    var to: String
    var amount: Int
}

struct Info: Codable {
    var timestamp: Int
    var quote: Double
}

private func apiRequest(url: String, completion: @escaping (CurrencyExchangeResponse) -> ()) {
    Session.default.request(url).responseDecodable(of: CurrencyExchangeResponse.self) {
        response in
        switch response.result {
        case .success(let response):
            completion(response)
        case .failure(let error):
            print(error)
        }
    }
}

func convertCurrency(fromCurrencyType: String, toCurrencyType: String, amount: Int, completion: @escaping (Result<Double,Error>) -> Void ){
    let url = "http://api.exchangerate.host/convert?access_key=\(accessKey)&from=\(fromCurrencyType)&to=\(toCurrencyType)&amount=\(amount)"
    apiRequest(url: url) { response in
        if response.success {
            completion(.success(response.result))
        } else {
            let error = NSError(domain: "CurrencyConversionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Currency conversion failed!"])
        }
    }
}
