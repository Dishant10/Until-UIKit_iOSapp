//
//  ViewController.swift
//  Until
//
//  Created by Dishant Nagpal on 16/02/22.
//

import UIKit

class ViewController: UIViewController {

    var hrs=0
    var mins=0
    var sec=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var label: UILabel!
    
    @IBAction func didTapUntilButton(_ sender: UIBarButtonItem) {
        let vc=storyboard?.instantiateViewController(withIdentifier: "date_picker") as! DateViewController
        vc.title="New event"
//        vc.title = .white
        vc.completionHandler = { [weak self] name,date in
            DispatchQueue.main.async {
                
                    self?.didCreateEventForUntil(name: name, targetDate: date)
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapFromButton(_ sender: UIBarButtonItem) {
        let vc=storyboard?.instantiateViewController(withIdentifier: "date_picker") as! DateViewController
        vc.title="New event"
        vc.completionHandler = { [weak self] name,date in
            DispatchQueue.main.async {
                
                self?.didCreateEventForFrom(name: name, date: date)
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func didCreateEventForUntil(name:String,targetDate:Date){
        self.title=name
        let difference = floor(targetDate.timeIntervalSince(Date()))
        if difference > 0.0{
            let hours=Int(difference)/3600
            let remainder=Int(difference)-(hours*3600)
            let minutes=remainder/60
            let seconds=Int(difference)-(hours*3600)-(minutes*60)
            hrs=hours
            mins=minutes
            sec=seconds
            updateLabel()
            startTimerUntil()
        }else{
            print("negative interval")
        }
        
    }
    private func didCreateEventForFrom(name:String,date:Date){
        self.title=name
       let difference = Date().timeIntervalSince(date)
        let hours=Int(difference)/3600
        let remainder=Int(difference)-(hours*3600)
        let minutes=remainder/60
        let seconds=Int(difference)-(hours*3600)-(minutes*60)
        hrs=hours
        mins=minutes
        sec=seconds
        updateLabel()
        startTimerFrom()
        print("\(hours):\(minutes):\(seconds)")
        
    }
    
    
    private func startTimerUntil(){
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.sec>0{
                
                self.sec=self.sec-1
                
            }else if self.mins>0 && self.sec==0{
                self.mins=self.mins-1
                self.sec=59
                
            }else if self.hrs>0 && self.mins==0 && self.sec==0{
                self.hrs=self.hrs-1
                self.mins=59
                self.sec=59
            }
            self.updateLabel()
        }
    }
    
    private func startTimerFrom(){
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.sec<59{
                
                self.sec=self.sec+1
                
            }else if self.mins<59 && self.sec==59{
                self.mins=self.mins+1
                self.sec=0
                
            }else if self.hrs<1000000000000 && self.mins==59 && self.sec==59{
                self.hrs=self.hrs+1
                self.mins=0
                self.sec=0
            }
            self.updateLabel()
        }
        
    }
    
    func updateLabel(){
        label.text=("\(hrs):\(mins):\(sec)")
    }
}

