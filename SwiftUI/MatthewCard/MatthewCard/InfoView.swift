//
//  InfoView.swift
//  MatthewCard
//
//  Created by Suhyoung Eo on 2021/09/14.
//

import SwiftUI


struct InfoView: View {
    let text: String
    let image: String
    let color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.white)
            .frame(height: 50)
            .overlay(HStack {
                Image(systemName: image)
                    .foregroundColor(color)
                Text(text)
                    .foregroundColor(Color("Info Color"))
            })
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "Hello", image: "phone.fill", color: .green)
            .previewLayout(.sizeThatFits)
    }
}
