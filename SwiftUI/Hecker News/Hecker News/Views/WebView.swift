//
//  WebView.swift
//  Hecker News
//
//  Created by Suhyoung Eo on 2021/09/16.
//

import Foundation
import WebKit
import SwiftUI

//강의 내용 시점 SwiftUI webView 지원하지 않아 UIkit componet 사용
struct WebView: UIViewRepresentable {
    let urlString: String?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeString = urlString {
            if let url = URL(string: safeString) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}
