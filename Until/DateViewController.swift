//
//  DateViewController.swift
//  Until
//
//  Created by Dishant Nagpal on 16/02/22.
//

import UIKit

class DateViewController: UIViewController,UITextFieldDelegate {

    public var completionHandler: ((String,Date)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        field.becomeFirstResponder()
        picker.tintColor = .white
        field.delegate=self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    @IBOutlet weak var field: UITextField!
    
    @IBOutlet weak var picker: UIDatePicker!
    
    @IBAction func didTapButton(_ sender: UIButton) {
        
        if let text=field.text,!text.isEmpty{
            let pickedDateTime=picker.date
            completionHandler?(text,pickedDateTime)
            navigationController?.popToRootViewController(animated: true)
            
        }
        
    }
    
}
