//
//  SettingsView.swift
//  App675
//
//  Created by IGOR on 16/07/2024.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    var body: some View {

        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                Text("Settings")
                    .foregroundColor(.black)
                    .font(.system(size: 29, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack {
                        
                        HStack {
                            
                            Button(action: {
                                
                                SKStoreReviewController.requestReview()
                                
                            }, label: {
                                
                                VStack {
                                    
                                    Image("Raketa")
                                    
                                    Text("Rate Us")
                                        .foregroundColor(.black)
                                        .font(.system(size: 16, weight: .medium))
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 130)
                                .background(RoundedRectangle(cornerRadius: 15).fill(.white).shadow(radius: 2))
                                .padding(3)
                            })
                            
                            Button(action: {
                                
                                guard let url = URL(string: "https://www.termsfeed.com/live/7fe1d056-5d0c-468b-b065-56eb3ad4b6a2") else { return }
                                
                                UIApplication.shared.open(url)
                                
                            }, label: {
                                
                                VStack {
                                    
                                    Image("joystick")
                                    
                                    Text("Usage Policy")
                                        .foregroundColor(.black)
                                        .font(.system(size: 16, weight: .medium))
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 130)
                                .background(RoundedRectangle(cornerRadius: 15).fill(.white).shadow(radius: 2))
                                .padding(3)
                            })
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    SettingsView()
}
