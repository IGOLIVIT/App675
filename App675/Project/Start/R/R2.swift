//
//  R2.swift
//  App675
//
//  Created by IGOR on 16/07/2024.
//

import SwiftUI

struct R2: View {
    
    @AppStorage("status") var status: Bool = false

    var body: some View {

        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                Image("R2")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    
                    Text("Create and edit whenever you want")
                        .foregroundColor(.black)
                        .font(.system(size: 28, weight: .semibold))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    HStack {
                        
                        Spacer()
                        
                        Circle()
                            .fill(.black.opacity(0.3))
                            .frame(height: 8)
                        
                        Circle()
                            .fill(.black)
                            .frame(height: 8)

                        Spacer()
                        
                        Button(action: {
                            
                            status = true
                            
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
    R2()
}
