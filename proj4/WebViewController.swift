//
//  WebViewController.swift
//  proj4
//
//  Created by Stephen Chiu on 2025-03-29.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    var urlString: String?
    var safeUrls: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        setupProgressView()
        loadURL()
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        navigationController?.isToolbarHidden = false
    }

    private func setupWebView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupProgressView() {
        progressView = UIProgressView(progressViewStyle: .bar)
        progressView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 2)
        progressView.progressTintColor = .blue
        progressView.trackTintColor = .clear
        let progressBarItem = UIBarButtonItem(customView: progressView)
        toolbarItems = [progressBarItem]
    }

    private func loadURL() {
        guard let urlString = urlString else { return }
        guard let url = URL(string: "https://www." + urlString) else { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.title = webView.title
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.progressView.isHidden = true
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progressView.isHidden = false
        progressView.progress = 0.1
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url,
           let host = url.host {
            for safeUrl in safeUrls {
                if host.contains(safeUrl) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}
