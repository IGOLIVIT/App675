//
//  AddGame.swift
//  App675
//
//  Created by IGOR on 16/07/2024.
//

import SwiftUI

struct AddGame: View {

    @StateObject var viewModel: GamesViewModel
    @Environment(\.presentationMode) var router
    @State var value: CGFloat = 0
    
    var body: some View {

        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Button(action: {
                        
                        router.wrappedValue.dismiss()
                        
                    }, label: {
                        
                        HStack {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .regular))
                            
                            Text("Back")
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .regular))
                        }
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        
                        viewModel.gms += 1
                        
                        viewModel.gEv = String("\(value)")
                        viewModel.gPhoto = viewModel.currentPhoto
                        viewModel.gCat = viewModel.currentCategory
                        
                        viewModel.addGame()
                        
                        viewModel.currentCategory = ""
                        viewModel.currentPhoto = ""
                        value = 0
                        viewModel.gName = ""
                        viewModel.gHours = ""
                        viewModel.gAch = ""
                        viewModel.gBeg = ""
                        viewModel.gEnd = ""
                        
                        viewModel.fetchGames()
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd = false
                        }
                        
                    }, label: {
                        
                        Text("Save")
                            .foregroundColor(Color.green)
                            .font(.system(size: 16, weight: .regular))
                        
                    })
                    .opacity(viewModel.gName.isEmpty || viewModel.gHours.isEmpty || viewModel.gAch.isEmpty ? 0.5 : 1)
                    .disabled(viewModel.gName.isEmpty || viewModel.gHours.isEmpty || viewModel.gAch.isEmpty ? true : false)
                }
                .padding(.vertical)

                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 10) {
                        
                        Menu(content: {
                            
                            ForEach(viewModel.photos, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.currentPhoto = index
                                    
                                }, label: {
                                    
                                    Image(index)
                                })
                            }
                            
                        }, label: {
                            
                            if viewModel.currentPhoto.isEmpty {
                                
                                Image(systemName: "photo")
                                    .foregroundColor(Color("prim"))
                                    .font(.system(size: 50, weight: .regular))
                                    .frame(width: 170, height: 200)
                                    .background(RoundedRectangle(cornerRadius: 30).stroke(Color("prim")))
                                    .padding(1)
                                
                            } else {
                                
                                Image(viewModel.currentPhoto)
                                    .resizable()
                                    .frame(width: 170, height: 200)
                                    .cornerRadius(30)
                            }
                            
                        })
                        .padding(.bottom)
                        
                        Text("Name")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 1) {
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Text")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.gName.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.gName)
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 14, weight: .semibold))
                                
                            })
                            .padding()
                            .frame(maxWidth: .infinity)
                         
                            Rectangle()
                                .fill(.gray)
                                .frame(maxWidth: .infinity)
                                .frame(height: 1)
                        }
                        .padding(.bottom)

                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack {

                                ForEach(viewModel.categories, id: \.self) { index in
                                
                                    Button(action: {
                                        
                                        viewModel.currentCategory = index
                                        
                                    }, label: {
                                        
                                        Text(index)
                                            .foregroundColor(viewModel.currentCategory == index ? .white : Color("prim"))
                                            .font(.system(size: 13, weight: .medium))
                                            .frame(height: 40)
                                            .padding(.horizontal)
                                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("prim").opacity(viewModel.currentCategory == index ? 1 : 0)))
                                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color("prim").opacity(viewModel.currentCategory == index ? 0 : 1)))
                                            .padding(1)
                                    })
                                }
                            }
                        }
                        .frame(height: 50)
                        
                        Text("Evaluation")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 10) {
                            
                            Slider(value: $value, in: 1...10, step: 1, label: {})
                            
                            HStack {
                                
                                Text("\(String(format: "%2.f", value))")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                
                                Spacer()
                                
                                Text("10")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                            }
   
                        }
                        .padding(4)
                        
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 12) {
                                
                                Text("Hours")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16, weight: .regular))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                VStack(spacing: 1) {
                                    
                                    ZStack(alignment: .leading, content: {
                                        
                                        Text("Text")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 14, weight: .regular))
                                            .opacity(viewModel.gHours.isEmpty ? 1 : 0)
                                        
                                        TextField("", text: $viewModel.gHours)
                                            .foregroundColor(Color.black)
                                            .font(.system(size: 14, weight: .semibold))
                                        
                                    })
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    
                                    Rectangle()
                                        .fill(.gray)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 1)
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                
                                Text("Achievements")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16, weight: .regular))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                VStack(spacing: 1) {
                                    
                                    ZStack(alignment: .leading, content: {
                                        
                                        Text("Text")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 14, weight: .regular))
                                            .opacity(viewModel.gAch.isEmpty ? 1 : 0)
                                        
                                        TextField("", text: $viewModel.gAch)
                                            .foregroundColor(Color.black)
                                            .font(.system(size: 14, weight: .semibold))
                                        
                                    })
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    
                                    Rectangle()
                                        .fill(.gray)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 1)
                                }
                            }
                        }
                        .padding(.bottom)
                        
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 12) {
                                
                                Text("Beginning")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16, weight: .regular))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                VStack(spacing: 1) {
                                    
                                    ZStack(alignment: .leading, content: {
                                        
                                        Text("Text")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 14, weight: .regular))
                                            .opacity(viewModel.gBeg.isEmpty ? 1 : 0)
                                        
                                        TextField("", text: $viewModel.gBeg)
                                            .foregroundColor(Color.black)
                                            .font(.system(size: 14, weight: .semibold))
                                        
                                    })
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    
                                    Rectangle()
                                        .fill(.gray)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 1)
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                
                                Text("Ending")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16, weight: .regular))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                VStack(spacing: 1) {
                                    
                                    ZStack(alignment: .leading, content: {
                                        
                                        Text("Text")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 14, weight: .regular))
                                            .opacity(viewModel.gEnd.isEmpty ? 1 : 0)
                                        
                                        TextField("", text: $viewModel.gEnd)
                                            .foregroundColor(Color.black)
                                            .font(.system(size: 14, weight: .semibold))
                                        
                                    })
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    
                                    Rectangle()
                                        .fill(.gray)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 1)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    AddGame(viewModel: GamesViewModel())
}
