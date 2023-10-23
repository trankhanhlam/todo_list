//
//  LoginView.swift
//  Todo_list
//
//  Created by Tran Lam on 16/10/2023.
//

import SwiftUI

struct LoginView: View {
    
    @State private var userName = ""
    @State private var passWord = ""
    
    var body: some View {
        VStack {
            TextField("Username", text: $userName)
            TextField("Password", text: $passWord)
            Button("Login", action: login)
                .padding(.top, 30)
        }
        .padding(.top, 150)
        .padding([.leading, .trailing], 40)
        .textFieldStyle(.roundedBorder)
        Spacer()
    }
    
    private func login() {
        
    }
}

#Preview {
    LoginView()
}
