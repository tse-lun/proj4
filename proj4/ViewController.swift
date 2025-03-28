//
//  ViewController.swift
//  proj4
//
//  Created by Stephen Chiu on 2025-03-28.
//

import UIKit
import WebKit

class TableViewController: UITableViewController {
    
    var websites = ["apple.com", "google.com"]
    override func viewDidLoad() {
        print(websites)
        title = "table view controller"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        print(websites.count)
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
}
//
//class ViewController: UIViewController, WKNavigationDelegate {
//    var webView: WKWebView!
//    var progressView: UIProgressView!
//    var websites = ["apple.com", "google.com"]
//    
//    override func loadView() {
//        webView = WKWebView()
//        webView.navigationDelegate = self
//        view = webView
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // setup nav + tool bar
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
//        progressView = UIProgressView(progressViewStyle: .default)
//        progressView.sizeToFit()
//        let progress = UIBarButtonItem(customView: progressView)
//        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
//        toolbarItems = [progress, spacer, refresh]
//        navigationController?.isToolbarHidden = false
//        
//        // observe progress
//        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
//        
//        let url = URL(string: "https://" + websites[0])!
//        webView.load(URLRequest(url: url))
//        webView.allowsBackForwardNavigationGestures = true
//    }
//    
//    @objc
//    func openTapped() {
//        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
//        for website in websites {
//            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
//        }
//        ac.addAction(UIAlertAction(title: "amazon.com", style: .default, handler: openPage))
//        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
//        present(ac, animated: true)
//    }
//
//    func openPage(action: UIAlertAction) {
//        guard let actionTitle = action.title else { return }
//        guard let url =  URL(string: "https://" + actionTitle) else { return }
//        webView.load(URLRequest(url: url))
//    }
//    
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        title = webView.title
//    }
//    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        progressView.progress = Float(webView.estimatedProgress)
//    }
//    
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        
//        let url = navigationAction.request.url
//        if let host = url?.host {
//            for website in websites {
//                if host.contains(website) {
//                    decisionHandler(.allow)
//                    return
//                }
//            }
//        }
//        decisionHandler(.cancel)
//        
//    }
//    
//}
//
