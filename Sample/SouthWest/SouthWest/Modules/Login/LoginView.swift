//
//  ContentView.swift
//  SouthWest
//
//  Created by Pramit Tewari on 06/11/23.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = Constants.Login.sampleEmail
    @State private var password: String = Constants.Login.samplePassword
    
    @State private var showAlert: Bool = false
    @State private var isEmailValid: Bool = false
    @State private var isPasswordValid: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(Images.background)
                    .resizable()
                    .edgesIgnoringSafeArea([.all])
                
                VStack {
                    BlurredView()
                        .cornerRadius(32)
                }
                .edgesIgnoringSafeArea([.all])
                .padding(EdgeInsets(top: 64, leading: 0, bottom: 0, trailing: 0))
                
                ScrollView {
                    VStack(spacing: 32) {
                        
                        LoginTitleView()
                        VStack (spacing: 24) {
                            BorderedTextfield(placeholder: Constants.Login.email, value: $email)
                                .accessibilityIdentifier(Constants.AccessibilityIdentifiers.email)
                            BorderedTextfield(placeholder: Constants.Login.password, value: $password)
                                .accessibilityIdentifier(Constants.AccessibilityIdentifiers.password)
                        }
                        
                        HStack {
                            Spacer()
                            Button {
                                
                            } label: {
                                Text(Constants.Login.forgotPassword)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                        }
                        
                        if isValidEmail && isValidPassword {
                            NavigationLink {
                                CustomTabView()
                            } label: {
                                Text(Constants.Login.signIn)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.white)
                                    .background(Color.black.edgesIgnoringSafeArea(.all))
                                    .cornerRadius(4)
                            }
                        } else {
                            Button {
                                if !(isValidEmail && isValidPassword) {
                                    showAlert = true
                                }
                            } label: {
                                Text(Constants.Login.signIn)
                                    .accessibilityIdentifier(Constants.AccessibilityIdentifiers.signIn)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.white)
                                    .background(Color.black.edgesIgnoringSafeArea(.all))
                                    .cornerRadius(4)
                            }
                            .accessibilityIdentifier(Constants.AccessibilityIdentifiers.signIn)
                        }
                        
                        LabelledDivider(label: Constants.Login.or)
                        
                        SocialLoginButtons()
                        
                        HStack {
                            Text(Constants.Login.noAccount)
                                .font(.system(size: 16))
                                .foregroundColor(.white.opacity(0.7))
                            
                            Text(Constants.Login.register)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                    }
                }
                .padding(EdgeInsets(top: 96, leading: 20, bottom: 0, trailing: 20))
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(.black)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(Constants.Login.credentialsAlertTitle),
                message: Text(Constants.Login.credentialsAlertMessage),
                dismissButton: .default(Text(Constants.Login.credentialsAlertButton))
            )
        }
    }
    
    private var isValidEmail: Bool {
        let emailPredicate = NSPredicate(format: Constants.Login.emailPredicate, Constants.Login.emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private var isValidPassword: Bool {
        return password.count > 0
    }
}

struct LoginTitleView: View {
    var body: some View {
        HStack {
            VStack (spacing: 8) {
                
                Text(Constants.Login.titleSignIn)
                    .foregroundColor(.white)
                    .font(.system(size: 32))
                
                
                Text(Constants.Login.subheadingWelcome)
                    .foregroundColor(.white)
                    .font(.system(size: 12))
                
            }
            Spacer()
        }
    }
}

struct SocialLoginButtons: View {
    var body: some View {
        HStack {
            Button {
            } label: {
                Image(Images.iconGoogle)
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
            
            Button {
            } label: {
                Image(Images.iconFacebook)
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
            
            Button {
            } label: {
                Image(Images.iconApple)
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
        }
    }
}

struct LabelledDivider: View {
    
    let label: String
    let horizontalPadding: CGFloat
    let color: Color
    
    init(label: String, horizontalPadding: CGFloat = 0, color: Color = .white.opacity(0.8)) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
    }
    var line: some View {
        VStack { Divider().background(color) }.padding(horizontalPadding)
    }
    
    var body: some View {
        HStack {
            line
            Text(label)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(color)
            line
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
