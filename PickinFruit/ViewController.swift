//
//  ViewController.swift
//  PickinFruit
//
//  Created by Flatiron School on 7/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var fruitPicker: UIPickerView!
    
    var fruitsArray = ["🍎", "🍊", "🍌", "🍐", "🍇", "🍉", "🍓", "🍒", "🍍"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinButton.accessibilityLabel = Constants.SPIN_BUTTON
        fruitPicker.delegate = self
        self.resultLabel.alpha = 0.0
    }
    
    @IBAction func spinButtonTapped(_ sender: UIButton) {
        var numbers = [Int]()
        
        for i in 0..<fruitPicker.numberOfComponents {
        let randomNumber = Int(arc4random_uniform(UInt32(fruitsArray.count)) + 1)
        fruitPicker.selectRow(randomNumber, inComponent: i, animated: true) //spins
        numbers.append(randomNumber)
        }
        
        self.view.addSubview(resultLabel!)
        
        if Set(numbers).count > 1 {
            self.resultLabel.text? = "Try Again"
        } else {
            resultLabel.text = "Winner"
        }
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.autoreverse, .repeat],
                       animations: { self.resultLabel.alpha = 1.0 }, completion: nil)
        numbers.removeAll()
    }
}

// MARK: Set Up
extension ViewController: UIPickerViewDelegate,
                          UIPickerViewDataSource {
    
    override func viewDidLayoutSubviews() {
        if self.spinButton.layer.cornerRadius == 0.0 {
            configureButton()
        }
    }
    
    func configureButton()
    {
        self.spinButton.layer.cornerRadius = 0.5 * self.spinButton.bounds.size.width
        self.spinButton.layer.borderColor = UIColor.white.cgColor
        self.spinButton.layer.borderWidth = 4.0
        self.spinButton.clipsToBounds = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 5 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.fruitsArray.count }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.fruitsArray[row] }
}



