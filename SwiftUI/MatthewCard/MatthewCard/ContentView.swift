//
//  ContentView.swift
//  MatthewCard
//
//  Created by Suhyoung Eo on 2021/09/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 0.90, green: 0.49, blue: 0.13, opacity: 1)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("matthew")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 170, height: 180)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay(Circle().stroke(Color.white, lineWidth: 5))
                Text("Suhyoung Eo")
                    .font(Font.custom("Pattaya-Regular", size: 40))
                    .bold()
                    .foregroundColor(.white)
                Text("Freestyle Walker")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                Divider()
                InfoView(text: "+82 10 3391 2477", image: "phone.fill", color: .green)
                InfoView(text: "eossu@kakao.com", image: "envelope.fill", color: .yellow)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

