//
//  UIViewController+Extension.swift
//  LottoRecommendApp
//
//  Created by jun wook on 8/2/24.
//

import UIKit

public extension UIViewController {
    func showAlert(
        title: String? = nil,
        msg: String
    ) {
        let alertController = UIAlertController(
            title: title,
            message: msg,
            preferredStyle: .alert
        )

        let action = UIAlertAction(
            title: "확인",
            style: .default
        ) { _ in
            alertController.dismiss(animated: true)
        }
        alertController.addAction(action)

        present(alertController, animated: true, completion: nil)
    }
}
