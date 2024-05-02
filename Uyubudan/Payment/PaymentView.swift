//
//  PaymentView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 5/2/24.
//

import UIKit
import WebKit

final class PaymentView: BaseView {
    
    lazy var webView = {
        let view = WKWebView()
        view.backgroundColor = .clear
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(webView)
    }
    
    override func configureConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
