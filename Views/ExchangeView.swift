//
//  ExchangeView.swift
//  CT_AR
//
//  Created by Giovanni Cavaliere on 09/09/22.
//

import Foundation
import SwiftUI

struct ExchangesView: View {
    @State var data: [ExchangeModel]?
    
    let tmp = ExchangeModel.init(id: "", name: "", yearEstablished: 0, country: "", url: "", image: "", trustScore: 0, trustScoreRank: 0, tradeVolume24HBtc: 0, tradeVolume24HBtcNormalized: 0.0)
    var body: some View {
        NavigationView {
            List {
                ForEach(data ?? [tmp], id: \.self) { item in NavigationLink(destination: CoinExchangeData(exchange: item)) {
                    HStack {
                        Text("\(item.trustScoreRank ?? 0)")
                        AsyncImage(url: URL(string: "\(item.image ?? "")")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                            .frame(width: 20, height: 20)
                        VStack(alignment: .leading) {
                            Text("\(item.name ?? "")")
                                .font(.headline)
                                .foregroundColor(Color.theme.accent)
                          
                        }
                        Spacer()
                        VStack {
                            Text("₿\(item.tradeVolume24HBtcNormalized ?? 0, specifier: "%.0f")").foregroundColor(Color.theme.accent)
                        }
                        
                      
                    }
                }
                }
            }
                .navigationBarTitle("Exchanges")
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
            .onAppear() {
            ExchangeAPICall().getAPI { (data) in
                self.data = data
            }
        }
    }
}

struct ExchangesView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangesView( )
    }
}
