//
//  OrderItemView.swift
//  SouthWest
//
//  Created by Pramit Tewari on 09/11/23.
//

import SwiftUI
import FreshworksSDK

struct OrderItemView: View {
    var item: OrderItem
    var body: some View {
        
        VStack(spacing: 20) {
            HStack (alignment: .top) {
                Image(item.image)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 90, height: 110)
                    .cornerRadius(10)
                    .padding(0.5)
                    .background(Color.gray)
                    .cornerRadius(10)
                    
                    
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.name)
                        .font(.system(size: 14, weight: .semibold))
                    Text(Constants.Orders.currency + item.price)
                        .font(.system(size: 14, weight: .semibold))
                    Text(Constants.Orders.colorPrefix + item.color + Constants.Orders.separator + Constants.Orders.sizePrefix + item.size)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    HStack {
                        Text(Constants.Orders.statusPrefix)
                            .font(.system(size: 12))
                        Text(item.status)
                            .font(.system(size: 12))
                            .foregroundColor(Color.green)
                    }
                }
                Spacer()
            }
            
            HStack(spacing: 0) {
                Button {
                    Freshworks.shared.showConversation(conversationReferenceId: item.id.uuidString, topicName: Configurations.ParallelConversation.topicName)
                } label: {
                    HStack {
                        Spacer()
                        Image(Images.iconHelp)
                        Text(Constants.Orders.getHelp)
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .semibold))
                        Spacer()
                    }
                    .frame(height: 36)
                    .background(Color(Colors.darkBlue))
                    .cornerRadius(18)
                    .accessibilityIdentifier(item.parallelConversationIdentifier)
                }
                .accessibilityIdentifier(item.parallelConversationIdentifier)
                
                Button {
                    
                } label: {
                    HStack {
                        Spacer()
                        Image(Images.iconSummary)
                        Text(Constants.Orders.viewSummary)
                            .foregroundColor(Color(Colors.darkBlue))
                            .font(.system(size: 14, weight: .semibold))
                        Spacer()
                    }
                    .frame(height: 36)
                }
                .disabled(true)
            }
        }
        
    }
}

struct OrderItemView_Previews: PreviewProvider {
    static var previews: some View {
        OrderItemView(item: OrderData.previewItem)
    }
}
