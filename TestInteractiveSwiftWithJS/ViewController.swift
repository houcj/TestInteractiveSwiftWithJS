//
//  ViewController.swift
//  TestInteractiveSwiftWithJS
//
//  Created by user on 2017/5/8.
//  Copyright © 2017年 Annie Hou. All rights reserved.
//

import UIKit
import WebKit

let WIDTH = UIScreen.main.bounds.size.width
let HEIGHT = UIScreen.main.bounds.size.height



class ViewController: UIViewController,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler/*实现js和swift交互*/ {

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("调度器和方法--\(message)")
    }
    
    // MARK: 调用web view方法，实现web view界面
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
    }
    // MARK: 在发送请求之前，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        var urlStr = navigationAction.request.url?.absoluteString
        urlStr = urlStr?.removingPercentEncoding
        let urlComps = urlStr?.components(separatedBy: "://")
        if ((urlComps?.count) != nil) {
            let protocolHead = urlComps?[0]
            print("protocolHead=\(String(describing: protocolHead))")
            
        }
        decisionHandler(WKNavigationActionPolicy.allow)
        
    }
    // MARK: 页面开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisional-\(#function)")
    }
    // MARK: 收到服务器的响应头，根据respondse相关信息，决定是否跳转，参数WKNavigationActionPolicyCancel取消跳转，WKNavigationActionPolicyAllow允许跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(WKNavigationResponsePolicy.allow)
    }
    // MARK: 开始获取网页内容时返回
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    // MARK: 网页加载完成时调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    // MARK: 网页加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: 配置js
//        let userContentController = WKUserContentController.init()
//        userContentController.add(self, name: "gziOS")
        
        // MARK: 配置WKWebView
        let configuration = WKWebViewConfiguration.init()
        configuration.userContentController.add(self, name: "gziOS")
        
        // MARK: 显示WebView
        let webView = WKWebView.init(frame: CGRect(x:0, y:0, width:WIDTH, height:HEIGHT), configuration: configuration)
        webView.backgroundColor = UIColor.red
        webView.uiDelegate = self
        webView.isUserInteractionEnabled = true
        webView.navigationDelegate = self
        
        
        //        let urlRe = URLRequest.init(url:URL.init(string: "www.sina.com.cn")!)
                let urlRe = URLRequest.init(url:URL.init(string: "https://www.baidu.com")!)
        
        webView.load(urlRe)
        
        
        self.view.addSubview(webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

