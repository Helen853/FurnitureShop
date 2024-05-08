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
        static let url = "https://s00.yaplakal.com/pics/pics_original/9/2/6/17827629.jpg"
        
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
                        asyncImage
                        Spacer(minLength: 116)
                        getStartedView
                        Spacer()
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
    
    var asyncImage: some View {
        AsyncImage(url: URL(string: Constants.url)) { phase in
            switch phase {
            case .empty:
                Image(Constants.imageName)
            case .success(let image):
                image
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(.white)
                    }
                    .shadow(radius: 20)
            case .failure(_):
                Image(Constants.imageName)
            @unknown default:
                fatalError()
            }
        }
    }
}

struct StartedView_Previews: PreviewProvider {
    static var previews: some View {
        StartedView()
    }
}
