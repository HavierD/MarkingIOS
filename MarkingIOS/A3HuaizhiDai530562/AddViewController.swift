//
//  AddViewController.swift
//  A3HuaizhiDai530562
//
//  Created by mobiledev on 11/5/21.
//

import UIKit
import Foundation
import Firebase
import FirebaseFirestoreSwift

class AddViewController: UIViewController {
    
    //vars and lets statements
    let db = Firestore.firestore()
    
    //check empty or not
    var a = false
    var b = false
    var c = false
    
    //outlet statements
    @IBOutlet var firstnameOutlet: UITextField!
    @IBOutlet var familyNameOutlet: UITextField!
    @IBOutlet var IDOutlet: UITextField!
    @IBOutlet var confirmAdding: UIButton!
    
    
    //actions statements
    @IBAction func help(_ sender: Any) {
        let funny = UIAlertController(title: "🧐🧐🧐", message: "This page is too simple to provide help, but you can try to click 🦀, and see what happened.", preferredStyle: UIAlertController.Style.alert)
        let aaa = UIAlertAction(title: "🦀", style: UIAlertAction.Style.default) { (action) in
            //MARK: level 1
            let congr = UIAlertController(title: "Congratulations!", message: "If you have any feedbacks, please contact daih@utas.edu.au, or send message to 0480-177-426. By the way, Cookie is a good girl🤪!", preferredStyle: UIAlertController.Style.alert)
            var aa : UITextField?
            congr.addTextField{ (textField) -> Void in
                aa = textField
            }
            let Feedback = congr.textFields![0]
            let ok = UIAlertAction(title: "YES!", style: UIAlertAction.Style.default){ (action) in
                
            }
            
            congr.addAction(ok)
            
            self.present(congr, animated: true, completion: nil)
            Feedback
            
            
            
            
        }
        let no = UIAlertAction(title: "I don't want to see anything", style: UIAlertAction.Style.cancel)
        funny.addAction(aaa)
        funny.addAction(no)
        self.present(funny, animated: true)
        
    }
    
    //MARK: -three input functions
    @IBAction func firstNameAdd(_ sender: Any) {
        if let _: String = firstnameOutlet.text
        {
            a = true
        }
        else
        {
            a = false
        }
        if a && b && c
        {
            confirmAdding.isEnabled = true
        }
        else
        {
            confirmAdding.isEnabled = false
        }
    }
    
    @IBAction func familyNameAdd(_ sender: Any) {
        if let _: String = familyNameOutlet.text
        {
            b = true
        }
        else
        {
            b = false
        }
        if a && b && c
        {
            confirmAdding.isEnabled = true
        }
        else
        {
            confirmAdding.isEnabled = false
        }
        
    }
    
    @IBAction func IDAdd(_ sender: Any) {
        if let _: String = IDOutlet.text
        {
            c = true
        }
        else
        {
            c = false
        }
        if a && b && c
        {
            confirmAdding.isEnabled = true
        }
        else
        {
            confirmAdding.isEnabled = false
        }
    }
    
    func addStudent(n1: String, n2: String, i: String )
    {
        let studentsCollection = db.collection("students")
        
        studentsCollection.document(i).setData([
            "firstName": n1,
            "familyName": n2,
            "id": i
        ])  {err in
            if err != nil{
                print("Error")
            } else {
                print("successfully")
            }
        }
        
    }
    
    func commonAlert(title:String, message:String, btnTitle:String){
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(
                            title: btnTitle,
                            style: UIAlertAction.Style.cancel,
                            handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - confirm adding action
    @IBAction func confirmAdding(_ sender: Any) {
        var ca = "default"
        var cb = "default"
        var cc = "000000"
        if let confirmA:String = firstnameOutlet.text
        {
            ca = confirmA
        }
        if let confirmB = familyNameOutlet.text
        {
            cb = confirmB
        }
        if let confirmC: String = IDOutlet.text
        {
            cc = confirmC
        }
        //check ID
        let checkDigit = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: cc))
               
        // empty check
        if ca == "" || cb == "" || cc == ""
        {
            commonAlert(title: "Warning!", message: "None of the three input can be empty!", btnTitle: "OK")
        } else if checkDigit
        {
            addStudent(n1: ca, n2: cb, i: cc)
            let alert = UIAlertController(
                title: "Successfully!",
                message: "The student \(ca) \(cb) has been added!",
                preferredStyle: UIAlertController.Style.alert
            )
            alert.addAction(UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.cancel){
                (action) in
                self.performSegue(withIdentifier: "ToHome", sender: sender)
            })
            self.present(alert, animated: true, completion: nil)
            
        }
        else
        {//id number check
            commonAlert(title: "Warning!", message: "ID must only contain numbers!", btnTitle: "OK")
        }
        
        
        
        
    }
        
        //confrim adding end
    
    //test
        
    
    //test   end
  
   
    
    
    //MARK: - viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //database let

        //let studentCollection = db.collection("students")
        
        

        // Do any additional setup after loading the view.
    } ////view did load end
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

