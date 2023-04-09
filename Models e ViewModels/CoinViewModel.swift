//
//  CoinViewModel.swift
//  CT_AR
//
//  Created by Giovanni Cavaliere on 11/09/22.
//

import Foundation


class CoinViewModel: ObservableObject {
    private let coinService: CoinAPI!
    
    @Published private var coin = CoinDataBITCOIN()
    
    init() {
        self.coinService = CoinAPI()
        }
    var currentPrice: Double? {self.coin.main.currentPrice}
    var name: String? {self.coin.symbol.name}
    
    

    
   




  
    
    
}
