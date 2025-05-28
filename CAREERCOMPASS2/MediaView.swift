//
//  MediaView.swift
//  CAREERCOMPASS
//
//  Created by gregorikouk.dev on 5/5/25.
//

import SwiftUI

struct MediaView: View {
    
    @State var bg_color = Color("background")
    @State var dblue = Color("dblue")
    @State var lblue = Color("lblue")
    
    @StateObject private var viewModel = YouTubePlaylistViewModel()
    
    var body: some View {
        ZStack {
            bg_color.ignoresSafeArea()
            VStack {
                Spacer()
                Image("vector2")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 300)
            }.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("MEDIA")
                            .foregroundStyle(dblue)
                            .fontWeight(.heavy)
                            .font(.title2)
                        Spacer()
                    }
                    .padding()
                    
                    HStack {
                        Text("Παρακολουθήστε τώρα")
                            .foregroundStyle(dblue)
                            .fontWeight(.bold)
                            .font(.title3)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                    Image("live")
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: 184)
                        .padding(.horizontal)
                        .padding(.bottom, 30)
                    
                    Rectangle()
                        .foregroundColor(lblue)
                        .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 30)
                        .cornerRadius(5)
                        .overlay {
                            HStack {
                                Text("Βίντεο για να παρακολουθήσετε")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .padding()
                                Spacer()
                            }
                        }
                        .padding(.bottom, 10)
                        .padding(.horizontal)
                    
                    ForEach(viewModel.videos, id: \.self) { video in
                        Button {
                            if let url = URL(string: "https://www.youtube.com/watch?v=\(video.id)") {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            VStack(alignment: .leading, spacing: 8) {
                                AsyncImage(url: URL(string: video.thumbnailUrl)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(maxWidth: .infinity, maxHeight: 170)
                                .clipped()
                                .cornerRadius(10)
                                .padding(.horizontal)
                                
                                Text(video.title)
                                    .foregroundStyle(dblue)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                                    .padding(.bottom, 15)
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchVideos()
        }
    }
}

#Preview {
    MediaView()
}
