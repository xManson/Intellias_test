//
//  BaseViewController.swift
//  Technical-test

import UIKit

class BaseViewController: UIViewController {
    
    private let activityIndicatorView = UIActivityIndicatorView(style: .medium)

    func show(text: String) {
        let alert = UIAlertController(
            title: "",
            message: text,
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "ok",
                style: .default
            )
        )
        present(alert, animated: true, completion: nil)
    }
    
    func show(error: TError) {
        show(text: error.localizedDescription)
    }
    
    func hudShow() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = view.center
        activityIndicatorView.startAnimating()
        view.isUserInteractionEnabled = false
    }

    func hudDismiss() {
        activityIndicatorView.removeFromSuperview()
        view.isUserInteractionEnabled = true
    }
    
}

