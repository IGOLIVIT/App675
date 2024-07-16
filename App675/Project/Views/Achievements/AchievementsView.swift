//
//  AchievementsView.swift
//  App675
//
//  Created by IGOR on 16/07/2024.
//

import SwiftUI

struct AchievementsView: View {

    @StateObject var viewModel = GamesViewModel()
    
    var body: some View {

        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                Text("Achievements")
                    .foregroundColor(.black)
                    .font(.system(size: 29, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
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
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    LazyHStack {
                        
                        ForEach(viewModel.games, id: \.self) { index in
                        
                            HStack {
                                
                                Image(index.gPhoto ?? "")
                                    .resizable()
                                    .frame(maxHeight: .infinity)
                                    .frame(width: 110)
                                    .cornerRadius(20)
                                
                                VStack(alignment: .leading) {
                                    
                                    Text(index.gName ?? "")
                                        .foregroundColor(.black)
                                        .font(.system(size: 16, weight: .regular))
                                    
                                    Text("\(index.gAch ?? "") achievements")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 15, weight: .regular))
                                    
                                    Text("Evaluation")
                                        .foregroundColor(.black)
                                        .font(.system(size: 12, weight: .regular))
                                    
                                    ZStack {
                                        
                                        HStack {
                                            
                                            RoundedRectangle(cornerRadius: 5)
                                                .fill(Color("prim"))
                                                .frame(height: 5)
                                                .frame(width: 120)
                                         
                                            Spacer()
                                        }
                                        
                                        RoundedRectangle(cornerRadius: 5)
                                            .fill(Color("prim").opacity(0.3))
                                            .frame(width: 150, height: 5)
                                        
                                    }
                                    .padding(4)
                                    
                                    Text("\(index.gEv ?? "")/10")
                                        .foregroundColor(.black)
                                        .font(.system(size: 12, weight: .regular))
                                }
                            }
                            .background(RoundedRectangle(cornerRadius: 20).fill(.white).shadow(radius: 2))
                            .padding(5)
                        }
                    }
                    .padding(3)
                }
                .frame(height: 150)
                
                HStack {
                    
                    Text("Participants")
                        .foregroundColor(.black)
                        .font(.system(size: 24, weight: .semibold))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddAch = true
                        }
                        
                    }, label: {
                        
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .medium))
                    })
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack {
                        
                        ForEach(viewModel.achievements, id: \.self) { index in
                        
                            HStack {
                                
                                Image(index.pPhoto ?? "")
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                
                                Text(index.pName ?? "")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16, weight: .medium))
                                
                                Spacer()
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(.white).shadow(radius: 3))
                            .padding(3)
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            
            viewModel.fetchGames()
        }
        .onAppear {
            
            viewModel.fetchAchievements()
        }
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isAddAch ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddAch = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddAch = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text("Participants")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                    
                    HStack {
                        
                        Menu(content: {
                            
                            ForEach(viewModel.AchPhotos, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.curAchPhoto = index
                                    
                                }, label: {
                                    
                                    Image(index)
                  
                                })
                            }
                            
                        }, label: {
                            
                            if viewModel.curAchPhoto.isEmpty {
                                
                                Image(systemName: "person")
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundColor(Color("prim"))
                                    .frame(width: 65, height: 65)
                                    .background(Circle().stroke(Color("prim")))
                                
                            } else {
                                
                                Image(viewModel.curAchPhoto)
                                    .resizable()
                                    .frame(width: 65, height: 65)
                                    .background(Circle().stroke(Color("prim")))
                            }
                            
                        })
                        
                        VStack(alignment: .leading) {
                            
                            Text("Name")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .regular))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.pName.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.pName)
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 14, weight: .semibold))
                                
                            })
                            .padding(12)
                            .frame(maxWidth: .infinity)
                            
                            Rectangle()
                                .fill(.gray)
                                .frame(maxWidth: .infinity)
                                .frame(height: 1)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                    }
                    .padding(.bottom)

                        Button(action: {
                            
                            viewModel.ach += 1
                            viewModel.pPhoto = viewModel.curAchPhoto
                            
                            viewModel.addAchievement()
                            
                            viewModel.curAchPhoto = ""
                            viewModel.pName = ""
                            
                            viewModel.fetchAchievements()
                   
                            withAnimation(.spring()) {
                                
                                viewModel.isAddAch = false
                                
                            }
                            
                        }, label: {
                            
                            Text("Save")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color("prim")))
                            
                        })
                        .opacity(viewModel.pName.isEmpty ? 0.5 : 1)
                        .disabled(viewModel.pName.isEmpty ? true : false)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                .padding()
                .offset(y: viewModel.isAddAch ? 0 : UIScreen.main.bounds.height)
            }
        )
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
    AchievementsView()
}
