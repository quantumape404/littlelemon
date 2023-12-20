//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Edem Ahorlu on 12/19/23.
//

import SwiftUI

struct UserProfile: View {
    let userFirstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    let userLastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    let userEmail = UserDefaults.standard.string(forKey: kEmail) ?? ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Personal Information")
            Image("profile-image-placeholder")
                .resizable()
                .aspectRatio( contentMode: .fit)
                .clipShape(Circle())
                .padding(.trailing)
            
        
            
            HStack {
                Text("First name:")
                    .font(.sectionTitle())
                    .frame(alignment: .leading)
                    .padding(.leading, 50)
                
                Spacer()
                
                Text(userFirstName)
                    .frame(alignment: .trailing)
        
                Spacer()
            }
            .padding(.top, 20)
            .padding(.bottom, 10)
            
            HStack {
                Text("Last Name:")
                    .font(.sectionTitle())
                    .frame(alignment: .leading)
                    .padding(.leading, 50)
                
                Spacer()
                
                Text(userLastName)
                    .frame(alignment: .trailing)
        
                Spacer()
            }
            .padding(.bottom, 10)
            
            HStack {
                Text("Email:")
                    .font(.sectionTitle())
                    .frame(alignment: .leading)
                    .padding(.leading, 50)
                
                Spacer()
                
                Text(userEmail)
                    .frame(alignment: .trailing)
        
                Spacer()
            }
            .padding(.bottom, 10)
           
            
            Spacer()
            
            
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentationMode.wrappedValue.dismiss()
            }
            .buttonStyle(ButtonStyleYellowColorWide())
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
