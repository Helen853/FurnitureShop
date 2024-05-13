//
//  FiltersView.swift
//  FurnitureShop

import SwiftUI

struct FiltersView: View {
    
    private enum Constants {
        static let title = "Filters"
        static let backTitle = "back"
        static let categoryTitle = "Category"
        static let colorFont = "colorFont"
        static let moreText = "More"
        static let arrowright = "arrowright"
        static let categories = ["bedCategory", "chairCategory", "sofeCategory"]
        static let categoryColor = "categoryColor"
        static let pricesText = "Prices"
        static let newPriceColor = "newPriceColor"
        static let circle = "circle"
        static let minPrice = "$500"
        static let colorText = "Color"
    }
    
    private let rows: [GridItem] = [ .init(.flexible())]
    private let columns: [GridItem] = [ .init(.flexible()), .init(.flexible()), .init(.flexible()), .init(.flexible()), .init(.flexible())]
    
    @Environment(\.presentationMode) private var presentatin
    
    @State private var progress: Double = 500
    @State private var currentPrice = 500
    
    @ObservedObject private var viewModel = FiltersViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            topView
            categoryView
            LazyHGrid(rows: rows) {
                ForEach(0..<Constants.categories.count) { image in
                    makeCategory(imageName: Constants.categories[image])
                }
            }.frame(height: 90)
            makeText(text: Constants.pricesText)
                .padding()
            priceSlider
            HStack {
                makePriceText(text: Constants.minPrice)
                Spacer()
                makePriceText(text: "$\(currentPrice)")
            }.padding()
            makeText(text: viewModel.colorText).padding()
            colorView
            Spacer()
        }.navigationBarBackButtonHidden(true)
    }
    
    private var colorView: some View {
        LazyVGrid(columns: columns) {
            ForEach(0..<viewModel.colors.count) { color in
                makeColor(color: viewModel.colors[color], index: color)
            }
        }
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
                    .frame(width: 100, alignment: .leading)
                Spacer()
            }
        }
    }
    
    private var categoryView: some View {
        HStack {
            makeText(text: Constants.categoryTitle)
            Spacer()
            Text(Constants.moreText)
                .foregroundColor(.gray)
                .font(.system(size: 24, weight: .bold))
            Image(Constants.arrowright)
        }.padding()
    }
    
    private var priceSlider: some View {
        Slider(value: Binding(get: {
            progress
        }, set: { newValue in
            progress = newValue
            viewModel.setCurrentPrice(sliderValue: newValue)
            self.currentPrice = Int(viewModel.currentPrice)
        }), in: 500...5000, step: 500)
            .accentColor(Color(Constants.newPriceColor))
            .padding()
            .onAppear {
                UISlider.appearance().setThumbImage(UIImage(named: Constants.circle), for: .normal)
            }
            .frame(height: 8)
    }
    
    private func makeCategory(imageName: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 120, height: 80)
                .shadow(radius: 4, y: 4)
                .foregroundColor(Color(Constants.categoryColor))
            Image(imageName)
        }
    }
    
    private func makeText(text: String) -> some View {
        Text(text)
            .foregroundColor(Color(Constants.colorFont))
            .font(.system(size: 24, weight: .bold))
    }
    
    private func makePriceText(text: String) -> some View {
        Text(text)
            .foregroundColor(Color(Constants.colorFont))
            .font(.system(size: 18))
    }
    
    private func makeColor(color: String, index: Int) -> some View {
        Button {
            viewModel.setColor(index: index)
        } label: {
            Circle()
                .foregroundColor(Color(color))
                .frame(width: 40, height: 40)
                .overlay {
                    Circle()
                        .stroke(.gray)
                }
        }
    }
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView()
    }
}
