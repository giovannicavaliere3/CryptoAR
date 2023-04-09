//
//  Stoaryboard view.swift
//  CT_AR
//
//  Created by Giovanni Cavaliere on 26/09/22.
//

import Foundation
import SwiftUI
import UIKit

struct videoView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVideoPlayer {
        return UIVideoPlayer()
    }
    func updateUIView(_ uiView: UIVideoPlayer, context: Context) {
        
    }
}

struct ContView: View {
    @Binding var isPressed: Bool
    var body: some View {
        
        ZStack {
            videoView().overlay(Color.gray.opacity(0.2))
                .blur(radius: 1)
                .edgesIgnoringSafeArea(.all)

        VStack {
            Spacer()
            Image(systemName: "bitcoinsign.circle.fill")
                               .resizable()
                               .frame(width: 70, height: 70)
                               .aspectRatio(contentMode: .fit)
                               .padding(.bottom, 30)
                               .foregroundColor(Color.theme.accent)
            
                Text("Crypto AR")
                                .font(.largeTitle)
                                .foregroundColor(Color.theme.accent)
                            Text("Discover the crypto prices and see the current price of the Bitcoin in AR")
                                
                                .frame(maxWidth: 320)
                                .padding(.top, 20)
                                .padding(.bottom, 50)
                                .foregroundColor(Color.theme.accent)
            Spacer()
                
        HStack {
                      
            Button(action: {
                isPressed = false
            }, label: {
                Text("Start")
                    .foregroundColor( Color.theme.accent)
                    .padding(20)
                    .background(Color.theme.background)
                    .clipShape(Capsule())
                  
                   
            })
                        
                       
                    }
        }
        }
    }
}


/*
struct CustomController : UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CustomController> ) -> UIViewController {
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "viewController")
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CustomController>) {
        
    }
}


struct storyboardView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "Home")
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
 */
