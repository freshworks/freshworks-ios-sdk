//
//  MyOrders.swift
//  SouthWest
//
//  Created by Pramit Tewari on 08/11/23.
//

import SwiftUI

struct MyOrdersView: View {
    var body: some View {
        
        VStack {
            ForEach(OrderData.items) { item in
                VStack {
                    OrderItemView(item: item)
                    Divider().padding()
                }
            }
            Spacer()
        }
        .padding()
        .navigationBarHidden(false)
        .navigationBarTitle(Constants.SideMenu.myOrders, displayMode: .inline)
    }
}

struct MyOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        MyOrdersView()
    }
}
