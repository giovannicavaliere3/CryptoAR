//
//  API.swift
//  CT_AR
//
//  Created by Giovanni Cavaliere on 09/09/22.
//

import Foundation

class CoinAPI {
    func getAPI(completion: @escaping ([CoinModel]) -> ()) {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=100&page=1&sparkline=false" ) else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, _) in

            do {
                let returnedData = try JSONDecoder().decode([CoinModel].self, from: data!)
            
                
                DispatchQueue.main.async {
                    completion(returnedData)
                }
            } catch {
                print(String(describing: error))
            }
        }
            .resume()
    }
}





class ExchangeAPICall {
    func getAPI(completion: @escaping ([ExchangeModel]) -> ()) {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/exchanges" ) else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, _) in

            do {
                let returnedData = try JSONDecoder().decode([ExchangeModel].self, from: data!)

                DispatchQueue.main.async {
                    completion(returnedData)
                }
            } catch {
                print(String(describing: error))
            }
        }
            .resume()
    }
}
