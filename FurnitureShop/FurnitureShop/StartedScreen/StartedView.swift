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
        static let url = "hhttps://s00.yaplakal.com/pics/pics_original/9/2/6/17827629.jpg"
        static let infoDevelop = "Version: 1.1.1 \n Developer: Helen Dudareva \n Date: 12.05.2024"
    }
    
    @State private var isActiveTitle = false
    @State private var tapped  = false
    @State private var isActiveText = false
    @State private var isActiveButton = false
    @State private var isActiveSing = false
    @State private var isShowTab = false
    @State private var isShowAuthorization = false
    @State private var loading = false
    
    var body: some View {
        NavigationView {
            if loading {
                LoadView()
            } else {
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
                                .font(.system(size: isActiveTitle ? 40 : 5, weight: .bold))
                                .offset(x: isActiveTitle ? 0 : -70)
                                .opacity(isActiveTitle ? 1 : 0)
                                .rotationEffect(Angle(degrees: isActiveTitle ? 0 : 360), anchor: .bottom)
                            Spacer(minLength: 40)
                            asyncImage
                            infoDevelop
                                .opacity(tapped ? 1 : 0)
                            getStartedView
                            Spacer()
                        }
                    }
                }.onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.linear(duration: 1).delay(0.3)) {
                            self.isActiveTitle = true
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation(.linear(duration: 1).delay(0.3)) {
                            self.isActiveButton = true
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                        withAnimation(.linear(duration: 1).delay(0.3)) {
                            self.isActiveText = true
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                        withAnimation(.linear(duration: 1).delay(0.3)) {
                            self.isActiveSing = true
                        }
                    }
                }
            }
            
        }
    }
    
    private var infoDevelop: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .frame(width: 250, height: 100)
                .cornerRadius(20, corners: [.topLeft, .bottomRight])
            Text(Constants.infoDevelop)
                .foregroundColor(Color(Constants.endColor))
                .font(.system(size: 20))
        }
    }
    
    private var long: some Gesture {
        LongPressGesture(minimumDuration: 2)
            .onEnded { _ in
                withAnimation {
                    self.tapped = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation(.linear(duration: 1).delay(0.3)) {
                        self.tapped = false
                    }
                }
            }
    }
    
    private var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in
                self.isShowTab = true
            }
    }
    
    private var tapLoad: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in
                withAnimation {
                    self.loading = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.linear(duration: 1).delay(0.3)) {
                        self.isShowAuthorization = true
                        self.loading = false
                    }
                }
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
    
    private var getStartedView: some View {
        VStack {
            NavigationLink(destination: Tab(), isActive: $isShowTab) {
                Button {
                    print("c")
                } label: {
                    gradientText
                    .background(.white)
                    .frame(width: 300, height: 55)
                    .cornerRadius(isActiveButton ? 27 : 5)
                }
                .simultaneousGesture(long)
                .simultaneousGesture(tap)
            }
            
            Spacer(minLength: 75)
            Text(Constants.bottomText)
                .foregroundColor(.white)
                .font(.system(size: isActiveText ? 16 : 9, weight: isActiveText ? .bold : .light))
            Spacer(minLength: 12)
            
            singButton
        }
    }
    
    private var singButton: some View {
        NavigationLink(destination: AuthorizationView(), isActive: $isShowAuthorization) {
            VStack {
                Text(Constants.bottomTitle)
                    .foregroundColor(.white)
                    .font(.system(size: 28, weight: .bold))
                    .frame(width: 200, height: 34)
                    .blur(radius: isActiveSing ? 0 : 10)
               Divider()
                    .background(Color.white)
                    .frame(width: 150)
            }.gesture(tapLoad)
        }
    }
    
    private var asyncImage: some View {
        AsyncImage(url: URL(string: Constants.url)) { phase in
            switch phase {
            case .empty:
                Image(Constants.imageName)
                    .blur(radius: isActiveTitle ? 10 : 0)
            case .success(let image):
                image
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
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
