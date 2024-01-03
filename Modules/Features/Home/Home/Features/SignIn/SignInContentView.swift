//
//  SignInContentView.swift
//  Home
//
//  Created by Jonatan Ortiz on 12/09/23.
//

import SwiftUI
import UI

public struct SignInContentView<ViewModeling>: View where ViewModeling: SignInViewModeling {
    @StateObject var viewModel: ViewModeling
    @State private var email = String()
    @State private var password = String()
    
    public var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Image.asset(.logo)
                    .resizable()
                    .cornerRadius(20)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)
                    .padding(.bottom, 40)
                    .padding(.top, 50)

                CustomTextField(
                    text: $email,
                    placeholder: Strings.SignIn.emailPlaceholder,
                    keyboardType: .emailAddress,
                    textContentType: .emailAddress
                )
                .padding(.horizontal, 20)
                
                CustomSecureField(
                    text: $password,
                    placeholder: Strings.SignIn.passwordPlaceholder
                )
                .padding(.horizontal, 20)

                Button {
                    viewModel.signIn(email: email, password: password)
                } label: {
                    Text(Strings.SignIn.signInButton)
                        .headlineBold(.white.opacity(0.75))
                        .frame(height: 50)
                }
                .flatGlassCard()
                .padding(.horizontal, 10)
                
                Button {
                    viewModel.signInWithGoogle()
                } label: {
                    Text(Strings.SignIn.signInWithGoogleButton)
                        .headlineBold(.white.opacity(0.75))
                        .frame(height: 50)
                }
                .flatGlassCard()
                .padding(.horizontal, 10)

                NavigationLink(destination: RegisterFactory.make()) {
                    Text(Strings.SignIn.registerButton)
                        .headlineBold(.white.opacity(0.75))
                        .frame(height: 50)
                        .flatGlassCard()
                        .padding(.horizontal, 10)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarHidden(true)
            .backgroundImage()
            .feedBackBottomSheet(
                customError: $viewModel.error,
                primaryButton: FeedBackBottomSheet.Button(title: Strings.Common.ok) {
                    viewModel.error = nil
                },
                secondaryButton: FeedBackBottomSheet.Button(title: Strings.Common.tryAgain) {
                    viewModel.error = nil
                    viewModel.tryAgainAction?()
                }
            )
        }
    }
}

struct SignInContentView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewDependencyOrchestrator.start()
        return SignInContentView(viewModel: SignInViewModel(dependencies: DependencyContainer()))
    }
}
