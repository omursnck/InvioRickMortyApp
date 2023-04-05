//
//  CharacterCell.swift
//  apiRequest
//
//  Created by Ömür Şenocak on 7.03.2023.
//

import SwiftUI
import Kingfisher

struct CharacterCell: View {
    @StateObject var viewModel = rmVM()
    var charItem: Characters.Result
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    //   var episodeItem : Episode.Result
    var body: some View {
        //  NavigationView {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                KFImage(URL(string: charItem.image))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 275, height: 275)
                    .padding(.horizontal, 50)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text("Status:")
                        
                            .font(.custom("AvenirLTStd-Black", size: 22))
                            .padding(.trailing, 40)
                        
                        Text(charItem.status)
                            .font(.custom("AvenirLTStd-Roman", size: 22))
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text("Species:")
                            .font(.custom("AvenirLTStd-Black", size: 22))
                            .padding(.trailing, 27)
                        
                        Text(charItem.species)
                            .font(.custom("AvenirLTStd-Roman", size: 22))
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text("Gender:")
                            .font(.custom("AvenirLTStd-Black", size: 22))
                            .padding(.trailing, 28)
                        
                        Text(charItem.gender)
                            .font(.custom("AvenirLTStd-Roman", size: 22))
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text("Origin:")
                            .font(.custom("AvenirLTStd-Black", size: 22))
                            .padding(.trailing, 41)
                        
                        Text(charItem.origin.name)
                            .font(.custom("AvenirLTStd-Roman", size: 22))
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text("Location:")
                            .font(.custom("AvenirLTStd-Black", size: 22))
                            .padding(.trailing, 18)
                        
                        Text(charItem.location.name)
                            .font(.custom("AvenirLTStd-Roman", size: 22))
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    
                    HStack(alignment: .top) {
                        Text("Episodes:")
                            .font(.custom("AvenirLTStd-Black", size: 22))
                            .padding(.trailing, 15)
                        
                        Text("\(charItem.episode.map({ $0.split(separator: "/").last ?? "" }).joined(separator: ", "))")
                            .font(.custom("AvenirLTStd-Roman", size: 22))
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    
                    HStack {
                        Text("Created at (in API)")
                            .font(.custom("AvenirLTStd-Black", size: 22))
                            .padding(.trailing, 10)
                        
                        if let formattedString = charItem.created.convertISO8601ToFormattedString() {
                            Text("\(formattedString)")
                                .font(.custom("AvenirLTStd-Roman", size: 22))
                        }
                    }
                    
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
                
            }
            .padding(.horizontal, 20)
            
            
            Spacer()
        }.navigationTitle(charItem.name)
            .navigationBarTitleDisplayMode(.automatic)
        
            .task {
                await viewModel.getData()
                await viewModel.getLocationData()
                await viewModel.getEpisodeData()
                
            }
        
    }
}


struct CharacterCell_Previews: PreviewProvider {
    
    static var previews: some View {
        let sampleCharacter = Characters.Result(id: 1, name: "Ricky", status: "Alive", species: "Human", type: "", gender: "Male", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", episode: ["https://rickandmortyapi.com/api/episode/1", "https://rickandmortyapi.com/api/episode/2","https://rickandmortyapi.com/api/episode/1", "https://rickandmortyapi.com/api/episode/2","https://rickandmortyapi.com/api/episode/1", "https://rickandmortyapi.com/api/episode/2","https://rickandmortyapi.com/api/episode/1", "https://rickandmortyapi.com/api/episode/2","https://rickandmortyapi.com/api/episode/1", "https://rickandmortyapi.com/api/episode/2","https://rickandmortyapi.com/api/episode/1", "https://rickandmortyapi.com/api/episode/2","https://rickandmortyapi.com/api/episode/1", "https://rickandmortyapi.com/api/episode/2","https://rickandmortyapi.com/api/episode/1", "https://rickandmortyapi.com/api/episode/2"], url: "", created: "2017-11-04T18:48:46.250Z", origin: Characters.Result.Location(name: "asd", url: ""), location: Characters.Result.Location(name: "dsa", url: ""))
        
        CharacterCell(charItem: sampleCharacter)
    }
}

extension String {
    func convertISO8601ToFormattedString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "dd MMMM yyyy HH:mm:ss"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
}
