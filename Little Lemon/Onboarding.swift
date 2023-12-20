//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Edem Ahorlu on 12/19/23.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var isLoggedIn = false
    var body: some View {
        NavigationView {
            VStack {
                LittleLemonLogo()
                Hero()
                    .padding()
                    .background(Color.primaryColor1)
                    .frame(maxWidth: .infinity, maxHeight: 240)
                
                VStack {
                    NavigationLink(destination: Home(),
                                   isActive: $isLoggedIn) {
                        EmptyView()
                    }
                    
                    Text("First name *")
                        .onboardingTextStyle()
                    TextField("First Name", text: $firstName)
                    Text("Last name *")
                        .onboardingTextStyle()
                    TextField("Last Name", text: $lastName)
                    Text("E-mail *")
                        .onboardingTextStyle()
                    TextField("E-mail", text: $email)
                        .keyboardType(.emailAddress)
                }
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
                .padding()
                
                Spacer()
                Button("Register") {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        isLoggedIn = true
                    }
                }
                .buttonStyle(ButtonStyleYellowColorWide())
                
                Spacer()
            }
            
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
        }
    }
}

#Preview {
    Onboarding()
}
