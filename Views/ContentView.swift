//
//  ContentView.swift
//  CT_AR
//
//  Created by Giovanni Cavaliere on 09/09/22.
//

import SwiftUI
import RealityKit
import SceneKit

struct ContentView : View {
    var body: some View {
        return ARViewContainer()
    }
    
}

struct ARViewContainer: UIViewRepresentable {
    var ARCoinSceneService: ARCoinViewSceneService = ARCoinViewSceneService()
    @EnvironmentObject var coinVM : HomeViewModel
    
    func makeUIView(context: Context) -> ARView {
        return ARCoinSceneService.arView
        
    }
    func updateUIView(_ uiView: ARView, context: Context) {

        print("-----------CURRENTPRICE DEBUG---\(String(describing: coinVM.coins[0].currentPrice))-----------")
        print("------NAME DEBUG----\(String(describing: coinVM.coins[0].name))-------")
        for coin in coinVM.coins {
           
            if coin.name == "Bitcoin" {
                ARCoinSceneService.updateCurrentPrice(currentPrice: coin.currentPrice)
                ARCoinSceneService.updatePercentageChange24H(percentage: coin.priceChangePercentage24H)
                    
            }
    }
       
        
         }
        }


struct ARViewer: View {
    
    var body: some View {
        ContentView().ignoresSafeArea(.all)
    }
}




struct ContentView2: View {
    @State var isPressed: Bool = true
    private enum Tab: Hashable {
        case chart
        case test
    }
    @State private var selectedTab: Tab = .chart
    
 
   


    var body: some View {
      
        if !isPressed{
        ZStack {
 
        TabView(selection: $selectedTab) {
            CoinListView()
                .tag(0)
                .tabItem {
                Text("Coins")
                Image(systemName: "chart.line.uptrend.xyaxis.circle")
            }
            
            ExchangesView()
                .tag(1)
                .tabItem {
                Text("Exchanges")
                Image(systemName: "bitcoinsign.circle.fill")
                }
            
            ContentView()
                .tag(2)
                .tabItem {
                Text("AR")
                    Image(systemName: "a.circle.fill")}
                    
                
            
            ModelView()
                .tag(3)
                .tabItem{
                Text("Models")
                Image(systemName: "view.3d")
                }
            
            InfoView()
                .tag(4)
                .tabItem{
                    Text("Info")
                    Image(systemName: "info.circle.fill")
                }
            
        
        }
        } 
            
        } else if isPressed {
            ContView(isPressed: $isPressed)
        }
        }
}
    


struct ContentView_Previews2: PreviewProvider {
    static var previews: some View {
        ContentView2()
}
}



struct CoinListView: View {
    @State var data = [CoinModel]()
    @State var returnPressed :Bool = false
    @State var showInfo: Bool = false
    var body: some View {
    
       
        
        NavigationView {
            VStack {
                List(data, id: \.self) { item in
                    NavigationLink(destination: CoinDetailedData(coin: item)) {
                        HStack {
                            Text("\(item.marketCapRank ?? 0)")
                                .font(.headline)
                            
                            AsyncImage(url: URL(string: "\(item.image ?? "")")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                                .frame(width: 20, height: 20)
                            if item.marketCapRank ?? 0 == 1 {
                            Text("\(item.name ?? "")")
                                    .font(.headline)
                                    .foregroundColor(Color.theme.accent)
                            } else {
                                Text("\(item.name ?? "")")
                                    .font(.headline)
                                    .foregroundColor(Color.theme.accent)
                            }

                            Spacer()
                            
                            Text("€\(item.currentPrice ?? 0, specifier: "%.2f")")
                                .foregroundColor(Color.theme.accent)
                            
                        }
                    }
                } 
                    .listStyle(.insetGrouped)
            }
                .navigationTitle("Crypto Prices")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        CoinAPI().getAPI() { (data) in
                            self.data = data
                        } } , label: {
                        Image(systemName: "repeat.circle.fill").font(.system(size: 20))
                    })
                    }
                    }
            }
            .onAppear() {
                CoinAPI().getAPI() { (data) in
                self.data = data
            }
               
        }

    }
}

struct CoinExchangeData: View {
    let exchange: ExchangeModel
    
    var body: some View {
        VStack{
            List {
                Section(header: Text("\(exchange.name ?? "")")) {
                    HStack {
                        Text("Trust Score")
                        Spacer()
                        Text("\(exchange.trustScore ?? 0)").foregroundColor(Color.theme.accent)
                    }
                    HStack{
                        Text("Trade Volume 24H")
                        Spacer()
                        Text("\(exchange.tradeVolume24HBtc ?? 0)").foregroundColor(Color.theme.accent)
                    }
                }
                
                Section(header: Text("\(exchange.name ?? "")")) {
                    HStack{
                        let IntValue = exchange.yearEstablished ?? 0
                    Text("Year established")
                    Spacer()
                    Text(String(IntValue)).foregroundColor(Color.theme.accent)
                    }
                    
                    HStack{
                    Text("Country")
                    Spacer()
                    Text("\(exchange.country ?? "No country found")").foregroundColor(Color.theme.accent)
                    }
                    
                    
                }
            }
        }
    }
}



struct CoinDetailedData: View {
    let coin: CoinModel

    var body: some View {
        
        VStack {
            List {
                
                
                Section(header: Text("\(coin.name ?? "")")) {

                    HStack {
                        Text("Market Cap")
                        Spacer()
                        Text("€\(coin.marketCap ?? 0)").foregroundColor(Color.theme.accent)
                    }
                    HStack {
                        Text("Fully Diluted Valuation")
                        Spacer()
                        Text("€\(coin.fullyDilutedValuation ?? 0)").foregroundColor(Color.theme.accent)
                    }
                }
                Section(header: Text("24-hour Price Data")) {
                    HStack {
                        Text("24-Hour High")
                        Spacer()
                        Text("€\(coin.high24H ?? 0.0, specifier: "%.2f")").foregroundColor(Color.theme.accent)
                    }
                    HStack {
                        Text("24-Hour Low")
                        Spacer()
                        Text("€\(coin.low24H ?? 0.0, specifier: "%.2f")").foregroundColor(Color.theme.accent)
                    }
                    if coin.priceChange24H ?? 0 < 0.0 {
                        HStack {
                            Text("Price Change 24h")
                            Spacer()
                            Image(systemName: "arrow.down")
                                .foregroundColor(.red)
                            Text("€\(coin.priceChange24H ?? 0, specifier: "%.2f")")
                                .foregroundColor(.red)
                        }

                    } else if coin.priceChange24H ?? 0 > 0.0 {
                        HStack {
                            Text("Price Change 24h")
                            Spacer()
                            Image(systemName: "arrow.up")
                                .foregroundColor(.green)
                            Text("€\(coin.priceChange24H ?? 0, specifier: "%.2f")")
                                .foregroundColor(.green)
                        }
                    }

                    if coin.priceChangePercentage24H ?? 0 < 0.0 {
                        HStack {
                            Text("Price Change % 24h")
                            Spacer()
                            Image(systemName: "arrow.down")
                                .foregroundColor(.red)
                            Text("\(coin.priceChangePercentage24H ?? 0, specifier: "%.2f")%")
                                .foregroundColor(.red)
                        }
                    } else if coin.priceChangePercentage24H ?? 0 > 0.0 {
                        HStack {
                            Text("Price Change % 24h")
                            Spacer()
                            Image(systemName: "arrow.up")
                                .foregroundColor(.green)
                            Text("\(coin.priceChangePercentage24H ?? 0, specifier: "%.2f")%")
                                .foregroundColor(.green)
                        }
                    }
                }
              

                Section(header: Text("Supply Data")) {
                    HStack {
                        Text("Circulating Supply")
                        Spacer()
                        Text("\(coin.circulatingSupply ?? 0, specifier: "%.0f")").foregroundColor(Color.theme.accent)
                        Text("\(coin.symbol ?? "")").foregroundColor(Color.yellow)
                    }
                    HStack {
                        Text("Total Supply")
                        Spacer()
                        Text("\(coin.totalSupply ?? 0, specifier: "%.0f")").foregroundColor(Color.theme.accent)
                        Text("\(coin.symbol ?? "")").foregroundColor(Color.yellow)
                    }
                }
                
                Section(header: Text("Historical Data")) {
                    HStack {
                        Text("All Time Price")
                        Spacer()
                        Text("€\(coin.ath ?? 0.0, specifier: "%.2f")").foregroundColor(Color.theme.accent)
                    }
                    if coin.priceChangePercentage24H ?? 0 < 0.0 {
                        HStack {
                            Text("All Time high % Change:")
                            Spacer()
                            Text("\(coin.athChangePercentage ?? 0.0, specifier: "%.2f")%")
                                .foregroundColor(.red)
                        }
                    } else if coin.priceChangePercentage24H ?? 0 < 0.0 {
                        HStack {
                            Text("All Time high % Change:")
                            Spacer()
                            Text("\(coin.athChangePercentage ?? 0.0, specifier: "%.2f")%")
                                .foregroundColor(.red)
                        }
                    }
                }
                
                Section(header: Text("Market Cap Change")) {
                    if coin.marketCapChange24H ?? 0 < 0.0 {
                        HStack {
                            Text("Market Cap 24H Change")
                            Spacer()
                            Image(systemName: "arrow.down")
                                .foregroundColor(.red)
                            Text("€\(coin.marketCapChange24H ?? 0, specifier: "%.0f")")
                                .foregroundColor(.red)
                        }
                    } else if coin.marketCapChange24H ?? 0 > 0.0 {
                        HStack {
                            Text("Market Cap 24H Change")
                            Spacer()
                            Image(systemName: "arrow.up")
                                .foregroundColor(.green)
                            Text("€\(coin.marketCapChange24H ?? 0,specifier: "%.0f")")
                                .foregroundColor(.green)
                        }
                    }
                    if coin.marketCapChangePercentage24H ?? 0 > 0.0 {
                        HStack {
                            Text("24H %")
                            Spacer()
                            Image(systemName: "arrow.up")
                                .foregroundColor(.green)
                            Text("\(coin.marketCapChangePercentage24H ?? 0, specifier: "%.2f")%")
                                .foregroundColor(.green)
                        }
                    } else if coin.marketCapChangePercentage24H ??  0 < 0.0 {
                        HStack {
                            Text("24H %")
                            Spacer()
                            Image(systemName: "arrow.down")
                                .foregroundColor(.red)
                            Text("\(coin.marketCapChangePercentage24H ?? 0, specifier: "%.2f")%")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
        }
    }
}
    struct Model : Identifiable {
        var id : Int
        var name : String
        var modelNmae: String
        var details : String
    }

    struct ModelView: View {
        
        @State var models = [
            Model(id: 0, name: "Bitcoin", modelNmae: "btc.usdz", details: "Bitcoin is a decentralized digital currency that you can buy, sell and exchange directly, without an intermediary like a bank. Bitcoin’s creator, Satoshi Nakamoto, originally described the need for “an electronic payment system based on cryptographic proof instead of trust.Every Bitcoin transaction that’s ever been made exists on a public ledger accessible to everyone, making transactions hard to reverse and difficult to fake. That’s by design: Core to their decentralized nature, Bitcoins aren’t backed by the government or any issuing institution, and there’s nothing to guarantee their value besides the proof baked in the heart of the system.The reason why it’s worth money is simply that we, as people, decided it has value—same as gold,” says Anton Mozgovoy, co-founder & CEO of digital financial service company Holyheld. Since its public launch in 2009, Bitcoin has risen dramatically in value. Although it once sold for under $150 per coin, as of  June 8, 1 BTC equals around $30,200. Because its supply is limited to 21 million coins, many expect its price to only keep rising as time goes on, especially as more large institutional investors begin treating it as a sort of digital gold to hedge against market volatility and inflation. Currently, there are more than 19 million coins in circulation."),
            Model(id: 1, name: "Ethereum", modelNmae: "Ethereum_coin.usdz", details: "Ethereum is a decentralized global software platform powered by blockchain technology. It is most commonly known for its native cryptocurrency, ether, or ETH.Ethereum can be used by anyone to create any secured digital technology. It has a token designed for use in the blockchain network, but it can also be used by participants as a method to pay for work done on the blockchain.Ethereum is designed to be scalable, programmable, secure, and decentralized. It is the blockchain of choice for developers and enterprises that are creating technology based upon it to change the way many industries operate and how we go about our daily lives.It natively supports smart contracts, the essential tool behind decentralized applications.Many decentralized finance (DeFi) and other applications use smart contracts in conjunction with blockchain technology.Learn more about Ethereum, its token ETH, and how they are an integral part of non-fungible tokens, decentralized finance, decentralized autonomous organizations, and the metaverse. "), Model(id: 2, name: "Komodo Coin", modelNmae: "Komodo.usdz", details: "Komodo Coin or Komodo (KMD) is a privacy-oriented decentralized cryptocurrency that promises to be safer, faster and easy to operate using its own ecosystem. It is said to combine the security of Bitcoin and the privacy of Zcash. It works on the delayed Proof of Work principle. The Komodo coin was created in 2016 and has a present market cap of over $116 million (as of July 7, 2021). Keep reading to know more about Komodo Coin crypto price and where to buy Komodo Coin.At the time of compiling this report, the Komodo (KMD) coin price is $0.9016 (06:12 PM IST, July 7, 2021). The price of the Komodo coin is up by 30% from yesterday, as the high/low price of the KMD coin on July 6, 2021, was $0.7995/$0.5948. However, the current price is much lesser than the 90d high price which was $4.71 on April 8, 2021. The lowest price of KMD was recorded in October 2020, when the cryptocurrency touched about $0.3773.Komodo Coin KMD can be bought on a crypto exchange like WazirX and Bitbns. In order to buy Komodo Coin, one will have to create an account on the above exchanges. The process of account creation asks for basic details of the investor, such as name and bank account details. For the verification process, one might need to upload Pan Card. Once the verification is done, Komodo Coin can be bought using a credit or a debit card with sufficient funds. Websites and experts predict the price of Komodo Coin based on its past performance. Wallet Investor predicts the Komodo Coin price to go up to $0.945 in the coming year. A five-year prediction from the same websites claims the rise of Komodo Coin as high as $2.396. However, these are just predictions and they might or might not be true in due course of time. Another website called Digital Coin Price predicts the price of Komodo Coin to reach as high as $1.38 in 2021, $1.56 in 2022 and $2.73 by the year 2025."),  Model(id: 3, name: "GALA", modelNmae: "GALA.usdz", details: "The GALA token is the digital utility token of the Gala Games ecosystem. GALA can be used as the medium of exchange between participants in the ecosystem and to purchase digital assets, including NFTs. The project aims to create an environment where gamers retain full ownership of their in-game items, in contrast to the current centralized system where players lose their in-game items when banned or when platforms shut down. NFTs used in-game exist on the Ethereum network and are entirely separate from Gala Games.")

        ]
        
        @State var index = 0
        
        var body: some View {
            NavigationView {
          VStack{
                SceneView(scene: SCNScene(named: models[index].modelNmae), options: [.autoenablesDefaultLighting, .allowsCameraControl])
                  .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
                ZStack {
                    HStack{
                        Button(action: {
                            withAnimation{
                                if index > 0 {
                                    index -= 1
                                }
                                    
                            }
                        }, label: {
                            Image(systemName: "arrow.backward.circle").font(.system(size: 35, weight: .bold)).foregroundColor(Color.theme.accent)
                                .opacity(index == 0 ? 0.3 : 1)
                        })
                        .disabled(index == 0 ? true : false)
                        
                        Spacer(minLength: 0)
                        
                        Button(action: {
                            withAnimation{
                                if index < models.count {
                                    index += 1
                                }
                                    
                            }
                        }, label: {
                            Image(systemName: "arrow.right.circle").font(.system(size: 35, weight: .bold)).foregroundColor(Color.theme.accent)
                                .opacity(index == models.count - 1 ? 0.3 : 1)
                        }).disabled(index == models.count - 1 ? true : false)
                    }
                    Text(models[index].name)
                        .font(.system(size: 45, weight: .bold))
                        
                }
                .padding(.horizontal)
                .padding(.vertical,30)
                
                VStack (alignment: .leading, spacing: 15, content: {
                    
                    Text("About")
                        .font(.title2)
                        .fontWeight(.bold)
                       
                    ScrollView{
                    Text(models[index].details)
                        .foregroundColor(Color.theme.accent)
                    }
                    
                })
                .padding(.horizontal)
                Spacer(minLength: 0)
                
          }
          .navigationTitle("3D Models")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {}, label: {
                            Image(systemName: "repeat.circle.fill").font(.system(size: 20))
                        })
                        }
                     
                        
                        }
            
            }
               
        }
    }
