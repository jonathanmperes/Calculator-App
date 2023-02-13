//
//  ViewController.swift
//  Calculater
//
//  Created by Jonathan Marcelo Peres on 09/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textFieldOne: UITextField!
    @IBOutlet weak var textFieldTwo: UITextField!
    
//    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification,object: nil)
        configureTextFields()
        configureTapGesture()
    }
    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//
//    @objc func keyboardNotification(notification: NSNotification) {
//        guard let userInfo = notification.userInfo else { return }
//
//        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
//        let endFrameY = endFrame?.origin.y ?? 0
//        let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
//        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
//        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
//        let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
//
//        if endFrameY >= UIScreen.main.bounds.size.height {
//            self.keyboardHeightLayoutConstraint?.constant = 0.0
//        } else {
//            self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
//        }
//
//        UIView.animate(
//            withDuration: duration,
//            delay: TimeInterval(0),
//            options: animationCurve,
//            animations: { self.view.layoutIfNeeded() },
//            completion: nil)
//    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
        
    private func configureTextFields() {
        textFieldOne.delegate = self
        textFieldTwo.delegate = self
    }
    
    @IBAction func calculateButtonTapped(_ sender: Any) {
        view.endEditing(true)
        
        let firstNumber = String(textFieldOne.text!) 
        print(firstNumber)
        
        let secondNumber = String(textFieldTwo.text!) 
        print(secondNumber)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
