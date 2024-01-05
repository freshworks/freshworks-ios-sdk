//
//  SideMenuItemView.swift
//  SouthWest
//
//  Created by Pramit Tewari on 08/11/23.
//

import SwiftUI

struct SideMenuItemView: View {
    let item: SideMenuItem
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            
            HStack {
                VStack (alignment: .leading, spacing: 6) {
                    Text(item.title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color(Colors.darkBlue))
                    Text(item.description)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            Divider()
        }
    }
}

struct SideMenuItemView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuItemView(item: SideMenuData.previewItem)
    }
}
