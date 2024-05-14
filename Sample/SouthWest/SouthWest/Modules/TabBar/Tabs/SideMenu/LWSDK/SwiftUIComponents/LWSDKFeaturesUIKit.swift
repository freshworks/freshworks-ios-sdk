//
//  LWSDKFeaturesUIKit.swift
//  SouthWest
//
//  Created by Pramit Tewari on 20/11/23.
//

import SwiftUI
import UIKit

// Create a UIViewControllerRepresentable struct
struct LWSDKFeaturesView: UIViewControllerRepresentable {    
    
    // TODO: Change this controller from UIKit to SwiftUI
    
    func makeUIViewController(context: Context) -> ViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "LWSDKFeaturesViewController") as? ViewController else {
            fatalError("Could not find features view controller")
        }
        return vc
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // Update the view controller if needed
    }
}

struct ContentView: View {
    var body: some View {
        LWSDKFeaturesView()
    }
}
