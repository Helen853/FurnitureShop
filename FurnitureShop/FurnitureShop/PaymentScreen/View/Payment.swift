//
//  Payment.swift
//  FurnitureShop

import SwiftUI

struct PaymentView: View {
    
    private enum Constants {
        static let title = "Payment"
        static let backTitle = "back"
        static let logoName = "logoMir"
        static let cardNumber = "**** **** **** 0000"
        static let cardNumberText = "Card number"
        static let cardholderText = "Cardholder"
        static let colorText = "grayText"
        static let newCardText = "Add new card"
        static let colorFont = "colorFont"
        static let cardholderTextField = "Cardholder name"
        static let numberTextField = "0000 0000 0000 0000"
        static let arrowName = "chevron"
        static let cvcText = "CVC"
        static let cvcPlaceholder = "000"
        static let eyeOpen = "eye"
        static let eyeClose = "eye.slash"
        static let alertTitle = "Ошибка при вводе"
        static let alertMessage = "Код-CVC должен содержать не менее трех символов"
        static let backCvcText = "CVC/CVV"
        static let validText = "Valid"
        static let cardNumberMask = "XXXX XXXX XXXX XXXX"
        static let nameButton = "Add now"
        static let startColor = "startGraund"
        static let endColor = "endGround"
        static let addText = "Данные карты добавлены"
    }
    
    @Environment(\.presentationMode) var presentatin
    
    @State private var textNumberCard = ""
    @State private var textName = ""
    @State private var textCvc = ""
    @State private var showBackSide = false
    @State private var showAlert = false
    @State private var showAddAlert = false
    @State private var section = 0
    @State private var sectionYear = 0
    @State private var showCvc = false
    @State private var cardNumber = "**** **** **** 0000"
    @State private var yourNameText = "Your Name"
    @State private var dateText = "Date"
    @State private var yearText = "Year"
    
    @ObservedObject var viewModel = PaymentViewModel()
    
    var body: some View {
        VStack {
            topView
            ScrollView {
               frontCardView.onTapGesture {
                   showBackSide.toggle()
                }
                textFields
            }
            Spacer()
            addButton
        }.navigationBarBackButtonHidden(true)
    }
    
    private var topView: some View {
        ZStack {
            GradientView().frame(height: 50)
            Spacer()
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
                    .frame(width: 125, alignment: .leading)
                Spacer()
            }
        }
    }
    
    private var frontCardView: some View {
        ZStack {
            GradientView()
                .frame(width: 310, height: 180)
                .cornerRadius(20)
                .shadow(radius: 4, y: 4)
            makeInfoCard()
            .foregroundColor(.white)
            .frame(width: 271)
        }.rotation3DEffect(.degrees(showBackSide ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .animation(.linear(duration: 0.7), value: showBackSide)
    }
    
    private var infoCardView: some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack {
                Spacer()
                Image(Constants.logoName)
                    .padding(.trailing, -10)
            }.padding(.trailing, 5)
            Spacer()
            Text(cardNumber)
                .bold()
            Text(Constants.cardNumberText)
                .foregroundColor(Color(Constants.colorText))
            Spacer()
            Text(yourNameText)
                .bold()
            Text(Constants.cardholderText)
                .foregroundColor(Color(Constants.colorText))
            Spacer()
        }
    }
    
    private var backInfoCardView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            Text(textNumberCard)
                .bold()
                .frame(width: 251, alignment: .leading)
            HStack {
                Text(textCvc)
                    .bold()
                Text(Constants.backCvcText)
            }.frame(height: 30)
            HStack {
                Text("\(dateText)/ \(String(yearText.suffix(2)))")
                    .bold()
                Text(Constants.validText)
            }.frame(height: 30)
            Spacer()
        }.rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
    }
    
    private var textFields: some View {
        VStack(alignment: .leading) {
            makeText(text: Constants.newCardText)
                .bold()
            nameTextField
            Divider()
            makeText(text: Constants.cardNumberText)
                .bold()
            numberTextField
            Divider()
            datePicker
            makeText(text: Constants.cvcText)
                .bold()
            cvcTextField
            Divider()
        }.padding()
    }
    
    private var nameTextField: some View {
        TextField(Constants.cardholderTextField, text: $textName)
            .onChange(of: textName) { newValue in
                textName = newValue
                withAnimation(.linear) {
                    yourNameText = textName
                }
                
            }
    }
    
    private var numberTextField: some View {
        TextField(Constants.numberTextField, text: $textNumberCard.max(19))
            .keyboardType(.numberPad)
            .onChange(of: textNumberCard) { newValue in
                textNumberCard = viewModel.formatNumber(with: Constants.cardNumberMask, numberCard: newValue)
                if textNumberCard.count > 15 {
                    withAnimation(.linear) {
                        cardNumber = "**** **** **** \(textNumberCard.suffix(4))"
                    }
                }
            }
    }
    
    private var cvcTextField: some View {
        HStack {
            makeField()
                .keyboardType(.numbersAndPunctuation)
                .onChange(of: textCvc) { newValue in
                    textCvc = newValue
                }
            
                .onSubmit {
                    viewModel.checkCvc(inputCode: textCvc)
                    showAlert = viewModel.showAlert
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(Constants.alertTitle), message: Text(Constants.alertMessage))
                }
            Button {
                self.viewModel.updateField()
            } label: {
                Image(systemName:  self.viewModel.showPassword ? Constants.eyeOpen : Constants.eyeClose)
                    .foregroundColor(.gray)
            }
        }
    }
    
    private var datePicker: some View {
        HStack(spacing: 80) {
            VStack {
               monthPicker
                Divider()
                    .frame(width: 120)
            }
            VStack {
                yearPicker
                Divider()
                    .frame(width: 120)
            }
        }
    }
    
    private var yearPicker: some View {
        HStack {
            makeText(text: yearText)
            ZStack {
                Image(Constants.arrowName)
                Picker(yearText, selection: $sectionYear) {
                    ForEach(24..<35) { year in
                        Text("20\(year)").tag(year)
                    }
                }.formStyle(.grouped)
                    .opacity(0.02)
                    .onChange(of: sectionYear) { newValue in
                        sectionYear = newValue
                        yearText = "20\(String(sectionYear))"
                    }
            }
        }
    }
    
    private var monthPicker: some View {
        HStack {
            makeText(text: dateText)
            ZStack {
                Image(Constants.arrowName)
                Picker(dateText, selection: $section) {
                    ForEach(1..<13) { month in
                        Text("\(month)").tag(month)
                    }
                }.formStyle(.grouped)
                    .opacity(0.02)
                    .onChange(of: section) { newValue in
                        section = newValue
                        dateText = String(section)
                    }
            }
        }
    }
    
    private var addButton: some View {
        Button {
            showAddAlert = true
        } label: {
            Text(Constants.nameButton)
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
        .alert(isPresented: $showAddAlert) {
            Alert(title: Text(Constants.addText))
        }
    }
    
    private func makeText(text: String) -> some View {
        Text(text)
            .foregroundColor(Color(uiColor: .darkGray))
            .font(.system(size: 20))
    }
    
    private func makeField() -> some View {
        Group {
            if viewModel.showPassword {
                TextField(Constants.cvcPlaceholder, text: $textCvc.max(3))
            } else {
                SecureField(Constants.cvcPlaceholder, text: $textCvc.max(3))
            }
        }
    }
    
    private func makeInfoCard() -> some View {
        Group {
            if showBackSide {
                backInfoCardView
            } else {
                infoCardView
            }
        }
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}

