//
//  AlertPresenter.swift
//  YallaSport
//
//  Created by husayn on 30/04/2024.
//

import Foundation
import UIKit

class AlertPresenter {
    static func positiveAlert(_ oneButton:Bool?,title titleMsg: String?, message messageBody: String?, yesButton: String?, noButton: String?, on viewController: UIViewController?, yesHandler: @escaping () -> Void?, noHandler: @escaping () -> Void?) {
        
        let alert = UIAlertController(title: titleMsg, message: messageBody, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: yesButton, style: UIAlertAction.Style.default) { _ in
            yesHandler()
        })
        
        if !(oneButton ?? true){
            
            alert.addAction(UIAlertAction(title: noButton ?? "Cancel", style: UIAlertAction.Style.cancel) { _ in
                noHandler()
            })
        }
        
        
        viewController?.present(alert, animated: true, completion: nil)
    }
    static func negativeAlert(_ oneButton:Bool?,title titleMsg: String?, message messageBody: String?, yesButton: String?, noButton: String?, on viewController: UIViewController?, yesHandler: @escaping () -> Void, noHandler: @escaping () -> Void){
        
        let alert = UIAlertController(title: titleMsg, message: messageBody, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: yesButton, style: UIAlertAction.Style.destructive) { _ in
            yesHandler()
        })
        
        if !(oneButton ?? true){
            
            alert.addAction(UIAlertAction(title: noButton, style: UIAlertAction.Style.cancel) { _ in
                noHandler()
            })
        }
        
        
        viewController?.present(alert, animated: true, completion: nil)
    }
}
