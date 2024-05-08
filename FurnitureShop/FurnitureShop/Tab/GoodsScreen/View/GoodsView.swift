//
//  GoodsView.swift
//  FurnitureShop

import SwiftUI

struct GoodsView: View {
    
    private enum Constants {
        static let filterImage = "filter"
        static let searchText = "Search..."
        static let searchImage = "magnifyingglass"
        static let priceText = "Your total price"
        static let priceColor = "startGraund"
        static let capsuleColor = "capsuleColor"
        static let sectionColor = "sectionColor"
        static let newPriceColor = "newPriceColor"
        static let colorFont = "colorFont"
    }
    
    @State var price = "   "
    @State var selectedCount = 0
    
    @ObservedObject var viewModel = GoodsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                topView
                priceView
                ScrollView {
                    ForEach(0..<viewModel.furniture.count) { item in
                        makeSection(item: viewModel.furniture[item], index: item)
                    }
                }
                Spacer()
            }.navigationBarBackButtonHidden(true)
        }
    }
    
    private var priceView: some View {
        HStack {
            Spacer()
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color(Constants.priceColor))
                    .frame(width: 300, height: 48)
                    .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                Text("\(Constants.priceText) \(String(viewModel.allPrice))$")
                    .foregroundColor(Color(Constants.colorFont))
                    .font(.system(size: 22))
                    .padding()
            }
        }
    }
    
    private var topView: some View {
        ZStack {
            GradientView().frame(height: 70)
            HStack {
                Capsule()
                    .foregroundColor(.white)
                    .frame(width: 312, height: 48)
                NavigationLink {
                    FiltersView()
                } label: {
                    Image(Constants.filterImage)
                }
            }
            HStack {
                Image(systemName: Constants.searchImage)
                Text(Constants.searchText)
                    .foregroundColor(Color(Constants.colorFont))
                    .font(.system(size: 20))
                Spacer()
            }.padding(.leading, 30)
        }
    }
    
    private func makeSection(item: Furniture, index: Int) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 360, height: 150)
                .shadow(radius: 4, y: 4)
                .foregroundColor(Color(Constants.sectionColor))
            HStack {
                Image(item.image)
                    .frame(width: 140, height: 140)
                VStack {
                    Text(item.name)
                        .foregroundColor(Color(Constants.colorFont))
                        .font(.system(size: 22, weight: .bold))
                    HStack {
                        Text("\(item.newPrice)$")
                            .foregroundColor(Color(Constants.newPriceColor))
                            .font(.system(size: 24, weight: .bold))
                        Text("\(item.oldPrice)$")
                            .foregroundColor(Color(Constants.colorFont))
                            .font(.system(size: 24))
                            .strikethrough(true, color: Color(Constants.colorFont))
                    }
                    makeCount(item: item, index: index)
                }
            }
        }
    }
    
    func makeCount(item: Furniture, index: Int) -> some View {
        ZStack {
            Capsule()
                .foregroundColor(Color(Constants.capsuleColor))
                .frame(width: 115, height: 40)
            HStack {
                Button {
                    viewModel.removePrice(price: item.newPrice, item: item)
                } label: {
                    Text("-")
                        .bold()
                        .foregroundColor(Color(Constants.colorFont))
                        .font(.system(size: 25))
                }
                .offset(x: -20)
                
                Text(String(viewModel.count[index]))
                    .bold()
                    .foregroundColor(Color(Constants.colorFont))
                    .font(.system(size: 20))
                
                Button {
                    viewModel.addPrice(price: item.newPrice, item: item)
                } label: {
                    Text("+")
                        .bold()
                        .foregroundColor(Color(Constants.colorFont) )
                        .font(.system(size: 25))
                }
                .offset(x: 20)
            }
        }
    }
}

struct GoodsView_Previews: PreviewProvider {
    static var previews: some View {
        GoodsView()
    }
}
