//
//  AlertViewController.swift
//  A3HuaizhiDai530562
//
//  Created by mobiledev on 11/5/21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class AlertViewController: UIViewController {
    
    //var let statement
    var wk : String = "qwwwkkk"
    var type = "type"
    var id = "id"
    var score = -1
    var number = 0
    let db = Firestore.firestore()
    
    //test
     
    //test eeeeeeeend
    
    //outlets
    @IBOutlet var testLabel: UILabel!
    
    
    //actions
    @IBOutlet var gotIt: UIButton!
    @IBAction func gotIt(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        
        
        
    }
    
    @IBAction func getData(_ sender: Any) {
        let vcc = studentUITableViewController()
        vcc.tableView.reloadData()
        print("press")
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        testLabel.numberOfLines = 0
        
            //var type1 = "type1"        //test
//        let schemeCollection = db.collection("scheme")
//        schemeCollection.document("Week 2").getDocument{
//            (resultt, err) in
//            if let err = err{
//                print("Error getting document: \(err)")
//            }else{
//                let value = resultt?.data()
//                type1 = value?["type"] as? String ?? "default one"
//                self.number = value?["number"] as? Int ?? -2
//                print(type1)
//            }
//        }
//        testLabel.text = type1
                
        
        
        
        //test  end
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
