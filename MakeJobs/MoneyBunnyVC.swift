//
//  MoneyBunnyVC.swift
//  MakeJobs
//
//  Created by Nikhil on 12/2/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//

import UIKit
import Firebase

class MoneyBunnyVC: UIViewController {

    @IBOutlet weak var tickerSearch: UITextField!

    var posts = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    

    
    @IBAction func FinancePressed(_ sender: Any) {
        
        //let article = Article()
        
        //article.url = "https://finance.yahoo.com/sector/financial"
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebVC
        webVC.url = "https://finance.yahoo.com/sector/financial"
        self.present(webVC, animated: true, completion: nil)
    }
    
    
    @IBAction func HealthCare(_ sender: Any) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebVC
        webVC.url = "https://finance.yahoo.com/sector/healthcare"
        self.present(webVC, animated: true, completion: nil)

    }
    
    @IBAction func Conglomerate(_ sender: Any) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebVC
        webVC.url = "https://finance.yahoo.com/sector/conglomerates"
        self.present(webVC, animated: true, completion: nil)
    }
    
    
    @IBAction func Technology(_ sender: Any) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebVC
        webVC.url = "https://finance.yahoo.com/sector/technology"
        self.present(webVC, animated: true, completion: nil)
    }
    
    @IBAction func Services(_ sender: Any) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebVC
        webVC.url = "https://finance.yahoo.com/sector/services"
        self.present(webVC, animated: true, completion: nil)
    }
    
    
    @IBAction func ConsumerGoods(_ sender: Any) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebVC
        webVC.url = "https://finance.yahoo.com/sector/consumer_goods"
        self.present(webVC, animated: true, completion: nil)
    }
    
    
    @IBAction func SearchTicker(_ sender: Any) {
        
        if(tickerSearch.text != ""){
            let s = tickerSearch.text!
            let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebVC
            webVC.url = "https://finance.yahoo.com/quote/\(s)?p=\(s)"
            self.present(webVC, animated: true, completion: nil)

        }
        
    }
    
    @IBAction func searchButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Ticker Search", message: "Search any stock Ticker.", preferredStyle: .alert)
        alert.addTextField{(textField) in
            textField.text = ""
            textField.keyboardType  =  UIKeyboardType.alphabet
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (error) in
            let textField  = alert.textFields?.first
            print("Text: \(textField?.text as Any)")
            let s = textField!.text!
            print(s)
            if (s != "") {
                
                let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebVC
                webVC.url = "https://finance.yahoo.com/quote/\(s)?p=\(s)"
                self.present(webVC, animated: true, completion: nil)

            }
          
        }))
         self.present(alert, animated: true, completion: nil)
    }
    

    @IBAction func robinhoodClicked(_ sender: Any) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebVC
        webVC.url = "https://itunes.apple.com/us/app/robinhood-free-stock-trading/id938003185?ls=1&mt=8"
        self.present(webVC, animated: true, completion: nil)
    }
    
    @IBAction func robinhoodClicked2(_ sender: Any) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebVC
        webVC.url = "https://itunes.apple.com/us/app/robinhood-free-stock-trading/id938003185?ls=1&mt=8"
        self.present(webVC, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
