//
//  CoinViewModelStr.swift
//  CT_AR
//
//  Created by Giovanni Cavaliere on 11/09/22.
//


struct CoinDataBITCOIN: Decodable {
  
    
    init(){
        id = 0
        symbol = coinType()
        weat = [roiType()]
        main = Price()
    }
    
    let id: Int
    let symbol : coinType
    let weat: [roiType]
    let main: Price
   
}

    struct Price: Decodable {
        var currentPrice: Double?
        var marketCap, marketCapRank : Int?
        var totalVolume: Double?
    }
    
    struct coinType: Decodable {
        var name: String?
        var image: String?
        var athDate: String?
        var atlDate: String?
       
    }
    
    struct roiType : Decodable {
        var main: roiTypeEnum?
    }
    
    enum roiTypeEnum: String, Decodable {
    case btc = "btc"
    case eth = "eth"
    case usd = "usd"
    }
