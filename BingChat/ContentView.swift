//
//  ContentView.swift
//  BingChat
//
//  Created by Jongwook Park on 2023/03/21.
//

import SwiftUI

import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        let urlString = "https://www.bing.com/search?q=Bing+AI&showconv=1&FORM=hpcodx"
        WebView(request: URLRequest(url: URL(string: urlString)!), userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36 Edg/96.0.1054.62")
    }
}

struct WebView: NSViewRepresentable {
    let request: URLRequest
    let userAgent: String
    
    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.customUserAgent = userAgent
        webView.navigationDelegate = context.coordinator // set navigation delegate
        return webView
    }
    
    func updateNSView(_ webView: WKWebView, context: Context) {
        webView.load(request)
    }
    
    // create a coordinator to implement the navigation delegate methods
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        // detect when a link is clicked
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.targetFrame == nil { // the link will open in a new tab
                decisionHandler(.cancel) // cancel the default behavior
                if let url = navigationAction.request.url { // load the link in a new tab
                    NSWorkspace.shared.open(url)
                }
            } else {
                decisionHandler(.allow) // allow the default behavior
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

