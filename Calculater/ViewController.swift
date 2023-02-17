//
//  ViewController.swift
//  Calculater
//
//  Created by Jonathan Marcelo Peres on 09/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func divideButtonTapped(_ sender: Any) {
        operation = "/"
    }
    
    @IBAction func multiplyButtonTapped(_ sender: Any) {
        operation = "*"
    }
    
    
    @IBAction func subtractButtonTapped(_ sender: Any) {
        operation = "-"
    }
    
    @IBAction func additionButtonTapped(_ sender: Any) {
        operation = "+"
    }
    
    @IBOutlet weak var numOnScreen: UILabel!
    @IBOutlet var textFieldOne: UITextField!
    @IBOutlet var textFieldTwo: UITextField!
    @IBOutlet var calculateButtonBottomConstraint: NSLayoutConstraint!
    
    var firstNum = ""
    var operation: String = ""
    var secondNum = ""
    var resultNum: String = "0"
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        numOnScreen.text = "0"
        textFieldOne.text = ""
        textFieldTwo.text = ""
        secondNum = ""
    }
    
    func calculate() -> Double {
        let firstNumber = String(textFieldOne.text!)
        firstNum = firstNumber
        
        let secondNumber = String(textFieldTwo.text!)
        secondNum = secondNumber
        
        if operation == "+" {
            return Double(firstNum)! + Double(secondNum)!
        } else if operation == "-" {
            return Double(firstNum)! - Double(secondNum)!
        } else if operation == "*"  {
            return Double(firstNum)! * Double(secondNum)!
        } else if operation == "/" {
            return Double(firstNum)! / Double(secondNum)!
        }
        return 0
    }
    
    @IBAction func calculateButtonTapped(_ sender: Any) {
        view.endEditing(true)
        resultNum = String(calculate())
        numOnScreen.text = resultNum
    }
    
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
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
