//
//  ViewController.swift
//  proj4
//
//  Created by Stephen Chiu on 2025-03-28.
//

import UIKit
import WebKit

class ViewController: UITableViewController, WKNavigationDelegate {
    
    let websites = ["apple.com", "google.com"]
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "home"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = WebViewController()
        webVC.urlString = websites[indexPath.row]
        webVC.safeUrls = websites
        navigationController?.pushViewController(webVC, animated: true)
    }
}
