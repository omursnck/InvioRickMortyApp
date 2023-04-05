//
//  CharacterListItem.swift
//  apiRequest
//
//  Created by Ömür Şenocak on 1.04.2023.
//

import SwiftUI
import Kingfisher

struct CharacterListItem: View {
    @StateObject var viewModel = rmVM()
    @State var choosenPlanet: String = ""
    @State var isButtonOn: Bool = false
    var filteredCharacters: [Characters.Result] {
        viewModel.charactersArray.filter { $0.location.name == choosenPlanet }
    }
    var body: some View {
        
        ForEach(viewModel.charactersArray, id: \.self){ chars in
            Text(chars.name)
        }
        
    }
}

struct CharacterListItem_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListItem()
    }
}
