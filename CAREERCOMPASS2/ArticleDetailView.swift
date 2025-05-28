import SwiftUI

struct ArticleDetailView: View {
    var article: Article
    @Environment(\.dismiss) private var dismiss

    @State var bg_color = Color("background")
    @State var dblue = Color("dblue")
    @State var lblue = Color("lblue")

    var body: some View {
        ZStack {
            bg_color.ignoresSafeArea()

            VStack(spacing: 0) {
                // Custom header
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(dblue)
                    }
                    Text("Άρθρο")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(dblue)
                        .padding(.leading, 8)

                    Spacer()
                }
                .padding()
                .background(bg_color)
                .shadow(color: .black.opacity(0.1), radius: 2, y: 2)

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        AsyncImage(url: URL(string: article.image)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(10)

                        Text(article.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(dblue)

                        Text("Από: \(article.author)")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Text("Ημερομηνία: \(article.date)")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Divider()

                        Text(article.content)
                            .font(.body)
                            .foregroundColor(lblue)
                    }
                    .padding()
                }
            }
        }
        .navigationBarHidden(true)  // Κρύβει το default navigation bar
    }
}
