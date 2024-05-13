//
//  DetailsView.swift
//  FurnitureShop

import SwiftUI

struct DetailsView: View {
    
    private enum Constants {
        static let title = "Sofa Elda 900"
        static let heartImage = "heart"
        static let imageName = "sofa"
        static let priceColor = "priceGround"
        static let prict = "Price: 999$"
        static let colorName = "colorFont"
        static let startColor = "startGraund"
        static let endColor = "endGround"
        static let buttonTitle = "Buy now"
        static let startButtonColor = "startColorButton"
        static let endButtonColor = "endColorButton"
        static let articleText = "Article:"
        static let articleNumber = "283564"
        static let descriptionText = " A sofa in a modern style is furniture without lush ornate decor. It has a simple or even futuristic appearance and sleek design"
        static let description = "Description:"
        static let reviewText = "Review"
    }
    
    var selectedFurniture: Furniture
    
    @State private var text = ""
    @State private var totalChar = 0
    @State private var lastText = ""
    
    @GestureState var scale = 1.0
    
    @Environment(\.presentationMode) var presentatin
    
    var body: some View {
        VStack {
            HStack {
                Text(selectedFurniture.name)
                    .foregroundColor(.gray)
                    .font(.system(size: 20, weight: .bold))
                Spacer()
                Image(Constants.heartImage)
            }.padding()
            Image(selectedFurniture.image)
                .scaleEffect(scale)
                .gesture(
                    MagnificationGesture()
                        .updating($scale) { value, gestureState, transaction in
                            gestureState = value.magnitudeSquared
                        }
                )
            priceView.offset(x: 20)
            gradientView
        }.navigationBarBackButtonHidden(true)
    }
    
    private var priceView: some View {
        HStack {
            Spacer()
            ZStack {
                Rectangle()
                    .fill(Color(Constants.priceColor))
                    .frame(width: 191, height: 44)
                    .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                Text("Price: \(selectedFurniture.newPrice)$")
                    .foregroundColor(Color(Constants.colorName))
                    .font(.system(size: 20, weight: .bold))
            }
        }
    }
    
    private var gradientView: some View {
        ZStack {
            LinearGradient(
                colors: [Color(Constants.startColor), Color(Constants.endColor)],
                startPoint: .top,
                endPoint: .bottom
            ).cornerRadius(12, corners: [.topLeft, .topRight])
                .ignoresSafeArea(.all)
            VStack(spacing: 6) {
                HStack {
                    makeText(text: Constants.articleText)
                        .bold()
                    makeText(text: selectedFurniture.article)
                }
                
                    .frame(width: 356, alignment: .leading)
                HStack(alignment: .top) {
                    Text(Constants.description)
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                        .bold()
                    + Text(selectedFurniture.description)
                       .foregroundColor(.white)
                       .font(.system(size: 16))
                }.padding(.leading)
                makeText(text: Constants.reviewText)
                    .bold()
                inputReview
                buyButton
            }
        }
    }
    
    private var buyButton: some View {
        VStack {
            Button {
                self.presentatin.wrappedValue.dismiss()
            } label: {
                gradientText
            }
            .background(.white)
            .frame(width: 300, height: 55)
            .cornerRadius(27)
        }
    }
    
    private var gradientText: some View {
        LinearGradient(
            colors: [Color(Constants.startButtonColor), Color(Constants.endButtonColor)],
            startPoint: .top,
            endPoint: .bottom
        ).mask {
            Text(Constants.buttonTitle)
                .font(.system(size: 20, weight: .bold))
        }
    }
    
    private var inputReview: some View {
        HStack(alignment: .top) {
            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .background(.clear)
                .frame(width: 285, height: 177)
                .font(.system(size: 16))
                .onChange(of: text) { newValue in
                    totalChar = text.count
                    if totalChar <= 300 {
                        lastText = text
                    } else {
                        self.text = lastText
                    }
                }
            Text("\(totalChar)/300")
        }.foregroundColor(.white)
    }
    
    private func makeText(text: String) -> some View {
         Text(text)
            .foregroundColor(.white)
            .font(.system(size: 16))
    }
}
