//
//  FavouritesView.swift
//  SouthWest
//
//  Created by Pramit Tewari on 07/11/23.
//

import SwiftUI

struct FavouritesView: View {
    var body: some View {
        Text(Constants.Favourites.noFavourites)
            .navigationBarHidden(true) // Hide outer nav bar
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
