//
//  ViewController.swift
//  Calculater
//
//  Created by Jonathan Marcelo Peres on 09/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textFieldOne: UITextField!
    @IBOutlet var textFieldTwo: UITextField!
    @IBOutlet var calculateButtonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureObserverKeyboardMovement()
        configureTextFields()
        configureTapGesture()
    }
    
    private func configureObserverKeyboardMovement() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if textFieldOne.isEditing || textFieldTwo.isEditing {
            moveViewWithKeyboard(
                notification: notification,
                viewBottomConstraint: self.calculateButtonBottomConstraint,
                keyboardWillShow: true)
        }
    }
        
    @objc func keyboardWillHide(_ notification: NSNotification) {
        moveViewWithKeyboard(
            notification: notification,
            viewBottomConstraint: self.calculateButtonBottomConstraint,
            keyboardWillShow: false)
    }
        
    func moveViewWithKeyboard(
        notification: NSNotification,
        viewBottomConstraint: NSLayoutConstraint,
        keyboardWillShow: Bool
    ) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        let keyboardHeight = keyboardSize.height
            
        let keyboardDuration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
            
        let keyboardCurve = UIView.AnimationCurve(rawValue: notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! Int)!
            
        if keyboardWillShow {
            let safeAreaExists = (self.view?.window?.safeAreaInsets.bottom != 0)
            let bottomConstant: CGFloat = 20
            viewBottomConstraint.constant = keyboardHeight + (safeAreaExists ? 0 : bottomConstant)
        } else {
            viewBottomConstraint.constant = 20
        }
            
        let animator = UIViewPropertyAnimator(
            duration: keyboardDuration,
            curve: keyboardCurve) { [weak self] in
                self?.view.layoutIfNeeded()
            }
            animator.startAnimation()
        }
    
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
