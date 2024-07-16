//
//  GamesView.swift
//  App675
//
//  Created by IGOR on 16/07/2024.
//

import SwiftUI

struct GamesView: View {
    
    @StateObject var viewModel = GamesViewModel()
    
    var body: some View {

        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                Text("My Games")
                    .foregroundColor(.black)
                    .font(.system(size: 29, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    
                    VStack {
                        
                        VStack {
                            
                            Text("\(viewModel.gms)")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 20, weight: .semibold))
                            
                            Text("Games")
                                .foregroundColor(.black.opacity(0.6))
                                .font(.system(size: 13, weight: .regular))
                            
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 70)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.white).shadow(color: .gray.opacity(0.3), radius: 2))
                        
                        VStack {
                            
                            Text("\(viewModel.ach)")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 20, weight: .semibold))
                            
                            Text("Achievements")
                                .foregroundColor(.black.opacity(0.6))
                                .font(.system(size: 13, weight: .regular))
                        }
                        .padding()
                        .frame(height: 70)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.white).shadow(color: .gray.opacity(0.3), radius: 2))
                    }
                    
                    VStack(spacing: 10) {
                        
                        Image("stick")
                        
                        Text("Add a game")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .medium))
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = true
                            }
                            
                        }, label: {
                            
                            Text("+")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 36)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color("prim")))
                        })
                        
                    }
                    .padding()
                    .frame(height: 145)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).fill(.white).shadow(color: .gray.opacity(0.3), radius: 2))
                }
                
                HStack {
                    
                    Text("List of games")
                        .foregroundColor(.black)
                        .font(.system(size: 24, weight: .semibold))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd = true
                        }
                        
                    }, label: {
                        
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .medium))
                    })
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack {
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddCat = true
                            }
                            
                        }, label: {
                            
                            Image(systemName: "pencil")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 16, weight: .regular))
                                .frame(width: 55, height: 40)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(Color("prim")))
                                .padding(1)
                        })
                        
                        ForEach(viewModel.categories, id: \.self) { index in
                            
                            Button(action: {
                                
                                viewModel.currentCategory = index
                                viewModel.fetchGames()
                                
                            }, label: {
                                
                                Text(index)
                                    .foregroundColor(viewModel.currentCategory == index ? .white : Color("prim"))
                                    .font(.system(size: 13, weight: .medium))
                                    .frame(height: 40)
                                    .padding(.horizontal)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color("prim").opacity(viewModel.currentCategory == index ? 1 : 0)))
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color("prim").opacity(viewModel.currentCategory == index ? 0 : 1)))
                            })
                        }
                    }
                }
                .frame(height: 50)
                .padding(.bottom)
                
                if viewModel.games.isEmpty {
                    
                    VStack {
                        
                        Image("Raketa")
                        
                        Text("Rather, add your first game")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .medium))
                        
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 230)
                    .background(RoundedRectangle(cornerRadius: 25.0).fill(.white).shadow(radius: 2))
                    
                    Spacer()
                    
                } else {
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                        
                        ForEach(viewModel.games, id: \.self) { index in
                            
                            VStack(alignment: .leading, spacing: 8) {
                                
                                Image(index.gPhoto ?? "")
                                    .resizable()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 180)
                                    .cornerRadius(25)
                                    .overlay(
                                    
                                        VStack {
                                            
                                            HStack {
                                                
                                                Spacer()
                                                
                                                Text(index.gCat ?? "")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 13, weight: .regular))
                                                    .padding(4)
                                                    .padding(.horizontal, 5)
                                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color("prim")))
                                                
                                            }
                                            
                                            Spacer()
                                        }
                                            .padding(8)
                                    )
                                
                                Text(index.gName ?? "")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16, weight: .medium))
                                
                                Text(index.gAch ?? "")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 16, weight: .medium))
                                
                            }
                        }
                        
                    })
                }
            }
            }
            .padding()
        }
        .onAppear{
            
            viewModel.fetchGames()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddGame(viewModel: viewModel)
        })
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isAddCat ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddCat = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddCat = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text("Add a category")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold))
                        .padding()

                    ZStack(alignment: .leading, content: {
                        
                        Text("Enter")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.ccForAdd.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.ccForAdd)
                            .foregroundColor(Color.white)
                            .font(.system(size: 14, weight: .semibold))
                        
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg3")))

                    HStack {
                        
                        Button(action: {
                            
                            viewModel.categories.append(viewModel.ccForAdd)
                            viewModel.ccForAdd = ""
                   
                            withAnimation(.spring()) {
                                
                                viewModel.isAddCat = false
                                
                            }
                            
                        }, label: {
                            
                            Text("Save")
                                .foregroundColor(.green)
                                .font(.system(size: 18, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                            
                        })
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddCat = false
                            }
                            
                        }, label: {
                            
                            Text("Close")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                            
                        })
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                .padding()
                .offset(y: viewModel.isAddCat ? 0 : UIScreen.main.bounds.height)
            }
        )
    }
}

#Preview {
    GamesView()
}
