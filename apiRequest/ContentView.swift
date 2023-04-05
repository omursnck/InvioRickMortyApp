//
//  ContentView.swift
//  apiRequest
//
//  Created by Ömür Şenocak on 7.03.2023.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @StateObject var viewModel = rmVM()
    @State var choosenPlanet: String = ""
    @State private var currentProgress = 0.0
    
    @State var isButtonOn: Bool = false
    @State var isLoading: Bool = false
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var filteredCharacters: [Characters.Result] {
        viewModel.charactersArray.filter { $0.location.name == choosenPlanet }
    }
    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        
        NavigationView{
            
            
            
            VStack{
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack{
                        //All button
                        Button(action: {
                            choosenPlanet = ""
                            
                        }, label: {
                            Text("All")
                                .padding(.horizontal,30)
                                .foregroundColor(Color.white)
                                .bold()
                        })
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 50, style: .continuous).fill(choosenPlanet=="" ? Color.green : Color.blue)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 50, style: .continuous)
                                .strokeBorder(Color.blue, lineWidth: 1)
                        )
                        
                        if isLoading{
                            ForEach(viewModel.locationArray, id: \.self) { location in
                                Button(action: {
                                    choosenPlanet = location.name
                                    print(choosenPlanet)
                                    
                                    
                                }, label: {
                                    
                                    Text(location.name)                                    .padding(.horizontal,30)
                                        .foregroundColor(Color.white)
                                        .bold()
                                    
                                })
                                
                                
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 50, style: .continuous).fill(choosenPlanet == location.name ? Color.green : Color.blue)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50, style: .continuous)
                                        .strokeBorder(Color.blue, lineWidth: 1)
                                )
                                
                                
                                
                            }.padding(5)
                            
                            Button(action: {
                                //
                                
                            }, label: {
                                ProgressView("Loading...")
                                    .progressViewStyle(CircularProgressViewStyle())
                                
                                    .padding(.horizontal,30)
                                    .foregroundColor(Color.white)
                                    .bold()
                            })
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 50, style: .continuous).fill(choosenPlanet=="" ? Color.green : Color.green)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 50, style: .continuous)
                                    .strokeBorder(Color.blue, lineWidth: 1)
                            )
                            
                            
                            
                        }
                        else {
                            ForEach(viewModel.locationArray, id: \.self) { location in
                                Button(action: {
                                    choosenPlanet = location.name
                                    print(choosenPlanet)
                                    
                                    
                                }, label: {
                                    
                                    Text(location.name)                                    .padding(.horizontal,30)
                                        .foregroundColor(Color.white)
                                        .bold()
                                        .onAppear{
                                            //   print(location.id , location.name, "loaded")
                                            
                                            
                                            
                                            if location.id % (viewModel.count * 20) == 0 && viewModel.count <= 5 {
                                                
                                                
                                                viewModel.count += 1
                                                
                                                
                                                print("next page of locations loaded , \(viewModel.count)")
                                                isLoading = true
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 3 ){
                                                    
                                                    
                                                    print("ProgressView loaded")
                                                    
                                                    isLoading = false
                                                }
                                                
                                                Task {
                                                    await viewModel.updateLocationData()
                                                    
                                                    self.viewModel.locationArray += viewModel.updatedLocationArray
                                                    
                                                }
                                            }
                                            
                                        }
                                })
                                
                                
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 50, style: .continuous).fill(choosenPlanet == location.name ? Color.green : Color.blue)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50, style: .continuous)
                                        .strokeBorder(Color.blue, lineWidth: 1)
                                )
                                
                                
                                
                            }.padding(5)
                        }
                        
                        
                    }            .frame( height: 80)
                    
                        .padding(.horizontal)
                        .padding(.top)
                }
                
                if choosenPlanet.isEmpty{
                    
                    
                    
                    List(viewModel.charactersArray, id: \.self, rowContent: { chars in
                        NavigationLink(destination: {
                            
                            CharacterCell(charItem: chars)
                            
                        }, label: {
                            
                            VStack(alignment: .leading) {
                                HStack{
                                    
                                    
                                    KFImage(URL(string: chars.image))
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 90, height: 90)
                                        .clipShape(Circle())
                                        .padding(.trailing)
                                    
                                    VStack(alignment: .leading){
                                        Text(chars.name)
                                            .bold()
                                        VStack (alignment: .leading){
                                            
                                            
                                            if chars.gender == "Female"{
                                                HStack{
                                                    
                                                    Text(chars.gender)
                                                        .foregroundColor(.pink)
                                                    Image(colorScheme == .dark ? "female-white" : "female")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 20, height: 20)
                                                    
                                                }
                                            }
                                            
                                            else if chars.gender == "Male"{
                                                HStack{
                                                    
                                                    Text(chars.gender)
                                                        .foregroundColor(.blue)
                                                    Image(colorScheme == .dark ? "male-white" : "male")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 20, height: 20)
                                                    
                                                    
                                                }
                                                
                                            }
                                            else{
                                                HStack{
                                                    
                                                    Text(chars.gender)
                                                        .foregroundColor(.green)
                                                    Image(colorScheme == .dark ? "alien-white" : "alien")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 20, height: 20)
                                                    
                                                    
                                                }
                                            }
                                            
                                        }.font(.system(size: 14, weight: .light))
                                    }
                                    
                                    Spacer()
                                    Text(chars.species)
                                        .font(.footnote)
                                    
                                    
                                    
                                }
                                
                            }.onAppear(){
                                
                                if chars.id % (viewModel.characterCount * 20) == 0 && viewModel.characterCount <= 40 {
                                    
                                    
                                    isLoading = true
                                    
                                    viewModel.characterCount += 1
                                    
                                    print("next page of characters loaded , \(viewModel.characterCount)")
                                    
                                    Task {
                                        await viewModel.updateData()
                                        self.viewModel.charactersArray += viewModel.updatedCharactersArray
                                        
                                        
                                        
                                        isLoading = false
                                    }
                                    
                                }
                                
                                
                            }
                        })
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    })
                }else{
                    List(filteredCharacters, id: \.self) { filteredChar in
                        NavigationLink(destination: {
                            
                            
                            CharacterCell(charItem: filteredChar)
                            
                            
                        }, label: {
                            HStack{
                                
                                VStack(alignment: .leading) {
                                    HStack{
                                        
                                        
                                        KFImage(URL(string: filteredChar.image))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 90, height: 90)
                                            .clipShape(Circle())
                                            .padding(.trailing)
                                        
                                        VStack(alignment: .leading){
                                            Text(filteredChar.name)
                                                .bold()
                                            VStack (alignment: .leading){
                                                
                                                
                                                if filteredChar.gender == "Female"{
                                                    HStack{
                                                        
                                                        Text(filteredChar.gender)
                                                            .foregroundColor(.pink)
                                                        Image(colorScheme == .dark ? "female-white" : "female")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 20, height: 20)
                                                        
                                                    }
                                                }
                                                
                                                else if filteredChar.gender == "Male"{
                                                    HStack{
                                                        
                                                        Text(filteredChar.gender)
                                                            .foregroundColor(.blue)
                                                        Image(colorScheme == .dark ? "male-white" : "male")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 20, height: 20)
                                                        
                                                        
                                                    }
                                                    
                                                }
                                                else{
                                                    HStack{
                                                        
                                                        Text(filteredChar.gender)
                                                            .foregroundColor(.green)
                                                        Image(colorScheme == .dark ? "alien-white" : "alien")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 20, height: 20)
                                                        
                                                        
                                                    }
                                                }
                                                
                                            }.font(.system(size: 14, weight: .light))
                                        }
                                        
                                        Spacer()
                                        Text(filteredChar.species)
                                            .font(.footnote)
                                        
                                        
                                        
                                    }
                                    
                                }
                            }
                        })
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        
                    }            .overlay(Group {
                        if filteredCharacters.isEmpty {
                            Text("Oops, looks like there's nothing to see here...")
                        }
                    })
                    
                }
                
                
                
            } .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        Image("logo1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                
            }
            
        }
        .task {
            await viewModel.getData()
            await viewModel.getLocationData()
            await viewModel.getEpisodeData()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
