//
//  Articles.swift
//  CAREERCOMPASS
//
//  Created by gregorikouk.dev on 7/4/25.
//

struct Event: Hashable {
    var image: String
    var title: String
    var content: String
    var date: String
    var loc: String
}

var events: [Event] = [
    Event(image: "python", title: "Γνωριμία με την γλώσσα Python", content: "Αποτελεί μια συναρπαστική εξερεύνηση για όσους θέλουν να μάθουν τις βασικές αρχές και τη λογική πίσω από την δημοφιλή και ευέλικτη γλώσσα προγραμματισμού.", date: "Κυριακή 8 Iουνίου", loc: "Online"),
    Event(image: "resume", title: "Πώς να φτιάξεις ένα άριστο βιογραφικό", content: "Ένα εργαστήριο που καθοδηγεί τους συμμετέχοντες στη δημιουργία ενός δυνατού και αποτελεσματικού βιογραφικού σημειώματος.", date: "Τετάρτη 12 Ιουνίου", loc: "Αίθουσα 3, Πανεπιστήμιο Αθηνών")
]
