//
//  SideMenuView.swift
//  Todo_list
//
//  Created by Tran Lam on 16/10/2023.
//

import SwiftUI

struct SideMenuView: View {
    
    @Binding var isShowSideMenu: Bool
    var syncTask: (() -> Void)
    
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.4
    var bgColor: Color = Color(.init(red: 43 / 255, green: 49 / 255, blue: 51 / 255, alpha: 1))
    
    var body: some View {
        if isShowSideMenu {
            ZStack {
                GeometryReader { _ in
                    EmptyView()
                }
                .background(.black.opacity(0.6))
                .opacity(isShowSideMenu ? 1 : 0)
                .animation(.easeInOut.delay(0.2), value: isShowSideMenu)
                .onTapGesture {
                    isShowSideMenu.toggle()
                }
                content
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    var content: some View {
        HStack(alignment: .top) {
            ZStack(alignment: .top, content: {
                bgColor
                VStack {
                    Button("Login") {
                        
                    }
                    Spacer()
                    Button("Sync task", action: syncTask)
                }
                .padding(.top, 100)
                .padding(.bottom, 400)
            })
            .frame(width: sideBarWidth)
            .offset(x: isShowSideMenu ? 0 : -sideBarWidth)
            .animation(.default, value: isShowSideMenu)
            Spacer()
        }
    }
}

#Preview {
    SideMenuView(isShowSideMenu: .constant(true), syncTask: { })
}
