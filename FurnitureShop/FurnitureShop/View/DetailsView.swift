//
//  DetailsView.swift
//  FurnitureShop

import SwiftUI

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
    }
}

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
        static let articleText = "Article: 283564"
        static let descriptionText = "Description: A sofa in a modern style is furniture without lush ornate decor. It has a simple or even futuristic appearance and sleek design"
        static let reviewText = "Review"
    }
    
    @State var text = ""
    @State var totalChar = 0
    @State var lastText = ""
    
    var body: some View {
        VStack {
            HStack {
                Text(Constants.title)
                    .foregroundColor(.gray)
                    .font(.system(size: 20, weight: .bold))
                Spacer()
                Image(Constants.heartImage)
            }.padding()
            Image(Constants.imageName)
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
                Text(Constants.prict)
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
                makeText(text: Constants.articleText)
                    .frame(width: 356, alignment: .leading)
                makeText(text: Constants.descriptionText)
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
                print("h")
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
                .foregroundColor(.white)
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
//            ProgressView("\(totalChar)/300", value: Double(totalChar), total: 300)
//                .frame(width: 70)
//                .foregroundColor(.white)
        }
    }
    
    private func makeText(text: String) -> some View {
        Text(text)
            .foregroundColor(.white)
            .font(.system(size: 16))
    }
}
