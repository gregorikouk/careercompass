# CareerCompass - Source Code Overview

Αυτό το repository περιέχει τον πηγαίο κώδικα της εφαρμογής **CareerCompass** για iOS SwiftUI και του admin/agent dashboard (React.js).

---

## iOS (SwiftUI) Εφαρμογή

### CAREERCOMPASS2App.swift
- **Entry point της εφαρμογής.**
- Εκκινεί την εφαρμογή και ορίζει το αρχικό view (συνήθως το `ContentView`).

### ContentView.swift
- **Κύριο container και root navigation της εφαρμογής.**
- Ελέγχει τη ροή μεταξύ των βασικών tabs και παρουσιάζει τα κύρια modules (quiz, άρθρα, βίντεο, chat, ρυθμίσεις κ.λπ.).

### SplashScreenView.swift
- **Εμφανίζει το λογότυπο και ένα εναρκτήριο animation/οθόνη** όσο φορτώνεται η εφαρμογή ή τα δεδομένα.

### Homepage.swift
- **Η αρχική σελίδα που υποδέχεται τον χρήστη.**
- Παρέχει γρήγορη πρόσβαση στα βασικά modules: quiz, άρθρα, βίντεο, live chat.
- Μπορεί να εμφανίζει συνοπτικές πληροφορίες ή banners.

---

#### Authentication

- **LoginView.swift:**  
  Παρουσιάζει τη φόρμα σύνδεσης με email/password και διαχειρίζεται την είσοδο του χρήστη μέσω του ViewModel.
- **AuthViewModel.swift:**  
  Όλη η λογική για authentication: διαχείριση εγγραφής/σύνδεσης/αποσύνδεσης, διατήρηση του state χρήστη, σύνδεση με Firebase Auth.

---

#### Quiz

- **QuizView.swift:**  
  Εμφανίζει τις ερωτήσεις μία-μία, επιτρέπει επιλογές απάντησης και μετακινεί τον χρήστη στην επόμενη ερώτηση.
- **QuizViewModel.swift:**  
  Λογική για φόρτωση ερωτήσεων, αποθήκευση απαντήσεων, υπολογισμός αποτελέσματος, μετάβαση σε επόμενο βήμα.
- **QuizResultView.swift:**  
  Δείχνει το αποτέλεσμα/ανάλυση του quiz, π.χ. ποιος τύπος επαγγελματικής προσωπικότητας αντιστοιχεί στον χρήστη.

---

#### Άρθρα (Articles)

- **Articles.swift:**  
  Το μοντέλο `Article` (δομή αντικειμένου) με πεδία όπως id, title, content, category, author, date, imageUrl, detailed.
- **ArticlesViewModel.swift:**  
  Κεντρικό ViewModel για διαχείριση άρθρων: φόρτωση από Firebase Firestore, φιλτράρισμα ανά κατηγορία, refresh, αποθήκευση cache, χειρισμός σφαλμάτων.
- **ArticlesView.swift:**  
  Εμφανίζει τη λίστα των άρθρων, υποστηρίζει φιλτράρισμα σε tabs ("Όλα", "Όσα με ενδιαφέρουν"), προβολή προεπισκόπησης και navigation στο αναλυτικό view.
- **ArticleDetailView.swift:**  
  Εμφανίζει όλες τις πληροφορίες ενός επιλεγμένου άρθρου (title, author, image, content, detailed) με πλήρες layout και navigation back.

---

#### Βίντεο (Media/Eκπαιδευτικά)

- **Videos.swift:**  
  Μοντέλο δεδομένων ή static array για τα διαθέσιμα βίντεο που προβάλλονται στην εφαρμογή (id, title, url).
- **MediaView.swift:**  
  Σελίδα που εμφανίζει τη λίστα εκπαιδευτικών βίντεο, συνδέεται με το YouTube/YouTubePlaylistViewModel για live data.
- **YouTubeVideo.swift:**  
  Μοντέλο που περιγράφει ένα video από το YouTube (id, τίτλος, περιγραφή, thumbnail).
- **YouTubePlaylistViewModel.swift:**  
  ViewModel που συνδέεται με το YouTube API, ανακτά βίντεο από playlist, κάνει parsing και παρέχει τα δεδομένα στο MediaView.

---

#### Chat (Live Υποστήριξη)

- **ChatView.swift:**  
  Βασικό UI της συνομιλίας μεταξύ χρήστη και agent/counselor. Εμφανίζει το ιστορικό των μηνυμάτων, input για αποστολή νέου μηνύματος, και ενδείξεις κατάστασης.
- **ChatViewModel.swift:**  
  Ο "εγκέφαλος" του chat. Συνδέεται με το Firestore, φροντίζει για αποστολή/λήψη μηνυμάτων, real-time ενημέρωση, έλεγχο κατάστασης (αν ο agent είναι συνδεδεμένος κ.λπ.).
- **ChatMessage.swift:**  
  Μοντέλο για το κάθε μήνυμα (id, senderId, text, timestamp).
- **ChatMessageObserver.swift:**  
  Listener/observer που παρακολουθεί για νέες αλλαγές στα μηνύματα του chat και ενημερώνει το UI σε πραγματικό χρόνο.
- **ChatSessionObserver.swift:**  
  Παρακολουθεί την κατάσταση της τρέχουσας συνομιλίας (π.χ. αν τερματιστεί από agent, αλλαγή agent, ενεργή/ανενεργή).
- **WaitingForAgentView.swift:**  
  Οθόνη που δείχνει στον χρήστη ότι βρίσκεται σε αναμονή για να τον αναλάβει agent/σύμβουλος (εμφανίζεται πριν ξεκινήσει το live chat).

---

#### Άλλα

- **PuzzleView.swift:**  
  Περιέχει κάποιο μίνι-παιχνίδι ή gamified στοιχείο (π.χ. εκπαιδευτικό puzzle ή quiz).
- **Events.swift:**  
  Μοντέλο ή λογική για διαχείριση εκπαιδευτικών/κοινωνικών events (αν χρησιμοποιείται στο project).
- **SettingsView.swift:**  
  Εμφανίζει και διαχειρίζεται τις ρυθμίσεις της εφαρμογής (ενεργοποίηση/απενεργοποίηση features, account settings κλπ).
- **GoogleService-Info.plist:**  
  Αρχείο ρυθμίσεων Firebase. Περιλαμβάνει κλειδιά και configs για να συνδεθεί το app με το Firebase project.

---

## React (Web admin panel / Agent dashboard)

### App.js
- **Κύριο αρχείο της web εφαρμογής για agent και admin.**
- Υλοποιεί δύο βασικές λειτουργίες:
  - **Live Chat:** Εμφανίζει όλες τις ενεργές συνεδρίες από Firestore, επιτρέπει στον agent να επιλέξει συνομιλία, να στείλει απάντηση και να τερματίσει συνεδρία. Όλα τα μηνύματα είναι real-time.
  - **Διαχείριση Άρθρων (Articles):**  
    - CRUD λειτουργίες (Create, Read, Update, Delete) για άρθρα.
    - Ο agent/admin μπορεί να προσθέσει νέα άρθρα (με πεδία τίτλος, περιεχόμενο, κατηγορία, συγγραφέας, εικόνα κ.λπ.), να επεξεργαστεί ή να διαγράψει υπάρχοντα, και να δει όλα τα άρθρα.
    - Όλα τα δεδομένα διαβάζονται/ενημερώνονται real-time από το Firestore.
- Περιέχει όλο το styling (μέσα στο ίδιο αρχείο), την πλοήγηση ανάμεσα σε Chat/Articles, και το initialization του Firebase.
- Δεν περιέχει ξεχωριστά components: όλη η λογική είναι συγκεντρωμένη στο ίδιο αρχείο για απλότητα.
