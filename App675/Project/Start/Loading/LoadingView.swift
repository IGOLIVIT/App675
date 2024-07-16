//
//  LoadingView.swift
//  App675
//
//  Created by IGOR on 11/07/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {

        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                Image("Llogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(10)
            }
            
            VStack {
                
                Spacer()
                
                ProgressView()
                    .padding(.bottom, 90)
            }
        }
    }
}

#Preview {
    LoadingView()
}
