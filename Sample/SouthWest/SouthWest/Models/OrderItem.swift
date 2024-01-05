//
//  OrderItem.swift
//  SouthWest
//
//  Created by Pramit Tewari on 09/11/23.
//

import Foundation

struct OrderItem: Hashable, Identifiable {
    
    var id = UUID()
    var image: String
    var name: String
    var price: String
    var color: String
    var size: String
    var status: String
    var parallelConversationIdentifier: String
}

struct OrderData {
    
    static var previewItem: OrderItem = OrderItem(
        image: Images.orderImageOne,
        name: Constants.Orders.name,
        price: Constants.Orders.price,
        color: Constants.Orders.color,
        size: Constants.Orders.size,
        status: Constants.Orders.Status.processing,
        parallelConversationIdentifier: Configurations.ParallelConversation.identifier
    )
    
    static var items = [
        
        OrderItem(
            image: Images.orderImageOne,
            name: Constants.Orders.name,
            price: Constants.Orders.price,
            color: Constants.Orders.color,
            size: Constants.Orders.size,
            status: Constants.Orders.Status.processing,
            parallelConversationIdentifier: Configurations.ParallelConversation.identifierOne
        ),
        
        OrderItem(
            image: Images.orderImageTwo,
            name: Constants.Orders.name,
            price: Constants.Orders.price,
            color: Constants.Orders.color,
            size: Constants.Orders.size,
            status: Constants.Orders.Status.delivered,
            parallelConversationIdentifier: Configurations.ParallelConversation.identifierTwo
        )
    ]
}

