//
//  ViewController.swift
//  A3HuaizhiDai530562
//
//  Created by mobiledev on 9/5/21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class ViewController: UIViewController {
    
    //var let
    var schemeNew = [schemeStruct]()
    let db = Firestore.firestore()
    var schemeData = ["1", 0] as [Any]

    //weeks button outlets
    @IBOutlet var toWeek2Btn: UIButton!
    @IBOutlet var toWeek3Btn: UIButton!
    @IBOutlet var toWeek4Btn: UIButton!
    @IBOutlet var toWeek5Btn: UIButton!
    @IBOutlet var toWeek6Btn: UIButton!
    @IBOutlet var toWeek7Btn: UIButton!
    @IBOutlet var toWeek8Btn: UIButton!
    @IBOutlet var toWeek9Btn: UIButton!
    @IBOutlet var toWeek10Btn: UIButton!
    @IBOutlet var toWeek11Btn: UIButton!
    @IBOutlet var toWeek12Btn: UIButton!
    
    //scheme outlets
    @IBOutlet var w2Scheme: UIButton!
    @IBOutlet var w3Scheme: UIButton!
    @IBOutlet var w4Scheme: UIButton!
    @IBOutlet var w5Scheme: UIButton!
    @IBOutlet var w6Scheme: UIButton!
    @IBOutlet var w7Scheme: UIButton!
    @IBOutlet var w8scheme: UIButton!
    @IBOutlet var w9Scheme: UIButton!
    @IBOutlet var w10Scheme: UIButton!
    @IBOutlet var w11Scheme: UIButton!
    @IBOutlet var w12Scheme: UIButton!
    
    //MARK: - weeks button actions
    @IBAction func toWeek2Btn(_ sender: Any) {
        
        //segue
        self.performSegue(withIdentifier: "toWeek", sender: toWeek2Btn.currentTitle)
    }
    
    @IBAction func toWeek3Btn(_ sender: Any) {
        
        //segue
        self.performSegue(withIdentifier: "toWeek", sender: toWeek3Btn.currentTitle)
    }
    
    @IBAction func toWeek4Btn(_ sender: Any) {
        
        //segue
        self.performSegue(withIdentifier: "toWeek", sender: toWeek4Btn.currentTitle)
    }
    
    @IBAction func toWeek5Btn(_ sender: Any) {
        
        //segue
        self.performSegue(withIdentifier: "toWeek", sender: toWeek5Btn.currentTitle)
    }
    
    @IBAction func toWeek6Btn(_ sender: Any) {
        
        //segue
        self.performSegue(withIdentifier: "toWeek", sender: toWeek6Btn.currentTitle)
    }
    
    @IBAction func toWeek7Btn(_ sender: Any) {
        
        //segue
        self.performSegue(withIdentifier: "toWeek", sender: toWeek7Btn.currentTitle)
    }
    
    @IBAction func toWeek8Btn(_ sender: Any) {
        
        //segue
        self.performSegue(withIdentifier: "toWeek", sender: toWeek8Btn.currentTitle)
    }
    
    @IBAction func toWeek9Btn(_ sender: Any) {
        
        //segue
        self.performSegue(withIdentifier: "toWeek", sender: toWeek9Btn.currentTitle)
    }
    
    @IBAction func toWeek10Btn(_ sender: Any) {
        
        //segue
        self.performSegue(withIdentifier: "toWeek", sender: toWeek10Btn.currentTitle)
    }
    
    @IBAction func toWeek11Btn(_ sender: Any) {
        
        //segue
        self.performSegue(withIdentifier: "toWeek", sender: toWeek11Btn.currentTitle)
    }
    
    @IBAction func toWeek12Btn(_ sender: Any) {
        
        //segue
        self.performSegue(withIdentifier: "toWeek", sender: toWeek12Btn.currentTitle)
    }
    
    // scheme actions
    
    @IBAction func s2(_ sender: Any) {
        schemeAlert(weekForTitle: "Week 2", Message: "Marking scheme of Week 2 is \(schemeNew[4].type ?? "ERROR") \(numberOrNot(number: schemeNew[4].number ?? 0))")
    }
    @IBAction func s3(_ sender: Any) {
        schemeAlert(weekForTitle: "Week 3", Message: "Marking scheme of Week 3 is \(schemeNew[5].type ?? "ERROR") \(numberOrNot(number: schemeNew[5].number ?? 0))")
    }
    @IBAction func s4(_ sender: Any) {
        schemeAlert(weekForTitle: "Week 4", Message: "Marking scheme of Week 4 is \(schemeNew[6].type ?? "ERROR") \(numberOrNot(number: schemeNew[6].number ?? 0))")
    }
    @IBAction func s5(_ sender: Any) {
        schemeAlert(weekForTitle: "Week 5", Message: "Marking scheme of Week 5 is \(schemeNew[7].type ?? "ERROR") \(numberOrNot(number: schemeNew[7].number ?? 0))")
    }
    @IBAction func s6(_ sender: Any) {
        schemeAlert(weekForTitle: "Week 6", Message: "Marking scheme of Week 6 is \(schemeNew[8].type ?? "ERROR") \(numberOrNot(number: schemeNew[8].number ?? 0))")
    }
    @IBAction func s7(_ sender: Any) {
        schemeAlert(weekForTitle: "Week 7", Message: "Marking scheme of Week 7 is \(schemeNew[9].type ?? "ERROR") \(numberOrNot(number: schemeNew[9].number ?? 0))")
    }
    @IBAction func s8(_ sender: Any) {
        schemeAlert(weekForTitle: "Week 8", Message: "Marking scheme of Week 8 is \(schemeNew[10].type ?? "ERROR") \(numberOrNot(number: schemeNew[10].number ?? 0))")
    }
    @IBAction func s9(_ sender: Any) {
        schemeAlert(weekForTitle: "Week 9", Message: "Marking scheme of Week 9 is \(schemeNew[11].type ?? "ERROR") \(numberOrNot(number: schemeNew[11].number ?? 0))")
    }
    @IBAction func s10(_ sender: Any) {
        schemeAlert(weekForTitle: "Week 10", Message: "Marking scheme of Week 10 is \(schemeNew[1].type ?? "ERROR") \(numberOrNot(number: schemeNew[1].number ?? 0))")
    }
    @IBAction func s11(_ sender: Any) {
        schemeAlert(weekForTitle: "Week 11", Message: "Marking scheme of Week 11 is \(schemeNew[2].type ?? "ERROR") \(numberOrNot(number: schemeNew[2].number ?? 0))")
    }
    @IBAction func s12(_ sender: Any) {
        schemeAlert(weekForTitle: "Week 12", Message: "Marking scheme of Week 12 is \(schemeNew[3].type ?? "ERROR") \(numberOrNot(number: schemeNew[3].number ?? 0))")
    }
    //MARK: help
    @IBAction func help(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myAlert = storyboard.instantiateViewController(withIdentifier: "alert")
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(myAlert, animated: true, completion: nil)
    }
    
    
    //test
    @IBAction func test(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myAlert = storyboard.instantiateViewController(withIdentifier: "alert")
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(myAlert, animated: true, completion: nil)
    }
    
    //test   ennnnd
    
    // MARK: -functions
    func showScheme(scheme: String) -> String {
        var show = ""
        switch scheme {
        case "Grade (HD/DN/CR/PP/NN)":
            show = "Grade(HD-NN)"
        case "Grade (A/B/C/D/F)":
            show = "Grade(A-F)"
        default:
            show = scheme
        }
        return show
    }
    
    func updateScheme(wk: String, scheme: String, number: Int) {
        let schemeCollection = db.collection("scheme")
        schemeCollection.document(wk).updateData([
            "type": scheme,
            "number": number
        ]){ (err) in
            if let err = err{
                print("Error ipdating document: \(err)")
            }else{
                print("Document updated")
            }
        }
    }
    //MARK: - scheme alert
    func schemeAlert(weekForTitle: String, Message: String ) {
        let popup = UIAlertController(title: "Change Marking Scheme for \(weekForTitle)", message: Message, preferredStyle: UIAlertController.Style.alert)
        //checkbox11111111
        let checkbox = UIAlertAction(title: "Checkbox", style: UIAlertAction.Style.default ){(action) in
            //confirm scheme change
            let confirm = UIAlertController(title: "Confirm", message: "Are you sure to change Marking scheme of \(weekForTitle) to Checkbox?" , preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) in
                self.updateScheme(wk: weekForTitle, scheme: "Checkbox", number: 0)
                self.weekToBtn(weekForTitle: weekForTitle, scheme: "Checkbox")
            }
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            confirm.addAction(ok)
            confirm.addAction(cancel)
            self.present(confirm, animated: true, completion: nil)
        }
        //HD   222222222222222222
        let HD = UIAlertAction(title: "Grade(HD-NN)", style: UIAlertAction.Style.default) { (action) in
            //confirm scheme change
            let confirm = UIAlertController(title: "Confirm", message: "Are you sure to change Marking scheme of \(weekForTitle) to Grade(HD-NN)?" , preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) in
                self.updateScheme(wk: weekForTitle, scheme: "Grade (HD/DN/CR/PP/NN)", number: 0)
                self.weekToBtn(weekForTitle: weekForTitle, scheme: "Grade(HD-NN)")
            }
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            confirm.addAction(ok)
            confirm.addAction(cancel)
            self.present(confirm, animated: true, completion: nil)
        }
        //A 3333
        let A = UIAlertAction(title: "Grade(A-F)", style: UIAlertAction.Style.default) { (action) in
            //confirm scheme change
            let confirm = UIAlertController(title: "Confirm", message: "Are you sure to change Marking scheme of \(weekForTitle) to Grade(A-F)?" , preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) in
                self.updateScheme(wk: weekForTitle, scheme: "Grade (A/B/C/D/F)", number: 0)
                self.weekToBtn(weekForTitle: weekForTitle, scheme: "Grade(A-F)")
            }
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            confirm.addAction(ok)
            confirm.addAction(cancel)
            self.present(confirm, animated: true, completion: nil)
        }
        //Multi  444444
        let multi = UIAlertAction(title: "Multi-Checkbox", style: UIAlertAction.Style.default) { (action) in
            //confirm scheme change
            let confirm = UIAlertController(title: "Confirm", message: "Are you sure to change Marking scheme of \(weekForTitle) to Multi-Checkbox? If you are, please select a number for checkbox (2 ~ 5)" , preferredStyle: UIAlertController.Style.alert)
            let b2 = UIAlertAction(title: "2", style: UIAlertAction.Style.default){ (action) in
                self.updateScheme(wk: weekForTitle, scheme: "Multi-Checkbox", number: 2)
                self.weekToBtn(weekForTitle: weekForTitle, scheme: "Multi-Checkbox")
            }
            let b3 = UIAlertAction(title: "3", style: UIAlertAction.Style.default){ (action) in
                self.updateScheme(wk: weekForTitle, scheme: "Multi-Checkbox", number: 3)
                self.weekToBtn(weekForTitle: weekForTitle, scheme: "Multi-Checkbox")
            }
            let b4 = UIAlertAction(title: "4", style: UIAlertAction.Style.default){ (action) in
                self.updateScheme(wk: weekForTitle, scheme: "Multi-Checkbox", number: 4)
                self.weekToBtn(weekForTitle: weekForTitle, scheme: "Multi-Checkbox")
            }
            let b5 = UIAlertAction(title: "5", style: UIAlertAction.Style.default){ (action) in
                self.updateScheme(wk: weekForTitle, scheme: "Multi-Checkbox", number: 5)
                self.weekToBtn(weekForTitle: weekForTitle, scheme: "Multi-Checkbox")
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            confirm.addAction(b2)
            confirm.addAction(b3)
            confirm.addAction(b4)
            confirm.addAction(b5)
            confirm.addAction(cancel)
            self.present(confirm, animated: true, completion: nil)
        }
        // MARK: - score 5555
        let score = UIAlertAction(title: "Score", style: UIAlertAction.Style.default) { (action) in
            //confirm scheme change
            let confirm = UIAlertController(title: "Confirm", message: "Are you sure to change Marking scheme of \(weekForTitle) to Score? If you are, please type in the total score (1 ~ 100 and number only). Please do not make mistake otherwise you will regret it🤪!" , preferredStyle: UIAlertController.Style.alert)
            confirm.addTextField()
            let scoreInput = confirm.textFields![0]
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            let OK = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action) in
                if scoreInput.text == "" {
                    let f = UIAlertController(title: "ERROR😡", message: "Be Careful! Cannot be empty! As punishment, you have to do it from start😡 ", preferredStyle: UIAlertController.Style.alert)
                    let aaa = UIAlertAction(title: "I accept punishment🤭", style: UIAlertAction.Style.default)
                    f.addAction(aaa)
                    self.present(f, animated: true,  completion: nil)
                }else if  CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: scoreInput.text ?? "qqq")) == false {
                    let f = UIAlertController(title: "ERROR😡", message: "Be Careful! Number only!(prohibit all symbols including minus signs!🤪)!As punishment, you have to do it from start😡", preferredStyle: UIAlertController.Style.alert)
                    let ok = UIAlertAction(title: "I accept punishment🤭", style: UIAlertAction.Style.default)
                    f.addAction(ok)
                    self.present(f, animated: true,  completion: nil)
                }else if let intInput : Int = Int(scoreInput.text!){
                    if intInput > 100 || intInput < 1 {
                        let f = UIAlertController(title: "ERROR😡", message: "Do not over the score scope (1~100)!🤪As punishment, you have to do it from start😡", preferredStyle: UIAlertController.Style.alert)
                        let ok = UIAlertAction(title: "I accept punishment🤭", style: UIAlertAction.Style.default)
                        f.addAction(ok)
                        self.present(f, animated: true,  completion: nil)
                    }else{
                        print(intInput)
                        self.updateScheme(wk: weekForTitle, scheme: "Score", number: intInput)
                        self.weekToBtn(weekForTitle: weekForTitle, scheme: "Score")
                    }
                }else{
                    let f = UIAlertController(title: "Marking Fail", message: "Only in-scope number is allowed! Havier suggest you please do not try any magic operations🤪", preferredStyle: UIAlertController.Style.alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                    f.addAction(ok)
                    self.present(f, animated: true,  completion: nil)
                }
            }
            confirm.addAction(OK)
            confirm.addAction(cancel)
            self.present(confirm, animated: true, completion: nil)
            print("HERE?")
             
        }
        
        
        
        
        
        
        // others
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        popup.addAction(checkbox)
        popup.addAction(HD)
        popup.addAction(A)
        popup.addAction(multi)
        popup.addAction(score)
        popup.addAction(cancel)
        self.present(popup, animated: true, completion: nil)
    }
    
    func weekToBtn(weekForTitle: String, scheme: String) {
        switch weekForTitle {
        case "Week 2":
            w2Scheme.setTitle(scheme, for: .normal)
        case "Week 3":
            w3Scheme.setTitle(scheme, for: .normal)
        case "Week 4":
            w4Scheme.setTitle(scheme, for: .normal)
        case "Week 5":
            w5Scheme.setTitle(scheme, for: .normal)
        case "Week 6":
            w6Scheme.setTitle(scheme, for: .normal)
        case "Week 7":
            w7Scheme.setTitle(scheme, for: .normal)
        case "Week 8":
            w8scheme.setTitle(scheme, for: .normal)
        case "Week 9":
            w9Scheme.setTitle(scheme, for: .normal)
        case "Week 10":
            w10Scheme.setTitle(scheme, for: .normal)
        case "Week 11":
            w11Scheme.setTitle(scheme, for: .normal)
        case "Week 12":
            w12Scheme.setTitle(scheme, for: .normal)
            
        default:
            print("")
        }
    }
    func numberOrNot(number: Int) -> String {
        var show = ""
        switch number {
        case 0:
            show = ""
        default:
            show = "(\(number))"
        }
        return show
    }
    
    // MARK: - segue
    @IBAction func unwindToStudent(sender: UIStoryboardSegue ){
        
    }
    @IBAction func unwindToStudentWithCancel(sender: UIStoryboardSegue ){
        
    }
    @IBAction func unwindToaaaStudent(sender: UIStoryboardSegue ){
        
    }
    @IBAction func unwindToaaaStudentWithCancel(sender: UIStoryboardSegue ){
        
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let db = Firestore.firestore()
        let schemeCollection = db.collection("scheme")
        schemeCollection.getDocuments(){ (result, err) in
            if let err = err
            { print("Error getting documents: \(err)")  }
            else
            {
                for document in result!.documents
                {
                    let conversionResult = Result
                    {
                        try document.data(as: schemeStruct.self)
                    }
                    switch conversionResult
                    {
                    case .success(let convertedDoc):
                        if let schemeCase = convertedDoc
                        {
                            self.schemeNew.append(schemeCase)
                            //set data to scheme button
                            
                        }
                        else
                        {
                            print("Document does not exist")
                        }
                    case                                                        .failure(let error):
                        print("Error decoding students: \(error)")
                    }
                }
            }
            self.w2Scheme.setTitle(self.showScheme(scheme: self.schemeNew[4].type ?? "No yet"), for: .normal)
            self.w3Scheme.setTitle(self.showScheme(scheme: self.schemeNew[5].type ?? "No yet"), for: .normal)
            self.w4Scheme.setTitle(self.showScheme(scheme: self.schemeNew[6].type ?? "No yet"), for: .normal)
            self.w5Scheme.setTitle(self.showScheme(scheme: self.schemeNew[7].type ?? "No yet"), for: .normal)
            self.w6Scheme.setTitle(self.showScheme(scheme: self.schemeNew[8].type ?? "No yet"), for: .normal)
            self.w7Scheme.setTitle(self.showScheme(scheme: self.schemeNew[9].type ?? "No yet"), for: .normal)
            self.w8scheme.setTitle(self.showScheme(scheme: self.schemeNew[10].type ?? "No yet"), for: .normal)
            self.w9Scheme.setTitle(self.showScheme(scheme: self.schemeNew[11].type ?? "No yet"), for: .normal)
            self.w10Scheme.setTitle(self.showScheme(scheme: self.schemeNew[1].type ?? "No yet"), for: .normal)
            self.w11Scheme.setTitle(self.showScheme(scheme: self.schemeNew[2].type ?? "No yet"), for: .normal)
            self.w12Scheme.setTitle(self.showScheme(scheme: self.schemeNew[3].type ?? "No yet"), for: .normal)
            
//            let mirror = Mirror(reflecting: one)
//            for child in mirror.children{
//                print("\(child.label), \(child.value)")
//            }
            
        }
        
        
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "toWeek"
        {
            if let weekScreen = segue.destination as? studentUITableViewController
            {
                weekScreen.navigationItem.title = sender as? String
                weekScreen.wk = sender as? String
                
                
            }
        }
    }


}


