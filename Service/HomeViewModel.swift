//
//  BitcoinNetworkManager.swift
//  CT_AR
//
//  Created by Giovanni Cavaliere on 20/09/22.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var coins = [CoinDataFinal]()

    init(){
        fetchCoinData()
      
    }
    
    func fetchCoinData() {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=24h"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("DEBUG: Error \(error.localizedDescription)")
                return
            }
            if let response = response as? HTTPURLResponse {
                print("DEBUG: Response code \(response.statusCode)")
            }
            
            guard let data = data else {return}
            let dataAsString = String(data: data, encoding: .utf8)
                print("DEBUG: Data \(data)")
            print("DEBUG: Data \(String(describing: dataAsString))")
            
            do {
                let coins = try JSONDecoder().decode([CoinDataFinal].self, from: data)
                self.coins = coins
                print("DEBUG: Coins \(coins)")
                
            } catch let error {
                print("DEBUG: Failed to decode with error: \(error)")
            }
        }.resume()
    }
}
 
