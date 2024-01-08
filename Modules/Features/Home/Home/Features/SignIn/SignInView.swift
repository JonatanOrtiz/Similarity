//
//  SignInView.swift
//  Home
//
//  Created by Jonatan Ortiz on 12/09/23.
//

import SwiftUI
import UI

public struct SignInView<ViewModeling>: View where ViewModeling: SignInViewModeling {
    @StateObject var viewModel: ViewModeling
    @State private var email = String()
    @State private var password = String()
    
    public var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Spacer()
                LogoView
                Spacer()
                EmailTextField
                    .padding(.bottom, 5)
                PasswordTextField
                    .padding(.bottom, 5)
                SignInButton
                    .padding(.bottom, 5)
                SignInWithGoogleButton
                    .padding(.bottom, 5)
                RegisterButton
                    .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .backgroundImage()
            .errorBottomSheet(
                customError: $viewModel.error,
                primaryButton: .init(title: Strings.Common.ok) {
                    viewModel.error = nil
                },
                secondaryButton: .init(title: Strings.Common.tryAgain) {
                    viewModel.error = nil
                    viewModel.tryAgainAction?()
                }
            )
        }
        .tint(.primaryColor)
    }

    var LogoView: some View {
        Image.assetImage(.logo)
            .resizable()
            .cornerRadius(20)
            .aspectRatio(contentMode: .fit)
            .frame(width: 250, height: 250)
            .padding(.bottom, 40)
            .padding(.top, 50)
    }

    var EmailTextField: some View {
        CustomTextField(
            text: $email,
            placeholder: Strings.SignIn.emailPlaceholder,
            keyboardType: .emailAddress,
            textContentType: .emailAddress
        )
        .padding(.horizontal, 20)
    }

    var PasswordTextField: some View {
        CustomSecureField(
            text: $password,
            placeholder: Strings.SignIn.passwordPlaceholder
        )
        .padding(.horizontal, 20)
    }

    var SignInButton: some View {
        Button {
            viewModel.signIn(email: email, password: password)
        } label: {
            Text(Strings.SignIn.signInButton)
                .headlineBold(.white.opacity(0.85))
                .frame(height: 50)
        }
        .cardStyle()
        .padding(.horizontal, 10)
    }

    var SignInWithGoogleButton: some View {
        Button {
            viewModel.signInWithGoogle()
        } label: {
            Text(Strings.SignIn.signInWithGoogleButton)
                .headlineBold(.white.opacity(0.85))
                .frame(height: 50)
        }
        .cardStyle(background: .appBlue)
        .padding(.horizontal, 10)
    }

    var RegisterButton: some View {
        NavigationLink(destination: RegisterFactory.make()) {
            Text(Strings.SignIn.registerButton)
                .headlineBold(.white.opacity(0.85))
                .frame(height: 50)
                .cardStyle()
                .padding(.horizontal, 10)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewDependencyOrchestrator.start()
        return SignInView(viewModel: SignInViewModel(dependencies: DependencyContainer()))
    }
}
