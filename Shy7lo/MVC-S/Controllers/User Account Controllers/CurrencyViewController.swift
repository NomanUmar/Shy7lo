//
//  CurrencyViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 7/26/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet var currencyImage: UIImageView!
    @IBOutlet var laSubTitle: UILabel!
    @IBOutlet var laTitle: UILabel!
    @IBOutlet var currencyControl: UIPageControl!
    @IBOutlet var currencySelect: UIPickerView!
    let currencyList = ["BHD","KWD","OMR","QAR","SAR","USD","AED"]
    override func viewDidLoad() {
        
        
        currencySelect.dataSource = self
        currencySelect.delegate = self
        currencySelect.selectRow(3, inComponent:0, animated:true)
        currencyImage.image = UIImage(named: "Currency")
        currencyControl.currentPage = 1
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buSkip(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GenderViewController") as!
        GenderViewController
        self.navigationController?.pushViewController(vc,animated: false)
        
    }
    
    
    @IBAction func buNext(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GenderViewController") as!
        GenderViewController
        self.navigationController?.pushViewController(vc,animated: false)
        
    }
    //Functions for picker view
    //================================================================
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currencyImage.image = UIImage(named: "Currency")
        print(currencyList[row])
    }
    
}
