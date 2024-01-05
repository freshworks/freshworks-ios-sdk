//
//  FeatureBackgroundView.swift
//  SouthWest
//
//  Created by Pramit Tewari on 07/12/23.
//

import SwiftUI
import Combine

struct FeatureBackgroundView<Content: View>: View {
    
    let heading: String
    let subheading: String
    let mainButtonTitle: String
    let content: Content
    let dismissTapped: () -> Void
    let mainButtonTapped: () -> Void
    
    @State private var keyboardHeight: CGFloat = 0
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        heading: String,
        subheading: String,
        mainButtonTitle: String,
        dismissTapped: @escaping () -> Void = {},
        mainButtonTapped: @escaping () -> Void = {},
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.heading = heading
        self.subheading = subheading
        self.mainButtonTitle = mainButtonTitle
        self.dismissTapped = dismissTapped
        self.mainButtonTapped = mainButtonTapped
        self.content = content()
        
        NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillShowNotification)
            .compactMap { notification in
                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            }
            .map { rect in
                rect.height
            }
            .assign(to: \.keyboardHeight, on: self)
            .store(in: &cancellables)
        
        NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
            .assign(to: \.keyboardHeight, on: self)
            .store(in: &cancellables)
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    dismissTapped()
                }
            
            GeometryReader { geometry in
                HStack {
                    Spacer() .frame(width: 24)
                    ScrollView {
                        VStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(heading)
                                        .font(.system(size: 17, weight: .semibold))
                                    Spacer()
                                    Button(action: {
                                        dismissTapped()
                                    }) {
                                        Image(systemName: Images.systemCloseFilled)
                                            .resizable()
                                            .renderingMode(.template)
                                            .foregroundColor(.gray)
                                            .background(Color.white)
                                            .frame(width: 24, height: 24)
                                    }
                                    .accessibilityIdentifier(Constants.AccessibilityIdentifiers.dismiss)
                                }
                                Text(subheading)
                                    .font(.system(size: 13))
                                    .foregroundColor(Color(Colors.darkBlue).opacity(0.7))
                                    .padding(.top, 6)
                                
                                content
                                    .padding(.top, 20)
                                
                            }
                            .padding()
                            .frame(minWidth: 0, maxWidth: geometry.size.width)
                            .offset(y: -keyboardHeight)
                            .animation(.easeInOut(duration: 0.3))
                            
                            Button(action: {
                                mainButtonTapped()
                            }) {
                                Text(mainButtonTitle)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 40)
                                    .background(Color(Colors.darkBlue))
                                    .cornerRadius(20)
                            }
                            .padding([.leading, .trailing, .bottom], 16)
                            .accessibilityIdentifier(mainButtonTitle)
                            //.padding()
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .frame(minHeight: geometry.size.height)
                    }
                    Spacer().frame(width: 24)
                }
            }
        }
    }
}

struct FeatureBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        
        FeatureBackgroundView(
            heading: Constants.PreviewProvider.sampleText,
            subheading: Constants.PreviewProvider.sampleText,
            mainButtonTitle: Constants.PreviewProvider.sampleText,
            dismissTapped: {
                
            }, mainButtonTapped: {
                
            }) {
                EmptyView()
            }
    }
}
