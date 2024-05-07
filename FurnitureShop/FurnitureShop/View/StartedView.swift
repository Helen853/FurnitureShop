//
//  ContentView.swift
//  FurnitureShop

import SwiftUI

struct StartedView: View {
    
    private enum Constants {
        static let startColor = "startGraund"
        static let endColor = "endGround"
        static let title = "169.ru"
        static let imageName = "startedImage"
        static let buttonTitle = "Get Started"
        static let startButtonColor = "startColorButton"
        static let endButtonColor = "endColorButton"
        static let bottomText = "Don't have an account?"
        static let bottomTitle = "Sing in here"
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    LinearGradient(
                        colors: [Color(Constants.startColor), Color(Constants.endColor)],
                        startPoint: .top,
                        endPoint: .bottom
                    ).ignoresSafeArea(.all)
                    
                    VStack {
                        Spacer(minLength: 104)
                        Text(Constants.title)
                            .foregroundColor(.white)
                            .font(.system(size: 40, weight: .bold))
                        Spacer(minLength: 40)
                        Image(Constants.imageName)
                        Spacer(minLength: 116)
                        getStartedView
                        Spacer(minLength: 121)
                    }
                }
            }
        }
    }
    
    var gradientText: some View {
        LinearGradient(
            colors: [Color(Constants.startButtonColor), Color(Constants.endButtonColor)],
            startPoint: .top,
            endPoint: .bottom
        ).mask {
            Text(Constants.buttonTitle)
                .font(.system(size: 20, weight: .bold))
        }
    }
    
    var getStartedView: some View {
        VStack {
            NavigationLink(destination: DetailsView()) {
                gradientText
                .background(.white)
                .frame(width: 300, height: 55)
                .cornerRadius(27)
            }
            
            Spacer(minLength: 75)
            Text(Constants.bottomText)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .bold))
            Spacer(minLength: 12)
            
            NavigationLink(destination: AuthorizationView()) {
                VStack {
                    Text(Constants.bottomTitle)
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .bold))
                        .frame(width: 200, height: 34)
                   Divider()
                        .background(Color.white)
                        .frame(width: 150)
                }
            }
        }
    }
}



extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

