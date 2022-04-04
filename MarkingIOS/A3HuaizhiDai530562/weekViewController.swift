//
//  weekViewController.swift
//  A3HuaizhiDai530562
//
//  Created by mobiledev on 9/5/21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class weekViewController: UIViewController {
    
    //all statements
    var weekNumberFromHome: String?

    //all outlets
    @IBOutlet var weekTitle: UILabel!
    
    //all actions
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // database settting
        let db = Firestore.firestore()
        let studentsCollection = db.collection("students")
        
        //title to chosen week number
        self.weekTitle.text = weekNumberFromHome

        //  MARK: - get students data
        studentsCollection.getDocuments(){ (result, err) in

            //check server
            if let err = err
            {
                print("Error getting documents: \(err)")
            }
            else
            {
                //loop through the results
                for document in result!.documents
                {
                    //attempt to convert to student objectlet
                    let conversionResult = Result
                    {
                        try document.data(as: studentsStruct.self)
                    }
                    switch conversionResult
                    {
                    case .success(let convertedDoc):
                        if let studentSwitch = convertedDoc
                        {
                            print("student: \(studentSwitch)")
                        }
                        else
                        {
                            print("document doesn't exist")
                        }
                    case.failure(let error):
                        print("Error decoding students: \(error)")


                    }
                }
            }
        }
        
        
        // test
//        let movieCollection = db.collection("movies")
//
//        movieCollection.getDocuments() { (result, err) in
//          //check for server error
//          if let err = err
//          {
//              print("Error getting documents: \(err)")
//          }
//          else
//          {
//              //loop through the results
//              for document in result!.documents
//              {
//                  //attempt to convert to Movie object
//                  let conversionResult = Result
//                  {
//                    try document.data(as: Movie.self)
//                  }
//
//                  //check if conversionResult is success or failure (i.e. was an exception/error thrown?
//                  switch conversionResult
//                  {
//                      //no problems (but could still be nil)
//                      case .success(let convertedDoc):
//                          if let movie = convertedDoc
//                          {
//                              // A `Movie` value was successfully initialized from the DocumentSnapshot.
//                              print("111111")
//                          }
//                          else
//                          {
//                              // A nil value was successfully initialized from the DocumentSnapshot,
//                              // or the DocumentSnapshot was nil.
//                              print("22222222222222")
//                          }
//                      case .failure(let error):
//                          // A `Movie` value could not be initialized from the DocumentSnapshot.
//                          print("333333333333")
//                  }
//              }
//          }
//        }
        
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
