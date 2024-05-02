//
//  PaymentViewModel.swift
//  Uyubudan
//
//  Created by SangRae Kim on 5/2/24.
//

import Foundation
import RxSwift
import RxCocoa
import iamport_ios

final class PaymentViewModel {

    private let disposeBag = DisposeBag()
    
    var postData: PostData?
    var userData: ProfileModel?
    
    lazy var payment = IamportPayment(
            pg: PG.html5_inicis.makePgRawName(pgId: "INIpayTest"),
            merchant_uid: "ios_\(Environment.secretKey)_\(Int(Date().timeIntervalSince1970))",
            amount: "100").then {
                $0.pay_method = PayMethod.card.rawValue
                $0.name = "\(self.postData?.creator.nick ?? "")님께 후원하기"
                $0.buyer_name = "김상래"
                $0.app_scheme = Environment.appScheme
            }
    
    let paymentResponse = PublishRelay<String>()
    
    init() {
        paymentResponse
            .map {
                PaymentValidationQuery(impUID: $0, postID: self.postData!.postID, productName: "\(self.userData?.nickname ?? " ")님의 후원", price: 100)
            }
            .flatMap {
                return NetworkManager.fetchToServerNoModel(router: PaymentRouter.validation($0))
            }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let code):
                    print("success \(code)")
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
}
