//
//  RegisterContentView.swift
//  Home
//
//  Created by Jonatan Ortiz on 12/09/23.
//

import SwiftUI
import UI

public struct RegisterContentView<ViewModeling>: View where ViewModeling: RegisterViewModeling {
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
                SignUpButton
                    .padding(.bottom, 5)
                SignUpWithGoogleButton
                    .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .backgroundImage()
            .feedBackBottomSheet(
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
        Image.asset(.logo)
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

    var SignUpButton: some View {
        Button {
            viewModel.signUp(email: email, password: password)
        } label: {
            Text(Strings.Register.signUpButton)
                .headlineBold(.white.opacity(0.75))
                .frame(height: 50)
        }
        .cardStyle()
        .padding(.horizontal, 10)
    }

    var SignUpWithGoogleButton: some View {
        Button {
            viewModel.signUpWithGoogle()
        } label: {
            Text(Strings.Register.signUpWithGoogleButton)
                .headlineBold(.white.opacity(0.75))
                .frame(height: 50)
        }
        .cardStyle(background: .appBlue)
        .padding(.horizontal, 10)
    }
}

struct RegisterContentView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewDependencyOrchestrator.start()
        return RegisterContentView(viewModel: RegisterViewModel(dependencies: DependencyContainer()))
    }
}
