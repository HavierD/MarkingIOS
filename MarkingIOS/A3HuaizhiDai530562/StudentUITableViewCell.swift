//
//  StudentUITableViewCell.swift
//  A3HuaizhiDai530562
//
//  Created by mobiledev on 9/5/21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift


class StudentUITableViewCell: UITableViewCell {

    //var let states
    var iid  = ""
    var wk = "weekX"
    let db = Firestore.firestore()
    var schemeType = ""
    var schemeNumber = -4
    var testScheme = ""
    var score = 0
    var sIndex = 0
    var studentNew : studentsStruct?
    
    //test
    
    
    
    
    //MARK: -update marks
    func updateMarks( wk: String, score: Int)
    {
        let markCollection = db.collection("students")
        markCollection.document(iid).updateData([wk: score])
        {
            (err) in
            if let err = err{
                print("error update \(self.iid) in \(wk) to \(score)")
            }else{
                print("sucess update \(self.iid) in \(wk) to \(score)")
                
            }
        }
    }
    
    //week&wk function
    func weekToW(a: String) -> String {
        var wka = "WeekXXX"
        switch a {
        case "Week 2":
            wka = "w2"
        case "Week 3":
            wka = "w3"
        case "Week 4":
            wka = "w4"
        case "Week 5":
            wka = "w5"
        case "Week 6":
            wka = "w6"
        case "Week 7":
            wka = "w7"
        case "Week 8":
            wka = "w8"
        case "Week 9":
            wka = "w9"
        case "Week 10":
            wka = "w10"
        case "Week 11":
            wka = "w11"
        case "Week 12":
            wka = "w12"
        default:
            print("")
        }
        return wka
    }
        
    
    //outlet statements
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var familyName: UILabel!
    @IBOutlet var markBtn: UIButton!
    
    
    
    //actions statements
   // MARK: - pop up part check 1
    @IBAction func test(_ sender: Any) {
         
        let wk1 = self.weekToW(a: self.wk)
        if schemeType == "Checkbox"
        {
            let popup = UIAlertController(title: "Checkbox", message: "present or absent", preferredStyle: UIAlertController.Style.alert)
            let present = UIAlertAction(title: "Present", style: UIAlertAction.Style.default ){(action) in
                self.markBtn.setTitle("Present", for: .normal)
                self.updateMarks( wk: wk1, score: 100)
            }
            let absent = UIAlertAction(title: "Absent", style: UIAlertAction.Style.destructive){ (action) in
                self.markBtn.setTitle("Absent", for: .normal)
                self.updateMarks( wk: wk1, score: 0)
                
            }
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            popup.addAction(present)
            popup.addAction(absent)
            popup.addAction(cancel)
            self.window?.rootViewController?.present(popup, animated: true, completion: nil)
        }else if schemeType .contains("Multi"){  //MARK: - multi 2
            //let boxNo = schemeNumber * score / 100
            let popup = UIAlertController(title: "Multi-Checkbox", message: "Select How Many Points You Want to Mark", preferredStyle: UIAlertController.Style.alert    )
            let multi0 = UIAlertAction(title: "0 / \(schemeNumber)", style: UIAlertAction.Style.default){(action) in
                self.markBtn.setTitle("0 / \(self.schemeNumber)", for: .normal)
                self.updateMarks( wk: wk1, score: 0)
            }
            let multi1 = UIAlertAction(title: "1 / \(schemeNumber)", style: UIAlertAction.Style.default){(action) in
                let real = 1 * 100 / self.schemeNumber
                self.markBtn.setTitle("1 / \(self.schemeNumber)", for: .normal)
                self.updateMarks( wk: wk1, score: real)
            }
            let multi2 = UIAlertAction(title: "2 / \(schemeNumber)", style: UIAlertAction.Style.default){(action) in
                let real = 2 * 100 / self.schemeNumber
                self.markBtn.setTitle("2 / \(self.schemeNumber)", for: .normal)
                self.updateMarks( wk: wk1, score: real)
            }
            let multi3 = UIAlertAction(title: "3 / \(schemeNumber)", style: UIAlertAction.Style.default){(action) in
                let real = 3 * 100 / self.schemeNumber
                self.markBtn.setTitle("3 / \(self.schemeNumber)", for: .normal)
                self.updateMarks( wk: wk1, score: real)
            }
            let multi4 = UIAlertAction(title: "4 / \(schemeNumber)", style: UIAlertAction.Style.default){(action) in
                let real = 4 * 100 / self.schemeNumber
                self.markBtn.setTitle("4 / \(self.schemeNumber)", for: .normal)
                self.updateMarks( wk: wk1, score: real)
            }
            let multi5 = UIAlertAction(title: "5 / \(schemeNumber)", style: UIAlertAction.Style.default){(action) in
                self.markBtn.setTitle("5 / \(self.schemeNumber)", for: .normal)
                self.updateMarks( wk: wk1, score: 100)
            }
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            popup.addAction(cancel)
            popup.addAction(multi0)
            popup.addAction(multi1)
            popup.addAction(multi2)
            if schemeNumber > 2 { popup.addAction(multi3) }
            if schemeNumber > 3 { popup.addAction(multi4) }
            if schemeNumber > 4 { popup.addAction(multi5) }
            self.window?.rootViewController?.present(popup, animated: true,  completion: nil)
        }else if schemeType .contains("HD"){  // MARK: - HD 3
            let popup = UIAlertController(title: "Grade(HD - NN)", message: "Choose a grade.", preferredStyle: UIAlertController.Style.alert)
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            let HDD = UIAlertAction(title: "HD+", style: UIAlertAction.Style.default){(action) in
                self.markBtn.setTitle("HD+", for: .normal)
                self.updateMarks(wk: wk1, score: 100)
            }
            let HD = UIAlertAction(title: "HD", style: UIAlertAction.Style.default){(action) in
                self.markBtn.setTitle("HD", for: .normal)
                self.updateMarks(wk: wk1, score: 80)
            }
            let DN = UIAlertAction(title: "DN", style: UIAlertAction.Style.default){(action) in
                self.markBtn.setTitle("DN", for: .normal)
                self.updateMarks(wk: wk1, score: 70)
            }
            let CR = UIAlertAction(title: "CR", style: UIAlertAction.Style.default){(action) in
                self.markBtn.setTitle("CR", for: .normal)
                self.updateMarks(wk: wk1, score: 60)
            }
            let PP = UIAlertAction(title: "PP", style: UIAlertAction.Style.default){(action) in
                self.markBtn.setTitle("PP", for: .normal)
                self.updateMarks(wk: wk1, score: 50)
            }
            let NN = UIAlertAction(title: "NN", style: UIAlertAction.Style.default){(action) in
                self.markBtn.setTitle("NN", for: .normal)
                self.updateMarks(wk: wk1, score: 0)
            }
            popup.addAction(HDD)
            popup.addAction(HD)
            popup.addAction(DN)
            popup.addAction(CR)
            popup.addAction(PP)
            popup.addAction(NN)
            popup.addAction(cancel)
            self.window?.rootViewController?.present(popup, animated: true,  completion: nil)
        }else if schemeType .contains("A/B"){  // MARK: - A    4
            let popup = UIAlertController(title: "Grade(A - F)", message: "Choose a grade.", preferredStyle: UIAlertController.Style.alert)
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            let A = UIAlertAction(title: "A", style: UIAlertAction.Style.default){(action) in
                self.markBtn.setTitle("A", for: .normal)
                self.updateMarks(wk: wk1, score: 100)
            }
            let B = UIAlertAction(title: "B", style: UIAlertAction.Style.default){(action) in
                self.markBtn.setTitle("B", for: .normal)
                self.updateMarks(wk: wk1, score: 80)
            }
            let C = UIAlertAction(title: "C", style: UIAlertAction.Style.default){(action) in
                self.markBtn.setTitle("C", for: .normal)
                self.updateMarks(wk: wk1, score: 70)
            }
            let D = UIAlertAction(title: "D", style: UIAlertAction.Style.default){(action) in
                self.markBtn.setTitle("D", for: .normal)
                self.updateMarks(wk: wk1, score: 60)
            }
            
            let F = UIAlertAction(title: "NN", style: UIAlertAction.Style.default){(action) in
                self.markBtn.setTitle("NN", for: .normal)
                self.updateMarks(wk: wk1, score: 0)
            }
            popup.addAction(A)
            popup.addAction(B)
            popup.addAction(C)
            popup.addAction(D)
            popup.addAction(F)
            popup.addAction(cancel)
            self.window?.rootViewController?.present(popup, animated: true,  completion: nil)
        }
        else
        {//MARK: - score
            var aa : UITextField?
            let popup = UIAlertController(title: "Score", message: "Score out of \(schemeNumber)", preferredStyle: UIAlertController.Style.alert)
            popup.addTextField{ (textField) -> Void in
                aa = textField
                aa?.keyboardType = .numberPad
            }
            let scoreInput = popup.textFields![0]
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            let OK = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action) in
                if scoreInput.text == "" {
                    let f = UIAlertController(title: "Marking Fail", message: "If you want to mark 0, please type 0 in. Score cannot be empty! (Preventing optional errors) ", preferredStyle: UIAlertController.Style.alert)
                    let aaa = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                    f.addAction(aaa)
                    self.window?.rootViewController?.present(f, animated: true,  completion: nil)
                }else if  CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: scoreInput.text ?? "qqq")) == false {
                    let f = UIAlertController(title: "Marking Fail", message: "Number only!(prohibit all symbols including minus signs!🤪)", preferredStyle: UIAlertController.Style.alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                    f.addAction(ok)
                    self.window?.rootViewController?.present(f, animated: true,  completion: nil)
                }else if let intInput : Int = Int(scoreInput.text!){
                    if intInput > self.schemeNumber || intInput < 0 {
                        let f = UIAlertController(title: "Marking Fail", message: "Do not over the score scope!🤪", preferredStyle: UIAlertController.Style.alert)
                        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                        f.addAction(ok)
                        self.window?.rootViewController?.present(f, animated: true,  completion: nil)
                    }else{
                        print(intInput)
                        let realOne = intInput * 100 / self.schemeNumber
                        self.updateMarks(wk: wk1, score: realOne)
                        self.markBtn.setTitle("\(String(intInput)) / \(self.schemeNumber)", for: .normal)
                    }
                }else{
                    let f = UIAlertController(title: "Marking Fail", message: "Only in-scope number is allowed! Havier suggest you please do not try any magic operations🤪", preferredStyle: UIAlertController.Style.alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                    f.addAction(ok)
                    self.window?.rootViewController?.present(f, animated: true,  completion: nil)
                }
                
            }
            popup.addAction(cancel)
            popup.addAction(OK)
            self.window?.rootViewController?.present(popup, animated: true, completion: nil)
        }
    }
    
    @IBAction func test2(_ sender: Any) {
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
