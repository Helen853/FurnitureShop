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
    @State var textFirst = ""
    @State var textSecond = ""
    @State var textThird = ""
    @State var textFourth = ""
    
    var number = ["3", "4", "5", "0"]
    var body: some View {
        
        VStack {
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
                    Spacer()
                }
            }.frame(height: 60)
            Image(Constants.message)
            Text(Constants.codeText)
            
            HStack {
                makeTextFields(text: $textFirst)
                makeTextFields(text: $textSecond)
                makeTextFields(text: $textThird)
                makeTextFields(text: $textFourth)
//                ForEach(0..<number.count) {
//                    setupCodeView(number: number[$0])
//                }
            }
            
            VStack(spacing: 20) {
                Text(Constants.checkTitle)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.gray)
                Text(Constants.messageText)
                    .foregroundColor(.gray)
                continueButton
                Text(Constants.receiveText)
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                
                Button {
                    showAlert = true
                } label: {
                    Text(Constants.againText)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.gray)
                }.alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(Constants.alertTitle),
                        primaryButton: .cancel(),
                        secondaryButton: .default(Text(Constants.secondaryButton))
                    )
                }
            }
                Spacer()
        }.navigationBarBackButtonHidden(true)
    }
    
    private var continueButton: some View {
        Button {
            print("")
        } label: {
            Text(Constants.buttonTitle)
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
    
    func makeTextFields(text: Binding<String> ) -> some View {
        TextField("", text: text)
            .frame(width: 60, height: 60)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.gray)
            )
            .font(.system(size: 40))
            .multilineTextAlignment(.center)
    }
    
    func setupCodeView(number: String) -> some View {
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
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView()
    }
}
