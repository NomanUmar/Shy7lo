//
//  CountryViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 7/26/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
 
    @IBOutlet var buttonSkip: UIButton!
    
    var appInitResponse:AppInitResponse?

    var countriesData : [CountriesObj]!
    var countriesName = [String]()
    var lang:String!
    var countryCode:String!
    var defaultCountry:String!
    var selectedCountry:String!
    var countryId:String!
    @IBOutlet var selectCountry: UIPickerView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var countryImage: UIImageView!
    @IBOutlet var laSubTitle: UILabel!
    @IBOutlet var laTitle: UILabel!
    
    @IBOutlet var buttonNext: UIButton!
    @IBOutlet var laChooseCountry: UILabel!
    
   


    override func viewDidLoad() {
        
        //get language
        lang = UserInfoDefault.getLanguage()
        
        //get Country
        countryCode = UserInfoDefault.getCountryCode()
        
        //for iphone 5 font size
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        if height < 569{
             laTitle.font =  laTitle.font.withSize(19)
             laTitle.text = "TagLineCVC".localizableString(loc: lang)
        }else{
            
            laTitle.text = "TagLineCVC".localizableString(loc: lang)
        }
        //------------------------------------------------------------------
        laSubTitle.text = "SubTagLineCVC".localizableString(loc: lang)
        laChooseCountry.text = "ChooseCountryCVC".localizableString(loc: lang)
        let buNext = "BuNextCVC".localizableString(loc: lang)
        buttonNext.setTitle(buNext, for: .normal)
        let buSkip = "BuSkipCVC".localizableString(loc: lang)
        buttonSkip.setTitle(buSkip, for: .normal)
        
       //picker delegate
        selectCountry.dataSource = self
        selectCountry.delegate = self

       // countryImage.image = UIImage(named: countryListEn[2])
        pageControl.currentPage = 0
        
        //function call
        self.getCountriesAppInit()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//==================================================================
    //button Actions
    @IBAction func buSkip(_ sender: Any) {
        
        print("Skip")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LandingViewController") as!
        LandingViewController
        self.navigationController?.pushViewController(vc,animated: false)
    }
    
    
    @IBAction func buNext(_ sender: Any) {
        print("Next")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CategoriesViewController") as! CategoriesViewController
          vc.categoryData =  self.appInitResponse?.landing_screens.base_screens
        
        self.navigationController?.pushViewController(vc,animated: false)
    }
    
    //Functions for picker view
    //================================================================
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.countriesName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.countriesName[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //self.countryImage.image = UIImage(named: countryListEn[row])
        print(self.countriesName[row])
        self.selectedCountry = self.countriesName[row]
        //function call
        countryId = self.forLoadImage(countryName: selectedCountry)
        print(countryId!)
        self.countryImage.image = UIImage(named: countryId!)
    }
    
    
 //===========================================================================
    
    func getCountriesAppInit(){
        //get data from userDefault
        //=========================================================================
        let data = UserDefaults.standard.value(forKey:"AppInit") as? Data
        let jsonDecoder = JSONDecoder()
        if let res = try? jsonDecoder.decode ( AppInitResponse.self , from: data!  ) as   AppInitResponse {
          
            self.appInitResponse = res
            self.countriesData = res.countries
            var country = [String]()
        //=========================================================================
        //get countries from response
            for i in 0..<self.countriesData.count {
                print("country------>\(self.countriesData[i])  \n \n \n \n")

                
                if lang.contains("ar"){
                    country.append(self.countriesData[i].full_name_locale)
                }else{
                    country.append(self.countriesData[i].full_name_english)
                }
                
            }
            //==============================================================================
            //array sort and save in countiesName
            self.countriesName = country.sorted()
            //===============================================================================
            //match from default country of mobile
            for j in 0..<self.countriesData.count{
                
                if countryCode == self.countriesData[j].id{
                    if lang.contains("ar"){
                        self.selectedCountry = self.countriesData[j].full_name_locale
                        self.defaultCountry = self.selectedCountry
                    
                    }else{
                    self.selectedCountry = self.countriesData[j].full_name_english
                        self.defaultCountry = self.selectedCountry
                        
                    }
                }else{
                    if lang.contains("ar"){
                        self.selectedCountry = "المملكة العربية السعودية"
                        self.defaultCountry = self.selectedCountry
                        UserInfoDefault.saveCountyCode(countyCode: "SA")
        
                    }else{
                        self.selectedCountry = "Saudi Arabia"
                        self.defaultCountry = self.selectedCountry
                        UserInfoDefault.saveCountyCode(countyCode: "SA")
                       
                    }
                   
                }
                //function call
                self.countryId = self.forLoadImage(countryName: self.selectedCountry)
                self.countryImage.image = UIImage(named: self.countryId!)
                
            }
            //==========================================================================
            //for default selection in picker
            for k in 0..<self.countriesName.count{
                if self.selectedCountry == self.countriesName[k]{
                    self.selectCountry.selectRow(k , inComponent:0, animated:true)
                    
                }
            }
            //===========================================================================
            
        }
        
        
    }
    
    func forLoadImage(countryName:String) -> String{
        var code:String!
        for i in 0..<self.countriesData.count{

            if lang.contains("ar"){
                if selectedCountry == self.countriesData[i].full_name_locale{
                    
                    code = self.countriesData[i].id
                }
            }else{
                if selectedCountry == self.countriesData[i].full_name_english{
                    code =  self.countriesData[i].id
                }
            }
        }
        print(code!)
        return code!
    }
    
}
