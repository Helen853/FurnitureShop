//
//  ProfileView.swift
//  FurnitureShop

import SwiftUI

struct UserPrifileView: View {
    
    private enum Constants {
        static let startColor = "startGraund"
        static let endColor = "endGround"
        static let avatarName = "avatar"
        static let avatarColor = "avatarColor"
        static let nameTitle = "Your Name"
        static let location = "location"
        static let sityText = "Sity"
        static let notificationText = "Notification"
        static let accountText = "Accounts Details"
        static let purchasesText = "My purchases"
        static let settingsText = "Settings"
        static let sityImageName = "sity"
        static let notificationImageName = "notification"
        static let accountImageName = "account"
        static let purchasesImageName = "purchases"
        static let settingsImageName = "settings"
    }
    
    private let chapters: [Chapter] = [
        .init(image: Constants.accountImageName, title: Constants.accountText),
        .init(image: Constants.purchasesImageName, title: Constants.purchasesText),
        .init(image: Constants.settingsImageName, title: Constants.settingsText)
    ]
    
    private let chaptersBadge: [ChapterBadge] = [
        .init(image: Constants.sityImageName, title: Constants.sityText, nitifications: "2"),
        .init(image: Constants.notificationImageName, title: Constants.notificationText, nitifications: "3")
    ]
    
    @State private var linkActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                gradientView.frame(height: 40)
                Image(Constants.avatarName)
                    .background(Color(Constants.avatarColor))
                    .clipShape(Circle())
                Text(Constants.nameTitle)
                    .foregroundColor(.gray)
                    .bold()
                    .font(.system(size: 24))
                
                HStack {
                    Image(Constants.location)
                    Text(Constants.sityText)
                        .foregroundColor(.gray)
                        .font(.system(size: 20))
                }
                List {
                    ForEach(0..<chaptersBadge.count) { item in
                        makeListBadge(item: chaptersBadge[item])
                        
                    }
                    ForEach(0..<chapters.count-1) { item in
                        makeList(item: chapters[item])
                    }
                    makeList(item: chapters[2])
                        .background(
                            NavigationLink("", destination: PaymentView())
                                .opacity(0)
                        )
                }.listStyle(.plain)
                Spacer()
            }.background(.white)
                .navigationBarBackButtonHidden(true)
        }
    }
    
    private var gradientView: some View {
        ZStack {
            LinearGradient(
                colors: [Color(Constants.startColor), Color(Constants.endColor)],
                startPoint: .leading,
                endPoint: .trailing
            ).ignoresSafeArea(.all)
        }
    }
    
    private func makeListBadge(item: ChapterBadge) -> some View {
        HStack {
            Image(item.image)
            Text(item.title)
            Spacer()
            Text(item.nitifications)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(
                    LinearGradient(
                        colors: [Color(Constants.startColor), Color(Constants.endColor)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .cornerRadius(15)
        }
    }
    
    private func makeList(item: Chapter) -> some View {
        HStack {
            Image(item.image)
            Text(item.title)
        }
    }
}
