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
        static let errorCountNumber = "Номер должен содержать не менее 11 символов"
        static let errorCountPassword = "Пароль должен содержать не менее 6 символов"
    }
    
    @State var textNumber = ""
    @State var textPassword = ""
    @State var showAlert = false
    @State var showPassword = false
    @State var shakeNumberTextField = false
    @State var shakePasswordTextField = false
    
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
        VStack(alignment: .leading, spacing: 15) {
            makeText(text: Constants.numberTitle)
            numberTextField
            ZStack {
                if shakeNumberTextField {
                    makeErrorText(text: Constants.errorCountNumber)
                } else {
                    Divider()
                }
            }
            makeText(text: Constants.passwordText)
            HStack {
                passwordField
                Button {
                    self.viewModel.updateField()
                } label: {
                    Image(systemName:  self.viewModel.showPassword ? Constants.eyeOpen : Constants.eyeClose)
                        .foregroundColor(.gray)
                }
            }
            ZStack {
                if shakePasswordTextField {
                    makeErrorText(text: Constants.errorCountPassword)
                } else {
                    Divider()
                }
            }
        }
    }
    
    private var numberTextField: some View {
        TextField(Constants.numberTextField, text: $textNumber)
            .font(.system(size: 20))
            .keyboardType(.numberPad)
            .padding(.horizontal, 12)
            .onChange(of: textNumber) { newValue in
                textNumber = viewModel.formatPhoneNumber(with: Constants.phoneFormat, phone: newValue)
                viewModel.checkNumber(count: textNumber.count)
                numberIsFocus = viewModel.showNumberKeyboard
                passwordIsFocus = viewModel.showPasswordKeyboard
            }
            .focused($numberIsFocus)
            .onSubmit({
                viewModel.checkMinCountNumber(count: textNumber.count)
            })
            .border(shakeNumberTextField ? .red : .clear)
            .offset(x: shakeNumberTextField ? 5 : 0)
            .onChange(of: viewModel.showAnimationNumber) { _ in
                withAnimation(Animation.default.repeatCount(7).speed(5)) {
                    shakeNumberTextField = viewModel.showAnimationNumber
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation(.linear(duration: 1).delay(0.3)) {
                        self.shakeNumberTextField = false
                    }
                }
            }
    }
    
    private var passwordField: some View {
        makeField()
            .font(.system(size: 20))
            .padding(.horizontal, 12)
            .focused($passwordIsFocus)
            .onChange(of: textPassword) { newValue in
                viewModel.checkPassword(count: newValue.count)
                passwordIsFocus = viewModel.showPasswordKeyboard
            }
            .onSubmit({
                viewModel.checkMinCountPassword(count: textPassword.count)
            })
            .border( shakePasswordTextField ? .red : .clear)
            .offset(x: shakePasswordTextField ? 10 : 0)
            .onChange(of: viewModel.showAnimationPassword) { _ in
                withAnimation(Animation.default.repeatCount(7).speed(5)) {
                    shakePasswordTextField = viewModel.showAnimationPassword
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation(.linear(duration: 1).delay(0.3)) {
                        self.shakePasswordTextField = false
                    }
                }
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
    
    private func makeErrorText(text: String) -> some View {
        Text(text)
            .font(.system(size: 10))
            .foregroundColor(.red)
            .lineLimit(2)
        
    }
    
    private func makeField() -> some View {
        Group {
            if viewModel.showPassword {
                TextField(Constants.passwordTextField, text: $textPassword.max(15))
            } else {
                SecureField(Constants.passwordTextField, text: $textPassword.max(15))
            }
        }
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView()
    }
}
