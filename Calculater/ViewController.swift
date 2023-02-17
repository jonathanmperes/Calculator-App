//
//  ViewController.swift
//  Calculater
//
//  Created by Jonathan Marcelo Peres on 09/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    var firstNum: String = ""
    var operation: String = ""
    var secondNum: String = ""
    var resultNum: String = "0"
    
    @IBOutlet var divideButton: UIButton!
    @IBOutlet var multiplyButton: UIButton!
    @IBOutlet var subtractButton: UIButton!
    @IBOutlet var additionButton: UIButton!
    
    @IBOutlet var numOnScreen: UILabel!
    
    @IBOutlet var textFieldOne: UITextField?
    @IBOutlet var textFieldTwo: UITextField?
    
    @IBOutlet var calculateButtonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        configureTapGesture()
    }
    
    @IBAction func divideButtonTapped(_ sender: Any) {
        operation = "/"
        divideButton.backgroundColor = .purple
        multiplyButton.backgroundColor = .systemBlue
        subtractButton.backgroundColor = .systemBlue
        additionButton.backgroundColor = .systemBlue
    }
    
    @IBAction func multiplyButtonTapped(_ sender: Any) {
        operation = "*"
        divideButton.backgroundColor = .systemBlue
        multiplyButton.backgroundColor = .purple
        subtractButton.backgroundColor = .systemBlue
        additionButton.backgroundColor = .systemBlue
    }
    
    @IBAction func subtractButtonTapped(_ sender: Any) {
        operation = "-"
        divideButton.backgroundColor = .systemBlue
        multiplyButton.backgroundColor = .systemBlue
        subtractButton.backgroundColor = .purple
        additionButton.backgroundColor = .systemBlue
    }
    
    @IBAction func additionButtonTapped(_ sender: Any) {
        operation = "+"
        divideButton.backgroundColor = .systemBlue
        multiplyButton.backgroundColor = .systemBlue
        subtractButton.backgroundColor = .systemBlue
        additionButton.backgroundColor = .purple
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        numOnScreen.text = "0"
        textFieldOne?.text = ""
        textFieldTwo?.text = ""
        divideButton.backgroundColor = .systemBlue
        multiplyButton.backgroundColor = .systemBlue
        subtractButton.backgroundColor = .systemBlue
        additionButton.backgroundColor = .systemBlue
    }
    
    @IBAction func calculateButtonTapped(_ sender: Any) {
        view.endEditing(true)
        resultNum = String(calculate())
        let numArray = resultNum.components(separatedBy: ".")
        if numArray[1] == "0" {
            numOnScreen.text = numArray[0]
        } else {
            numOnScreen.text = resultNum
        }
    }
    
    private func calculate() -> Double {
        if let firstNumber = textFieldOne?.text {
            firstNum = firstNumber
        }
        
        if let secondNumber = textFieldTwo?.text {
            secondNum = secondNumber
        }
        
        if operation == "+" && !firstNum.isEmpty && !secondNum.isEmpty {
            return Double(firstNum)! + Double(secondNum)!
        } else if operation == "-" && !firstNum.isEmpty && !secondNum.isEmpty {
            return Double(firstNum)! - Double(secondNum)!
        } else if operation == "*" && !firstNum.isEmpty && !secondNum.isEmpty {
            return Double(firstNum)! * Double(secondNum)!
        } else if operation == "/" && !firstNum.isEmpty && !secondNum.isEmpty {
            return Double(firstNum)! / Double(secondNum)!
        }
        return 0
    }
        
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
        
    private func configureTextFields() {
        textFieldOne?.delegate = self
        textFieldTwo?.delegate = self
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
