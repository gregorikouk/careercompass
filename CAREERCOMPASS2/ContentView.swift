//
//  C.swift
//  CAREERCOMPASS
//
//  Created by gregorikouk.dev on 5/5/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    let dblue = Color("dblue")
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                VStack(spacing: 0) {
                    switch selectedTab {
                    case 0: Homepage(selectedTab: $selectedTab)
                            .padding(.top, 60)
                    case 1: ArticlesView()
                            .padding(.top, 60)
                    case 2: PuzzleView()
                            .padding(.top, 60)
                    case 3: MediaView()
                            .padding(.top, 60)
                    case 4: SettingsView()
                            .padding(.top, 60)
                    default: Homepage(selectedTab: $selectedTab)
                            .padding(.top, 60)
                    }
                }
                .padding(.bottom, 65) // Adjust height based on tab bar height
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
            }
            
            HStack {
                ForEach(0..<5) { index in
                    let icons = ["house", "book", "puzzle", "users", "settings"]
                    Button(action: {
                        selectedTab = index
                    }) {
                        Image(icons[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .opacity(selectedTab == index ? 1.0 : 0.3)
                            .frame(maxWidth: .infinity)
                            .padding(.top)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            .padding(.bottom, 30)
            .background(Color.white)
            .cornerRadius(20, corners: [.topLeft, .topRight])
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: -5)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
