//
//  loadView.swift
//  FurnitureShop

import SwiftUI

struct LoadView: View {
    
    private enum Constants {
        static let loadText = "Идет загрузка"
    }
    
    var body: some View {
        ZStack {
            GradientView()
            VStack {
                ProgressView()
                Text(Constants.loadText)
                    .bold()
            }
        }
    }
}

struct LoadView_Previews: PreviewProvider {
    static var previews: some View {
        LoadView()
    }
}
