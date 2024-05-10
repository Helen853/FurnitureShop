//
//  VerificationView.swift
//  FurnitureShop

import SwiftUI

struct VerificationView: View {
    
    private enum Constants {
        static let title = "Verification"
        static let backTitle = "back"
        static let message = "message"
        static let startColor = "startGraund"
        static let endColor = "endGround"
        static let codeText = "Verification code"
        static let checkTitle = "Check the SMS"
        static let messageText = "message to get verification code"
        static let buttonTitle = "Continue"
        static let receiveText = "Didn’t receive sms"
        static let againText = "Send sms again"
        static let alertTitle = "Fill in from message"
        static let primaryButton = "Cancel"
        static let secondaryButton = "Ok"
    }
    
    @Environment(\.presentationMode) var presentatin
    
    @State var showAlert = false
    @State var number = ["3", "4", "5", "0"]
    @State var showProgress = false
    
    @ObservedObject var viewModel = VerificationViewModel()
    
    let numberLimit = 1
    
    var body: some View {
        
        VStack {
            navigationView
                .frame(height: 60)
            Image(Constants.message)
            makeText(text: Constants.codeText)
            HStack {
                ForEach(0..<number.count) {
                    makeTextFields(text: $number[$0].max(numberLimit))
                }
            }
            VStack(spacing: 20) {
                makeText(text: Constants.checkTitle)
                    .bold()
                Text(Constants.messageText)
                    .foregroundColor(.gray)
                continueButton
                makeText(text: Constants.receiveText)
                sendCodeView
            }
                Spacer()
        }.navigationBarBackButtonHidden(true)
    }
    
    private var navigationView: some View {
        ZStack(alignment: .leading) {
            LinearGradient(
                colors: [Color(Constants.startColor), Color(Constants.endColor)],
                startPoint: .leading,
                endPoint: .trailing
            ).ignoresSafeArea(.all)
            HStack {
                Button {
                    self.presentatin.wrappedValue.dismiss()
                } label: {
                    Image(Constants.backTitle)
                }.padding()
                Spacer(minLength: 90)
                Text(Constants.title)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold))
                    .frame(width: 150, alignment: .leading)
                Spacer()
            }
        }
    }
    
    private var continueButton: some View {
        Button {
            showProgress.toggle()
        } label: {
            makeLabel()
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
    
    private var sendCodeView: some View {
        Button {
            showAlert = true
            self.viewModel.returnNewCode()
        } label: {
            makeText(text: Constants.againText)
                .bold()
        }.alert(isPresented: $showAlert) {
            Alert(
                title: Text(Constants.alertTitle),
                message: Text("\(viewModel.codeAll)"),
                primaryButton: .cancel(),
                secondaryButton: .default(Text(Constants.secondaryButton), action: {
                    self.number = viewModel.code
                })
            )
        }
    }
    
    private func makeTextFields(text: Binding<String> ) -> some View {
        TextField("0", text: text)
            .frame(width: 60, height: 60)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.gray)
            )
            .font(.system(size: 40))
            .multilineTextAlignment(.center)
            .foregroundColor(.gray)
            .keyboardType(.numberPad)
    }
    
    private func setupCodeView(number: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 2)
                .frame(width: 60, height: 60)
                .foregroundColor(Color.white)
            Text(number)
                .font(.system(size: 40))
                .foregroundColor(.gray)
        }
    }
    
    private func makeText(text: String) -> some View {
        Text(text)
            .font(.system(size: 20))
            .foregroundColor(.gray)
    }
    
    private func makeLabel() -> some View {
        Group {
            if showProgress {
                ProgressView()
            } else {
                Text(Constants.buttonTitle)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold))
            }
        }
    }
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView()
    }
}
