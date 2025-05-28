//
//  SplashScreenView.swift
//  CAREERCOMPASS
//
//  Created by gregorikouk.dev on 22/5/25.
//
import SwiftUI

struct SplashScreenView: View {
    var onStart: () -> Void
    
    @State var bg_color = Color("background")
    @State var dblue = Color("dblue")
    @State var lblue = Color("lblue")
    
    var body: some View {
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
            
            VStack {
                HStack {
                    Text("Καλως ήρθες στην υπηρεσία")
                        .font(.title)
                        .foregroundStyle(dblue)
                        .bold()
                    Spacer()
                }
                HStack {
                    Text("Live Chat")
                        .font(.title2)
                        .foregroundStyle(dblue)
                    Spacer()
                }
                .padding(.bottom, 40)
                
                Text(
                    
                """
                Η υπηρεσία Live Chat με σύμβουλο ψυχικής υγείας παρέχει άμεση ψυχολογική υποστήριξη μέσω της εφαρμογής. Έτσι, μπορείς να συνδεθείς σε έναν εξειδικευμένο σύμβουλο μέσω του live chat, όπου μπορείς να εκφράσεις τις σκέψεις, τα συναισθήματα και τις ανησυχίες σου.
            
                Ο σύμβουλος ψυχικής υγείας παρέχει αμερόληπτη, ανώνυμη και εμπιστευτική υποστήριξη, ακούγοντας προσεκτικά και παρέχοντας κατανοητές συμβουλές. Μέσω του live chat, μπορείς να λάβεις βοήθεια για τη διαχείριση του στρες, των σχέσεων, των προσωπικών προβλημάτων και άλλων θεμάτων που επηρεάζουν τη ψυχική σου υγεία.
            
                Η υπηρεσία είναι προσιτή και ευέλικτη, προσφέροντας τη δυνατότητα να πραγματοποιείται πρόσβαση σε ψυχολογική υποστήριξη από οπουδήποτε και οποτεδήποτε, χωρίς την ανάγκη να κλείσεις ραντεβού ή να μετακινηθείς φυσικά σε ένα γραφείο.
            
                Οι συνομιλίες παραμένουν κρυπτογραφημένες από άκρη σε άκρη. Σε κάθε άλλη περίπτωση, επικοινωνήστε με την 24ωρη τηλεφωνική γραμμή εξυπητέτησης
            """
                
                )
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .foregroundStyle(dblue)
                .bold()
                .font(.subheadline)
                .padding(.bottom, 40)
                
                
                Button {
                    onStart()
                } label: {
                    Text("Ξεκίνα εδώ")
                        .frame(maxWidth: 200)
                        .frame(height: 15)
                        .padding()
                        .background(dblue)
                        .foregroundColor(.white)
                        .bold()
                        .cornerRadius(10)
                }

                Image("10306")
                    .resizable()
                    .frame(width: 150, height: 60)
            }
            .padding()
            Spacer()
        }
    }
}
