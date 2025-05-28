//
//  ArticlesViewModel.swift
//  CAREERCOMPASS2
//
//  Created by gregorikouk.dev on 24/5/25.
//
import Foundation
import FirebaseFirestore
import FirebaseAuth

class ArticlesViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var quizResult: Int = 0
    @Published var selectedTab: String = "all"
    @Published var searchText: String = ""
    func fetchArticles() {
        let db = Firestore.firestore()
        db.collection("articles").order(by: "date", descending: true).getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching articles: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            self.articles = documents.compactMap { doc in
                try? doc.data(as: Article.self)
            }
        }
    }

    func fetchQuizResult() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Ο χρήστης δεν είναι συνδεδεμένος")
            return
        }

        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Σφάλμα στην ανάκτηση quizResult:", error)
                return
            }

            if let data = snapshot?.data(),
               let result = data["quizResult"] as? Int {
                DispatchQueue.main.async {
                    self.quizResult = result
                }
            } else {
                print("Δεν βρέθηκε quizResult")
            }
        }
    }

    var filteredArticles: [Article] {
        let categoryMap: [Int: String] = [
            1: "Αναλυτικός",
            2: "Δημιουργικός",
            3: "Κοινωνικός",
            4: "Πρακτικός",
            5: "Ηγετικός"
        ]

        let base: [Article]
        if selectedTab == "foryou" {
            if let category = categoryMap[quizResult] {
                base = articles.filter { $0.category == category }
            } else {
                return []
            }
        } else {
            base = articles
        }

        if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            return base
        } else {
            return base.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.content.localizedCaseInsensitiveContains(searchText) ||
                $0.detailed.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
