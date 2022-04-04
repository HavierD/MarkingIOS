//
//  studentUITableViewController.swift
//  A3HuaizhiDai530562
//
//  Created by mobiledev on 9/5/21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class studentUITableViewController: UITableViewController {
    
    //var and let
    var studentsNew = [studentsStruct]()
    var wk : String? = nil
    var wkNo : String? = nil
    var switchState = true
    var schemeType = "a type"
    var schemeNumber = -3
    var test = "testwww" //for test
    var summary = 0
    var n: Float = 1
    

    //outlets statement
    @IBOutlet var countOfStudents: UILabel!
    @IBOutlet var markScheme: UILabel!
    @IBOutlet var summaryAverage: UILabel!
    
    @IBOutlet var clearFilterState: UIBarButtonItem!
    
    //actions statements
    //test
    
    @IBAction func test(_ sender: Any) {
        print(test)
    }
    
    
    //MARK: help
    @IBAction func help(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myAlert = storyboard.instantiateViewController(withIdentifier: "studentHelp")
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(myAlert, animated: true, completion: nil)
    }
    
   
    @IBAction func clearFilter(_ sender: Any) {
        studentsNew.removeAll()
        let db = Firestore.firestore()
        let studentsCollection = db.collection("students")
        studentsCollection.getDocuments(){ [self] (result, err) in
            if let err = err
            { print("Error getting documents: \(err)")  }
            else
            {
                for document in result!.documents
                {
                    let conversionResult = Result
                    {
                        try document.data(as: studentsStruct.self)
                    }
                    switch conversionResult
                    {
                    case .success(let convertedDoc):
                        if var studentCase = convertedDoc
                        {
                            studentCase.iid = document.documentID
                            //print("students: \(studentCase)")

                            self.studentsNew.append(studentCase)
                        }
                        else
                        {
                            print("Document does not exist")
                        }
                    case                                                        .failure(let error):
                        print("Error decoding students: \(error)")
                    }
                }
                self.tableView.reloadData()
                self.clearFilterState.isEnabled = false
            }
        }
    }
    
    
    
    //add new
    @IBAction func addNewStudent(_ sender: Any) {
        self.performSegue(withIdentifier: "toAdd", sender: nil)
    }
    
//    @IBAction func markBtn(_ sender: Any) {
//
//    }
    //MARK: filter
    @IBAction func filter(_ sender: Any) {
        let filterAlert = UIAlertController(title: "Filter by ID", message: "type in student ID (full ID)", preferredStyle: UIAlertController.Style.alert)
        var aa : UITextField?
        filterAlert.addTextField{ (textField) -> Void in
            aa = textField
            aa?.keyboardType = .numberPad
        }
        let typeInFilter = filterAlert.textFields![0]
       
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        
        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) in
            let db = Firestore.firestore()
            let studentCollection = db.collection("students")
            if let input = typeInFilter.text {
                //studentCollection.whereField("id", isGreaterThanOrEqualTo: input ).getDocuments{ (result, err) in
                studentCollection.whereField("id", isEqualTo: input ).getDocuments{ (result, err) in
                    if let err = err {
                        print("Error getting \(err)")
                    }
                    else
                    {
                        self.studentsNew.removeAll()
                        self.clearFilterState.isEnabled = true
                        for document in result!.documents
                        {
                            let conversionResult = Result
                            {
                                try document.data(as: studentsStruct.self)
                            }
                            switch conversionResult
                            {
                            case .success(let convertedDoc):
                                if var studentCase = convertedDoc
                                {
                                    studentCase.iid = document.documentID
                                    //print("students: \(studentCase)")
                                    
                                    self.studentsNew.append(studentCase)
                                    
                                }
                                else
                                {
                                    print("Document does not exist")
                                }
                            case                                                        .failure(let error):
                                print("Error decoding students: \(error)")
                            }
                        }
                        self.tableView.reloadData()
                        print("reload failed?")
                    }
                }
            }
            else
            {
                print("Wrong!!")
            }
            
        }
       
        filterAlert.addAction(ok)
        filterAlert.addAction(cancel)
        self.present(filterAlert, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func editScheme(_ sender: Any) {
        let pop = UIAlertController(title: "Go to Home Page?", message: "You can easily edit marking scheme on HOME page just by clicking the grey words after 'Week X'. Do you want to go to HOME page now?", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action) in
            self.performSegue(withIdentifier: "toHome1", sender: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        pop.addAction(ok)
        pop.addAction(cancel)
        self.present(pop, animated: true, completion: nil)
    }
    
    
    
    //MARK: -segues
    @IBAction func unwindToList(sender: UIStoryboardSegue)
    {
        if let infoScreen = sender.source as? DetailViewController{
            studentsNew[infoScreen.studentIndex!] = infoScreen.studentDetailNew!
            tableView.reloadData()
        }
    }
    
    @IBAction func unwindToListWithCancel(sender: UIStoryboardSegue)
    {
        
    }
    @IBAction func unwindToAdd(sender: UIStoryboardSegue)
    {
        
    }
    
    @IBAction func unwindToAddWithCancel(sender: UIStoryboardSegue)
    {
        
    }
    
    //remove back
    @IBAction func unwindRemoveBack(sender: UIStoryboardSegue){
        if let removeBack = sender.source as? DetailViewController{
            studentsNew.remove(at: removeBack.studentIndex!)
            tableView.reloadData()
        }
    }
    @IBAction func unwindRemoveBackWithCancel(sender: UIStoryboardSegue){
        
    }
    
    
    
    
    //MARK: -how to show function
    func howToShow(type:String, score: Int, number: Int) -> String {
        //help to implement summary
//        let i = Float(score)
//        summary = (summary*n + i)/(n + 1)
//        n = n + 1
//        summaryAverage.text = String(summary)
        
        var show1 = ""
        if type == "Checkbox"{
            switch score{
            case 100:
                show1 = "Present"
            case 0:
                show1 = "Absent"
            default:
                show1 = String(score)
            }
        }else if type .contains("ulti"){
            let NO = String(score*number/100)
            show1 = "\(NO) / \(number)"
            
        }else if type .contains("HD"){
            switch score {
            case 100:
                show1 = "HD+"
            case 80:
                show1 = "HD"
            case 70:
                show1 = "DN"
            case 60:
                show1 = "CR"
            case 50:
                show1 = "PP"
            case 0:
                show1 = "NN"
            default:
                show1 = String(score)
            }
            
        }else if type .contains("A/B"){
            switch score {
            case 100:
                show1 = "A"
            case 80:
                show1 = "B"
            case 70:
                show1 = "C"
            case 60:
                show1 = "D"
            case 0:
                show1 = "F"
            default:
                show1 = String(score)
            }
        }else if type .contains("core"){
            let NO = score * number / 100
            show1 = "\(NO) / \(number)"
        }
        return show1
    }
    
    
    
    //MARK: - viewDidLoad start
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        
        //MARK: - get data to a "for"
        let db = Firestore.firestore()
        let studentsCollection = db.collection("students")
        studentsCollection.getDocuments(){ [self] (result, err) in
            if let err = err
            { print("Error getting documents: \(err)")  }
            else
            {
                for document in result!.documents
                {
                    let conversionResult = Result
                    {
                        try document.data(as: studentsStruct.self)
                    }
                    switch conversionResult
                    {
                    case .success(let convertedDoc):
                        if var studentCase = convertedDoc
                        {
                            studentCase.iid = document.documentID
                            //print("students: \(studentCase)")

                            self.studentsNew.append(studentCase)
                        }
                        else
                        {
                            print("Document does not exist")
                        }
                    case                                                        .failure(let error):
                        print("Error decoding students: \(error)")
                    }
                }
                self.tableView.reloadData()
                
               sum()
            }            
        }
        let schemeCollection = db.collection("scheme")
        schemeCollection.document(wk ?? "WEEK X").getDocument{
            (resultt, err) in
            if let err = err{
                print("Error getting document: \(err)")
            }else{
                let value = resultt?.data()
                self.schemeType = value?["type"] as? String ?? "default one"
                self.markScheme.text = value?["type"] as? String ?? "default one"
                self.schemeNumber = value?["number"] as? Int ?? -2
                
            }
        }
        
        

        

        
        
    }/// view did load end

    // MARK: - Table view data

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        self.countOfStudents.text = "\(studentsNew.count) Students"

        return studentsNew.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentUITableViewCell", for: indexPath)
        
        //get the students for this row
        let studentRow = studentsNew[indexPath.row]
        
        //down-cast the cell from UITableViewCell to our cell class StudentUITableViewCell
        //note, this could fail, so we use an if let.
        if let studentCell = cell as? StudentUITableViewCell
        {
            //populate the cell
            studentCell.titleLabel.text = studentRow.firstName
            studentCell.subTitleLabel.text = studentRow.id
            studentCell.familyName.text = studentRow.familyName
            studentCell.wk = navigationItem.title ?? "WeekXX"
            studentCell.schemeType = schemeType
            studentCell.schemeNumber = schemeNumber
            studentCell.iid = studentRow.iid ?? "error"
            studentCell.sIndex = indexPath.row
            studentCell.studentNew = studentRow
            
            
            
            // change week to wk, to find corresponding data from database
            switch wk {
            case "Week 2":
                let mark: Int = studentRow.w2 ?? 0
                    let show = howToShow(type: schemeType, score: mark, number: schemeNumber)
                    studentCell.markBtn.setTitle(show, for: .normal)
                    studentCell.score = mark
                
            case "Week 3":
                let mark: Int = studentRow.w3 ?? 0
                    let show = howToShow(type: schemeType, score: mark, number: schemeNumber)
                    studentCell.markBtn.setTitle(show, for: .normal)
                    studentCell.score = mark
                
            case "Week 4":
                let mark: Int = studentRow.w4 ?? 0
                    let show = howToShow(type: schemeType, score: mark, number: schemeNumber)
                    studentCell.markBtn.setTitle(show, for: .normal)
                    studentCell.score = mark
                
            case "Week 5":
                let mark: Int = studentRow.w5 ?? 0
                    let show = howToShow(type: schemeType, score: mark, number: schemeNumber)
                    studentCell.markBtn.setTitle(show, for: .normal)
                    studentCell.score = mark
                
            case "Week 6":
                let mark: Int = studentRow.w6 ?? 0
                    let show = howToShow(type: schemeType, score: mark, number: schemeNumber)
                    studentCell.markBtn.setTitle(show, for: .normal)
                    studentCell.score = mark
                
            case "Week 7":
                let mark: Int = studentRow.w7 ?? 0
                    let show = howToShow(type: schemeType, score: mark, number: schemeNumber)
                    studentCell.markBtn.setTitle(show, for: .normal)
                    studentCell.score = mark
                
            case "Week 8":
                let mark: Int = studentRow.w8 ?? 0
                    let show = howToShow(type: schemeType, score: mark, number: schemeNumber)
                    studentCell.markBtn.setTitle(show, for: .normal)
                    studentCell.score = mark
                
            case "Week 9":
                let mark: Int = studentRow.w9 ?? 0
                    let show = howToShow(type: schemeType, score: mark, number: schemeNumber)
                    studentCell.markBtn.setTitle(show, for: .normal)
                    studentCell.score = mark
                
            case "Week 10":
                let mark: Int = studentRow.w10 ?? 0
                    let show = howToShow(type: schemeType, score: mark, number: schemeNumber)
                    studentCell.markBtn.setTitle(show, for: .normal)
                    studentCell.score = mark
                
            case "Week 11":
                let mark: Int = studentRow.w11 ?? 0
                let show = howToShow(type: schemeType, score: mark, number: schemeNumber)
                studentCell.markBtn.setTitle(show, for: .normal)
                studentCell.score = mark
                
            case "Week 12":
                let mark: Int = studentRow.w12 ?? 0
                let show = howToShow(type: schemeType, score: mark, number: schemeNumber)
                studentCell.markBtn.setTitle(show, for: .normal)
                studentCell.score = mark
                
            default:
                print(1)
            }
            
        }
        
        return cell
    }
    
    
    //MARK: - turn to student page
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        
        //reget data
        
        

        // is this the segue to the details screen? (in more complex apps, there is more than one segue per screen)
        //to student segue viewing mode
        
            if segue.identifier == "toStudent"
            {
                //down-cast from UIViewController to DetailViewController (this could fail if we didn’t link things up properly)
                guard let detailViewController = segue.destination as? DetailViewController else
                {
                    fatalError("Unexpected destination: \(segue.destination)")
                }

                //down-cast from UITableViewCell to MovieUITableViewCell (this could fail if we didn’t link things up properly)
                guard let selectedStudentCell = sender as? StudentUITableViewCell else
                {
                    fatalError("Unexpected sender: \( String(describing: sender))")
                }

                //get the number of the row that was pressed (this could fail if the cell wasn’t in the table but we know it is)
                guard let indexPath = tableView.indexPath(for: selectedStudentCell) else
                {
                    fatalError("The selected cell is not being displayed by the table")
                }

                //work out which movie it is using the row number
                let selectedStudent = studentsNew[indexPath.row]

                //send it to the details screen
                detailViewController.studentDetailNew = selectedStudent
                detailViewController.studentIndex = indexPath.row
                detailViewController.wk = wk
                detailViewController.idd = selectedStudent.iid ?? "qqq"
                detailViewController.schemeVar = schemeType
                detailViewController.studentIndex = indexPath.row
                //detailViewController.

            }
        
        //studentToMark segue marking mode
       


    }
    //MARK: - Summary
    func sum(){
        var studentNewSum = [studentsStruct]()
        //get data
        let db = Firestore.firestore()
        let studentsCollection = db.collection("students")
        studentsCollection.getDocuments(){ [self] (result, err) in
            if let err = err
            { print("Error getting documents: \(err)")  }
            else
            {
                for document in result!.documents
                {
                    let conversionResult = Result
                    {
                        try document.data(as: studentsStruct.self)
                    }
                    switch conversionResult
                    {
                    case .success(let convertedDoc):
                        if var studentCase = convertedDoc
                        {
                            studentCase.iid = document.documentID
                            //print("students: \(studentCase)")

                            studentNewSum.append(studentCase)
                        }
                        else
                        {
                            print("Document does not exist")
                        }
                    case                                                        .failure(let error):
                        print("Error decoding students: \(error)")
                    }
                }
        var n = 0
        for a in studentNewSum
        {
            switch wk {
            case "Week 2":
                summary += a.w2 ?? 0
            case "Week 3":
                summary += a.w3 ?? 0
            case "Week 4":
                summary += a.w4 ?? 0
            case "Week 5":
                summary += a.w5 ?? 0
            case "Week 6":
                summary += a.w6 ?? 0
            case "Week 7":
                summary += a.w7 ?? 0
            case "Week 8":
                summary += a.w8 ?? 0
            case "Week 9":
                summary += a.w9 ?? 0
            case "Week 10":
                summary += a.w10 ?? 0
            case "Week 11":
                summary += a.w11 ?? 0
            case "Week 12":
                summary += a.w12 ?? 0
            default:
                print("")
            }
            n += 1
        }
        let summary1 = summary / n
        summaryAverage.text = String(summary1)
//                su@@@@@@@@@@@
//                n = 0
    }
        }
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
