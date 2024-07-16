//
//  R1.swift
//  App675
//
//  Created by IGOR on 16/07/2024.
//

import SwiftUI

struct R1: View {
    var body: some View {

        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                Image("R1")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    
                    Text("All games and achievements in one app")
                        .foregroundColor(.black)
                        .font(.system(size: 28, weight: .semibold))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    HStack {
                        
                        Spacer()
                        
                        Circle()
                            .fill(.black)
                            .frame(height: 8)
                        
                        Circle()
                            .fill(.black.opacity(0.3))
                            .frame(height: 8)
                        
                        Spacer()
                        
                        NavigationLink(destination: {
                            
                            
                            R2()
                                .navigationBarBackButtonHidden()
                            
                        }, label: {
                            
                            Text("Next")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .regular))
                                .frame(width: 150, height: 50)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim")))
                        })
                    }
                    .padding(.horizontal, 30)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 160)
            }
        }
    }
}

#Preview {
    R1()
}
