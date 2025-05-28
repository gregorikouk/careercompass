import SwiftUI

struct ArticlesView: View {

    @StateObject private var viewModel = ArticlesViewModel()

    @State var bg_color = Color("background")
    @State var dblue = Color("dblue")
    @State var lblue = Color("lblue")
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("background").ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("'ΑΡΘΡΑ")
                                .foregroundStyle(Color("dblue"))
                                .fontWeight(.heavy)
                                .font(.title2)
                                .padding()
                            Spacer()
                        }
                        
                        VStack(spacing: 16) {
                            HStack(spacing: 16) {
                                Button(action: {
                                    viewModel.selectedTab = "all"
                                }) {
                                    Text("All")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .padding(.vertical, 10)
                                        .frame(maxWidth: .infinity)
                                        .background(viewModel.selectedTab == "all" ? dblue : Color.white)
                                        .foregroundColor(viewModel.selectedTab == "all" ? .white : dblue)
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(dblue, lineWidth: 1)
                                        )
                                }

                                Button(action: {
                                    viewModel.selectedTab = "foryou"
                                }) {
                                    Text("For You")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .padding(.vertical, 10)
                                        .frame(maxWidth: .infinity)
                                        .background(viewModel.selectedTab == "foryou" ? dblue : Color.white)
                                        .foregroundColor(viewModel.selectedTab == "foryou" ? .white : dblue)
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(dblue, lineWidth: 1)
                                        )
                                }
                            }
                            .padding(.horizontal)

                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .padding(.leading, 12)
                                
                                ZStack(alignment: .trailing) {
                                    TextField("Αναζήτηση άρθρων...", text: $viewModel.searchText)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 8)
                                        .background(Color(.systemGray6))
                                        .cornerRadius(10)

                                    if !viewModel.searchText.isEmpty {
                                        Button(action: {
                                            viewModel.searchText = ""
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.gray)
                                                .padding(.trailing, 8)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 4)
                            .padding(.horizontal)
                        }
                        .padding(.bottom, 15)
                    
                        
                        if viewModel.selectedTab == "foryou" && viewModel.quizResult == 0 {
                            HStack {
                                Spacer()
                                Text("Δεν έχετε ολοκληρώσει ακόμα το quiz.")
                                    .foregroundStyle(Color("lblue"))
                                    .padding()
                                Spacer()
                            }
                        } else if viewModel.filteredArticles.isEmpty {
                            HStack {
                                Spacer()
                                Text("Δεν υπάρχουν άρθρα.")
                                    .foregroundStyle(Color("lblue"))
                                    .padding()
                                Spacer()
                            }
                        } else {
                            ForEach(viewModel.filteredArticles, id: \.self) { article in
                                NavigationLink(destination: ArticleDetailView(article: article)) {
                                    VStack(alignment: .leading) {
                                        AsyncImage(url: URL(string: article.image)) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            Color.gray
                                        }
                                        .frame(maxWidth: .infinity, maxHeight: 170)
                                        .clipped()
                                        .cornerRadius(10)
                                        .padding(.top)
                                        
                                        Text(article.title)
                                            .foregroundStyle(dblue)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .padding(.vertical, 10)
                                        
                                        Text(article.detailed)
                                            .foregroundStyle(lblue)
                                            .font(.subheadline)
                                        
                                        Divider()
                                            .padding(.vertical, 10)
                                        
                                        HStack {
                                            Text(article.date)
                                                .font(.caption)
                                                .foregroundStyle(.gray)
                                            Spacer()
                                            Text(article.author)
                                                .font(.caption)
                                                .foregroundStyle(.gray)
                                        }
                                        .padding(.bottom)
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .padding(.horizontal)
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                .refreshable {
                    viewModel.fetchArticles()
                }
            }
            .onAppear {
                viewModel.fetchArticles()
                viewModel.fetchQuizResult()
                print("Fetch successfull")
            }
        }
    }
}

// Preview ViewModel με mock data
class MockArticlesViewModel: ArticlesViewModel {
    override init() {
        super.init()
        self.articles = [
            Article(
                image: "https://via.placeholder.com/600x300",
                title: "Δοκιμαστικός Τίτλος Άρθρου",
                content: "Περιεχόμενο άρθρου",
                detailed: "Αναλυτική περιγραφή για το δοκιμαστικό άρθρο. Είναι μία μεγαλύτερη παράγραφος για να γεμίσει το preview.",
                date: "24/05/2025",
                author: "Γρηγόριος Κουκ.", category: "Αναλυτικός"
            ),
            Article(
                image: "https://via.placeholder.com/600x300",
                title: "Δεύτερο Δοκιμαστικό Άρθρο",
                content: "Περίληψη άρθρου",
                detailed: "Δεύτερη αναλυτική περιγραφή για άλλο άρθρο, που δείχνει την ποικιλία των περιεχομένων.",
                date: "22/05/2025",
                author: "Άλλος Συντάκτης", category: "Δημιουργικός"
            )
        ]
    }
}

#Preview {
    ArticlesView()
        .environmentObject(MockArticlesViewModel())
}
