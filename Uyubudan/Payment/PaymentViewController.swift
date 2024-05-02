//
//  PaymentViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 5/2/24.
//

import UIKit
import iamport_ios

final class PaymentViewController: BaseViewController {
    
    private let paymentView = PaymentView()
    let viewModel = PaymentViewModel()
    
    override func loadView() {
        super.loadView()
        
        view = paymentView
    }
    
    override func bind() {
        Iamport.shared.paymentWebView(webViewMode: paymentView.webView, userCode: Environment.paymentUserCode, payment: viewModel.payment) { [weak self] iamportResponse in
            guard let response = iamportResponse, let impUID = response.imp_uid else { return }
            
            self?.viewModel.paymentResponse.accept(impUID)
        }
    }
}
