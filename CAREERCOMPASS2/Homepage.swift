//
//  ContentView.swift
//  CAREERCOMPASS
//
//  Created by gregorikouk.dev on 7/4/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct Homepage: View {
    
    @State var bg_color = Color("background")
    @State var dblue = Color("dblue")
    @State var lblue = Color("lblue")
    
    @State private var articles: [Article] = []
    
    @State private var showSplash = false
    
    @State private var showChat = false
    @State private var chatId: String? = nil
    @State private var userId = "user_123" // Αντίστοιχα πάρε πραγματικό uid
    
    @Binding var selectedTab: Int
    
    var body: some View {
        NavigationStack {
            ZStack {
                ZStack {
                    bg_color.ignoresSafeArea()
                    VStack {
                        Spacer()
                        Image("vector2")
                            .resizable()
                            .frame(maxWidth: .infinity, maxHeight: 300)
                    }.ignoresSafeArea()
                }
                
                ScrollView {
                    VStack(spacing: 0) {
                        HStack {
                            Text("CAREERCOMPASS")
                                .font(.title3)
                                .fontWeight(.heavy)
                                .scaleEffect(x: 1.0, y: 1.05)
                                .foregroundColor(dblue)
                            Spacer()
                            
                            Button {
//                                createChatSession { id in
//                                    chatId = id
//                                    showChat = true
//                                }
                                showSplash = true
                            } label: {
                                Image("chat")
                                    .resizable()
                                    .frame(width: 26, height: 26)
                                    .padding()
                                    .background(
                                        Image("waves")
                                            .resizable()
                                            .frame(width: 200, height: 200)
                                    )
                            }
                            .fullScreenCover(isPresented: $showChat) {
                                if let chatId = chatId {
                                    WaitingForAgentView(chatId: chatId, userId: userId)
                                }
                            }
                            
                            
                        }
                        
                        HStack {
                            Button {
                                
                            } label: {
                                Rectangle()
                                    .frame(width: 130, height: 30)
                                    .foregroundStyle(dblue)
                                    .cornerRadius(20)
                                    .overlay {
                                        HStack(spacing: 4) {
                                            Image("paperplane")
                                                .resizable()
                                                .frame(width: 14, height: 14)
                                            
                                            Text("Αθήνα, Ελλάδα")
                                                .foregroundStyle(.white)
                                                .font(.caption)
                                                .fontWeight(.heavy)
                                        }
                                    }
                            }
                            
                            Spacer()
                        }
                        .padding(.bottom, 20)
                        
                        Rectangle()
                            .foregroundColor(lblue)
                            .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 30)
                            .cornerRadius(5)
                            .overlay {
                                HStack {
                                    Text("Άρθρα που ίσως σε ενδιαφέρουν")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .padding()
                                    Spacer()
                                }
                            }
                            .padding(.bottom, 10)
                        
                        //ARTICLES
                        if !articles.isEmpty {
                            VStack(spacing: 12) { // φυσιολογικό spacing ανάμεσα στα άρθρα
                                ForEach(articles, id: \.self) { article in
                                    NavigationLink(destination: ArticleDetailView(article: article)) {
                                        HStack(alignment: .top, spacing: 12) {
                                            // Εικόνα – ~1/3 πλάτους
                                            AsyncImage(url: URL(string: article.image)) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: UIScreen.main.bounds.width * 0.3, height: 100)
                                                    .clipped()
                                                    .cornerRadius(8)
                                            } placeholder: {
                                                Color.gray
                                                    .frame(width: UIScreen.main.bounds.width * 0.3, height: 100)
                                                    .cornerRadius(8)
                                            }

                                            // Κείμενα – στοιχισμένα επάνω
                                            VStack(alignment: .leading, spacing: 6) {
                                                Text(article.title)
                                                    .foregroundColor(dblue)
                                                    .font(.callout)
                                                    .fontWeight(.bold)
                                                    .lineLimit(2)
                                                    .multilineTextAlignment(.leading)

                                                Text(article.detailed)
                                                    .foregroundColor(lblue)
                                                    .font(.caption)
                                                    .lineLimit(3)
                                                    .truncationMode(.tail)
                                            }
                                            .frame(maxHeight: 100, alignment: .top) // ώστε να ευθυγραμμίζεται με την εικόνα
                                        }
                                        .contentShape(Rectangle()) // όλο το HStack πατιέται
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.bottom, 20)
                        }
                        
//                        Rectangle()
//                            .foregroundColor(lblue)
//                            .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 30)
//                            .cornerRadius(5)
//                            .overlay {
//                                HStack {
//                                    Text("Εκδηλώσεις που ίσως σε ενδιαφέρουν")
//                                        .foregroundColor(.white)
//                                        .fontWeight(.bold)
//                                        .padding()
//                                    Spacer()
//                                }
//                            }
//                            .padding(.bottom, 10)
//                        ForEach(events, id: \.self) { event in
//                            VStack {
//                                HStack(alignment: .top) {
//                                    Image(event.image)
//                                        .resizable()
//                                        .aspectRatio(100 / 70, contentMode: .fill)
//                                        .frame(width: 100, height: 70)
//                                        .clipped()
//                                        .cornerRadius(10)
//                                    Spacer()
//                                    VStack(alignment: .leading) {
//                                        Text(event.title)
//                                            .foregroundColor(dblue)
//                                            .fontWeight(.bold)
//                                            .font(.callout)
//                                            .frame(maxWidth: .infinity, alignment: .leading)
//                                        Text(event.content)
//                                            .foregroundColor(lblue)
//                                            .font(.caption)
//                                            .lineLimit(3)
//                                    }
//                                }
//                                HStack {
//                                    Text(event.date)
//                                        .foregroundColor(dblue)
//                                        .font(.subheadline)
//                                    Spacer()
//                                    Text(event.loc)
//                                        .foregroundColor(dblue)
//                                        .font(.subheadline)
//                                }
//                            }
//                        }
//                        .padding(.bottom, 10)
                        Rectangle()
                            .foregroundColor(lblue)
                            .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 30)
                            .cornerRadius(5)
                            .overlay {
                                HStack {
                                    Text("Ώρα για κουίζ")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .padding()
                                    Spacer()
                                }
                            }
                        Text("Σχεδιάστηκε για να αναδείξει τις ιδιαίτερες ικανότητες, τα ενδιαφέροντα και τις δυνατότητες του κάθε συμμετέχοντα. Το κουίζ προσφέρει μια εμπειρία που όχι μόνο δίνει πληροφορίες για επαγγελματικά πεδία, αλλά και ενισχύει τον συνολικό αυτογνωσιακό προσανατολισμό του συμμετέχοντα. Το κουίζ αντικατοπτρίζει την πρόκληση και τον ενθουσιασμό για την ανακάλυψη νέων πτυχών του εαυτού και των δυνατοτήτων του.")
                            .padding(.top, 10)
                            .font(.subheadline)
                            .foregroundStyle(dblue)
                        
                        Button {
                            selectedTab = 2
                        } label: {
                            Rectangle()
                                .frame(width: 235, height: 35)
                                .foregroundStyle(.dblue)
                                .cornerRadius(8)
                                .overlay {
                                    Text("Ξεκίνησε με ένα γρήγορο κλικ")
                                        .foregroundStyle(.white)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                }
                        }
                        .padding()
                        
                        
                        Image("10306")
                            .resizable()
                            .frame(width: 150, height: 60)
                    }
                    .padding()
                }.scrollIndicators(.hidden)
            }
            .fullScreenCover(isPresented: $showSplash) {
                SplashScreenView {
                    createChatSession { id in
                        if !id.isEmpty {
                            chatId = id
                            showChat = true
                        } else {
                            print("Error: chatId is empty, not navigating")
                        }
                    }
                    showSplash = false
                }
            }
            NavigationLink(isActive: $showChat) {
                if let chatId = chatId {
                    WaitingForAgentView(chatId: chatId, userId: userId)
                }
            } label: {
                EmptyView()
            }
        }
        .onAppear {
            fetchArticles()
        }
        
    }
    func createChatSession(completion: @escaping (String) -> Void) {
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        
        let data: [String: Any] = [
            "userId": userId,
            "representativeId": "",
            "isActive": true,
            "createdAt": Timestamp(date: Date())
        ]
        
        ref = db.collection("chats").addDocument(data: data) { error in
            if let error = error {
                print("Error creating chat session:", error.localizedDescription)
            } else if let id = ref?.documentID {
                completion(id)
            }
        }
    }
    
    func fetchArticles() {
        let db = Firestore.firestore()
        db.collection("articles")
            .order(by: "date", descending: true)
            .limit(to: 3)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching articles: \(error)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No documents found")
                    return
                }
                
                // Μετατροπή των Firestore documents σε Article struct
                articles = documents.compactMap { doc in
                    let data = doc.data()
                    return Article(
                        image: data["imageUrl"] as? String ?? "",
                        title: data["title"] as? String ?? "",
                        content: data["content"] as? String ?? "",
                        detailed: data["detailed"] as? String ?? "",
                        date: data["date"] as? String ?? "",
                        author: data["author"] as? String ?? "", category: data["category"] as? String ?? ""
                    )
                }
            }
    }
}

//#Preview {
//    Homepage()
//}
