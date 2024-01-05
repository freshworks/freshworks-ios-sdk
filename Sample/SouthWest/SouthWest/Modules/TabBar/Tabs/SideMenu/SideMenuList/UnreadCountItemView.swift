//
//  UnreadCountItemView.swift
//  SouthWest
//
//  Created by Pramit Tewari on 17/11/23.
//

import SwiftUI

struct UnreadCountItemView: View {
    let item: SideMenuItem
    @Binding var unreadCount: String
    
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
                
                if !unreadCount.isEmpty {
                    Text(unreadCount)
                        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                        .font(.system(size: 14, weight: .semibold))
                        .frame(height: 24)
                        .foregroundColor(.white)
                        .background(Color.red.edgesIgnoringSafeArea(.all))
                        .cornerRadius(15)
                }
            }
            Divider()
        }
    }
}

struct UnreadCountItemView_Previews: PreviewProvider {
    static var previews: some View {
        UnreadCountItemView(item: SideMenuData.previewItem, unreadCount: .constant(Constants.SideMenu.sampleUnreadCount))
    }
}
