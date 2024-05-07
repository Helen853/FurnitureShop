//
//  authorization.swift
//  FurnitureShop

import SwiftUI

struct AuthorizationView: View {
    
    private enum Constants {
        static let startColor = "startGraund"
        static let endColor = "endGround"
        static let graundImage = "signup"
        static let graundLogin =  "login"
        static let loginText = "Log in"
        static let singUpText = "Sing up"
        static let startButtonColor = "startColorButton"
        static let endButtonColor = "endColorButton"
        static let numberText = "+7 (999) 999-99-99"
        static let passwordText = "Password"
        static let forgotTexxt = "Forgot your password?"
        static let checkTexxt = "Check Verification"
        static let numberTextField = "Number"
        static let numberTitle = "Number Phone"
        static let passwordTextField = "Password"
        static let alertTitle = "Для восстановления пароля свяжитесь с техподдержкой по номеру \n +7 (3235) 45-16-18"
        static let eyeOpen = "eye"
        static let eyeClose = "eye.slash"
        static let phoneFormat = "+X (XXX) XXX-XX-XX"
    }
    
    @State var textNumber = ""
    @State var textPassword = ""
    @State var showAlert = false
    @State var showPassword = false
    
    @FocusState var numberIsFocus: Bool
    @FocusState var passwordIsFocus: Bool
    
    @ObservedObject var viewModel = AuthorizationViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                gradientView.frame(height: 60)
                Spacer(minLength: 37)
                loginView
                .padding(47)
                    .frame(height: 56)
                Spacer(minLength: 76)
                textFields.frame(height: 124)
                    .padding(20)
                Spacer(minLength: 95)
                singUpButton
                Spacer(minLength: 24)
                operationButton
                Spacer()
            }
        }.navigationBarBackButtonHidden(true)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
    }
    
    private var gradientView: some View {
        ZStack {
            LinearGradient(
                colors: [Color(Constants.startColor), Color(Constants.endColor)],
                startPoint: .leading,
                endPoint: .trailing
            ).ignoresSafeArea(.all)
        }
    }
    
    private var loginView: some View {
        ZStack(alignment: .leading) {
            Image(Constants.graundImage).offset(x: -1)
            Image(Constants.graundLogin)
            HStack(spacing: 74) {
                setGradientText(title: Constants.loginText)
                setGradientText(title: Constants.singUpText)
            }.frame(height: 55)
            .padding(40)
        }
    }
    
    private var operationButton: some View {
        VStack(spacing: 18) {
            Button {
                self.showAlert = true
            } label: {
                makeText(text: Constants.forgotTexxt)
            }.alert(isPresented: $showAlert) {
                Alert(title: Text(Constants.alertTitle))
            }
            NavigationLink(destination: VerificationView()) {
                makeText(text: Constants.checkTexxt)
            }
        }
    }
    
    private var singUpButton: some View {
        Button {
            print("")
        } label: {
            Text(Constants.singUpText)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold))
        }
        .frame(width: 300, height: 55)
        .background(
            LinearGradient(
                colors: [Color(Constants.startColor), Color(Constants.endColor)],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .cornerRadius(27)
    }
    
    private var textFields: some View {
        VStack(alignment: .leading, spacing: 12) {
            makeText(text: Constants.numberTitle)
            TextField(Constants.numberTextField, text: $textNumber)
                .font(.system(size: 20))
                .keyboardType(.phonePad)
                .padding(.horizontal, 12)
                .onChange(of: textNumber) { newValue in
                    textNumber = viewModel.formatPhoneNumber(with: Constants.phoneFormat, phone: newValue)
                    viewModel.checkNumber(count: textNumber.count)
                    numberIsFocus = viewModel.showNumberKeyboard
                    passwordIsFocus = viewModel.showPasswordKeyboard
                }
                .focused($numberIsFocus)
    
            Divider()
            makeText(text: Constants.passwordText)
            HStack {
                makeField()
                    .font(.system(size: 20))
                    .padding(.horizontal, 12)
                    .focused($passwordIsFocus)
                    .onChange(of: textPassword) { newValue in
                        viewModel.checkPassword(count: newValue.count)
                        passwordIsFocus = viewModel.showPasswordKeyboard
                    }
                Button {
                    self.viewModel.updateField()
                } label: {
                    Image(systemName:  self.viewModel.showPassword ? Constants.eyeOpen : Constants.eyeClose)
                        .foregroundColor(.gray)
                }
            }
            Divider()
        }
    }
    
    private func setGradientText(title: String) -> some View {
        LinearGradient(
            colors: [Color(Constants.startButtonColor), Color(Constants.endButtonColor)],
            startPoint: .top,
            endPoint: .bottom
        ).mask {
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .frame(height: 55)
        }
    }
    
    private func makeText(text: String) -> some View {
        Text(text)
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(.gray)
    }
    
    private func makeField() -> some View {
        Group {
            if viewModel.showPassword {
                TextField(Constants.passwordTextField, text: $textPassword)
            } else {
                SecureField(Constants.passwordTextField, text: $textPassword)
            }
        }
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView()
    }
}
