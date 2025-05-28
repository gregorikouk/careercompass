//
//  QuizViewModel.swift
//  CAREERCOMPASS2
//
//  Created by gregorikouk.dev on 25/5/25.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

class QuizViewModel: ObservableObject {
    struct Question {
        let text: String
        let options: [String]
        let scores: [Int] // index 0: Analytical, 1: Creative, 2: Social, 3: Practical, 4: Leader
    }

    @Published var userHasResult = false
    @Published var userResultType: Int? = nil
    
    @Published var currentIndex = 0
    @Published var score = [0, 0, 0, 0, 0]
    @Published var showResult = false

    let questions: [Question] = [
        Question(text: "Πώς σου αρέσει να λύνεις ένα πρόβλημα;",
                 options: ["Αναλύοντας τα δεδομένα", "Χρησιμοποιώντας δημιουργικές ιδέες", "Συζητώντας το με άλλους", "Με πρακτική δοκιμή", "Οργανώνοντας τους άλλους"],
                 scores: [0, 1, 2, 3, 4]),

        Question(text: "Ποια δραστηριότητα σε ελκύει περισσότερο;",
                 options: ["Να λύσω μια εξίσωση", "Να δημιουργήσω ένα video", "Να βοηθήσω έναν φίλο", "Να φτιάξω κάτι με τα χέρια μου", "Να ηγηθώ μιας ομάδας"],
                 scores: [0, 1, 2, 3, 4]),

        Question(text: "Ποιο project θα διάλεγες στο σχολείο;",
                 options: ["Έρευνα με δεδομένα", "Δημιουργία αφίσας", "Ομαδική παρουσίαση", "Κατασκευή μοντέλου", "Διοργάνωση εκδήλωσης"],
                 scores: [0, 1, 2, 3, 4]),

        Question(text: "Πώς νιώθεις για τους κανόνες;",
                 options: ["Με βοηθούν να οργανώνομαι", "Με περιορίζουν", "Δεν με πειράζουν", "Εξαρτάται", "Τους εφαρμόζω για να έχω έλεγχο"],
                 scores: [0, 1, 2, 3, 4]),

        Question(text: "Τι ρόλο προτιμάς σε μια ομάδα;",
                 options: ["Ο αναλυτής", "Ο δημιουργικός", "Ο υποστηρικτής", "Ο τεχνικός", "Ο αρχηγός"],
                 scores: [0, 1, 2, 3, 4]),

        Question(text: "Ποιο επάγγελμα σου ταιριάζει περισσότερο;",
                 options: ["Μηχανικός", "Γραφίστας", "Ψυχολόγος", "Τεχνικός", "Διευθυντής"],
                 scores: [0, 1, 2, 3, 4]),

        Question(text: "Ποιο είναι το μεγαλύτερο σου προσόν;",
                 options: ["Η λογική", "Η φαντασία", "Η ενσυναίσθηση", "Η πρακτικότητα", "Η οργανωτικότητα"],
                 scores: [0, 1, 2, 3, 4]),

        Question(text: "Ποια φράση σε εκφράζει περισσότερο;",
                 options: ["Κάθε πρόβλημα έχει λύση", "Η φαντασία δεν έχει όρια", "Άκου πρώτα, μετά μίλα", "Δοκίμασε ξανά", "Οργάνωσε, εκτέλεσε, πέτυχε"],
                 scores: [0, 1, 2, 3, 4]),

        Question(text: "Πώς αντιμετωπίζεις την αποτυχία;",
                 options: ["Αναλύω τα λάθη", "Ξαναδοκιμάζω με νέα ιδέα", "Συζητώ με φίλους", "Επιμένω πρακτικά", "Κάνω νέο σχέδιο"],
                 scores: [0, 1, 2, 3, 4]),

        Question(text: "Τι θα προτιμούσες στον ελεύθερό σου χρόνο;",
                 options: ["Sudoku ή ντοκιμαντέρ", "Ζωγραφική ή video", "Εθελοντισμό", "Κατασκευές", "Διοργάνωση event"],
                 scores: [0, 1, 2, 3, 4])
    ]

    var progress: CGFloat {
        CGFloat(currentIndex) / CGFloat(questions.count)
    }

    func selectOption(index: Int) {
        let selectedType = questions[currentIndex].scores[index]
        score[selectedType] += 1
    }

    func nextQuestion() {
        if currentIndex + 1 < questions.count {
            currentIndex += 1
        } else {
            showResult = true
            saveResultToFirebase()
        }
    }
    
//    func loadUserQuizResult() {
//            guard let uid = Auth.auth().currentUser?.uid else {
//                userHasResult = false
//                return
//            }
//            
//            let db = Firestore.firestore()
//            db.collection("quizResults").document(uid).getDocument { snapshot, error in
//                if let data = snapshot?.data(), let resultType = data["resultType"] as? Int {
//                    DispatchQueue.main.async {
//                        self.userHasResult = true
//                        self.userResultType = resultType
//                    }
//                } else {
//                    DispatchQueue.main.async {
//                        self.userHasResult = false
//                    }
//                }
//            }
//        }
    
    func loadUserQuizResult() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("No logged in user")
            userHasResult = false
            return
        }

        print("Loading quiz result for user: \(uid)")
        let db = Firestore.firestore()
        
        // 🔁 ΔΙΟΡΘΩΜΕΝΟ PATH ➜ από "quizResults" σε "users"
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Error loading quiz result: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.userHasResult = false
                }
                return
            }

            guard let snapshot = snapshot else {
                print("No snapshot returned")
                DispatchQueue.main.async {
                    self.userHasResult = false
                }
                return
            }

            if snapshot.exists {
                let data = snapshot.data()
                print("Snapshot data: \(String(describing: data))")
                if let resultType = data?["quizResult"] as? Int {
                    DispatchQueue.main.async {
                        self.userHasResult = true
                        self.userResultType = resultType
                        print("✅ Loaded quizResult: \(resultType)")
                    }
                } else {
                    print("No 'quizResult' in document data")
                    DispatchQueue.main.async {
                        self.userHasResult = false
                    }
                }
            } else {
                print("Document does not exist")
                DispatchQueue.main.async {
                    self.userHasResult = false
                }
            }
        }
    }
    
    func resultDescription() -> String {
        guard let type = userResultType else { return "Άγνωστο" }
        let descriptions = ["Δημιουργικός", "Αναλυτικός", "Κοινωνικός", "Πρακτικός", "Ηγέτης"]
        let index = max(0, min(type - 1, descriptions.count - 1)) // Προστασία από λάθος τιμές
        return descriptions[index]
    }
    
        
    func dominantType() -> Int {
        score.enumerated().max(by: { $0.element < $1.element })?.offset ?? 0
    }

    func saveResultToFirebase() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let type = dominantType() + 1 // 1–5
        let db = Firestore.firestore()
        db.collection("users").document(uid).setData([
            "quizResult": type
        ], merge: true) // ✅ Με merge για να μην χαθούν άλλα δεδομένα
    }
}
