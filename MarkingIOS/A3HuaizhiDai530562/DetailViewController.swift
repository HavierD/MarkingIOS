//
//  DetailViewController.swift
//  A3HuaizhiDai530562
//
//  Created by mobiledev on 9/5/21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift


class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    

    
    //MARK: - Statements
    //var and let
    let db = Firestore.firestore()
    var studentDetailNew : studentsStruct?
    var studentIndex : Int?
    var wk : String? = nil
    var summaryPlus = 0 //all marks were added together
    var idd = "qqq"
    var schemeVar = ""
    var summaryForShare = ""
    let storage = Storage.storage()
    

    // outlets statements
    @IBOutlet var imageLoading: UILabel!
    @IBOutlet var FirstnameLabel: UITextField!
    @IBOutlet var familynameLabel: UITextField!
    @IBOutlet var IDLabel: UITextField!
    @IBOutlet var currentWeek: UILabel!
    @IBOutlet var currentMark: UIButton!
    @IBOutlet var week2Mark: UIButton!
    @IBOutlet var week3Mark: UIButton!
    @IBOutlet var week4Mark: UIButton!
    @IBOutlet var week5Mark: UIButton!
    @IBOutlet var week6Mark: UIButton!
    @IBOutlet var week7Mark: UIButton!
    @IBOutlet var week8Mark: UIButton!
    @IBOutlet var week9Mark: UIButton!
    @IBOutlet var week10Mark: UIButton!
    @IBOutlet var week11Mark: UIButton!
    @IBOutlet var week12Mark: UIButton!
    @IBOutlet var summary: UILabel!
    @IBOutlet var saveEdit: UIBarButtonItem!
    @IBOutlet var scheme: UILabel!
    @IBOutlet var remove: UIBarButtonItem!
    @IBOutlet var imageOfStudent: UIImageView!
    
    
    @IBAction func remoe(_ sender: Any) {
        let pop1 = UIAlertController(title: "Warning!😠", message: "You are removing the student \(String(FirstnameLabel.text ?? "")) \(String(familynameLabel.text ?? "")). Are you sure?", preferredStyle: UIAlertController.Style.alert)
        let yes = UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive) { (action) in
            let pop2 = UIAlertController(title: "😿WARNING🙀", message: "All the data of the student will be removed and will never be got back!", preferredStyle: UIAlertController.Style.alert)
            let yes = UIAlertAction(title: "Of course!", style: UIAlertAction.Style.destructive) { (action) in
                let studentCollection = self.db.collection("students")
                studentCollection.document(self.idd).delete(){ err in
                    if let err = err{
                        print("ERROR removing \(err)")
                        let pop3 = UIAlertController(title: "ERROR", message: "REMOVING error, please try it later", preferredStyle: UIAlertController.Style.alert)
                        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                        pop3.addAction(ok)
                        self.present(pop3, animated: true, completion: nil)
                    }else{
                        print("remove successfully")
                        self.performSegue(withIdentifier: "removeBack", sender: sender)
                    }
                }
                
            }
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            pop2.addAction(yes)
            pop2.addAction(cancel)
            self.present(pop2, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        pop1.addAction(cancel)
        pop1.addAction(yes)
        self.present(pop1, animated: true, completion: nil)
        
    }
    
    
    
    //functions
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
    
    
    //actions
    //edit common information
    
    @IBAction func help(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myAlert = storyboard.instantiateViewController(withIdentifier: "detailHelp")
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(myAlert, animated: true, completion: nil)
    }
    
    @IBAction func firstNameEdit(_ sender: Any) {
        saveEdit.isEnabled = true
    }
    @IBAction func familyNameEdit(_ sender: Any) {
        saveEdit.isEnabled = true
    }
    @IBAction func IDEdit(_ sender: Any) {
        saveEdit.isEnabled = true
    }
    
    
    @IBAction func markingCurrent(_ sender: Any) {
    }
    
    
    
    @IBAction func unwildToMarking(sender: UIStoryboardSegue)
    {
        
    }
    
    @IBAction func unwindToMarkingWithCancel(sender: UIStoryboardSegue)
    {
        
    }
    
    @IBAction func saveEdit(_ sender: Any) {
        (sender as! UIBarButtonItem).title = "Loadinggg"
        if FirstnameLabel.text == "" || familynameLabel.text == "" || IDLabel.text == ""
        {
            commonAlert(title: "Warning!", message: "None of the first name, family name, or student ID can be empty!", btnTitle: "OK")
        }
        else if let cc = IDLabel.text
        {
            let checkDigit = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: cc))
            if checkDigit == true
            {
                studentDetailNew?.firstName = FirstnameLabel.text!
                studentDetailNew?.familyName = familynameLabel.text!
                studentDetailNew?.id = IDLabel.text!
                do
                {
                    try db.collection("students").document(idd).setData(from: studentDetailNew!){
                        err in
                        if let err = err{
                            print("error:\(err)")
                        }else{
                            print("successfully")
                        }
                    }
                }catch{print("error")}
                let alert = UIAlertController(
                    title: "Congratulations",
                    message: "This student has been updated successfully",
                    preferredStyle: UIAlertController.Style.alert
                )
                alert.addAction(UIAlertAction(
                    title:  "OK",
                    style: UIAlertAction.Style.cancel){ (action) in
                    self.performSegue(withIdentifier: "saveInfo", sender: sender)
                })
                self.present(alert, animated: true, completion: nil)
                
                
                
            }
            else
            {
                commonAlert(title: "Warning!", message: "The ID can only contain numbers", btnTitle: "OK")
            }
            
        }
    }
    //MARK: camera
    @IBAction func camera(_ sender: Any) {
        let cameraOrImage = UIAlertController(title: "Use Camera or Image Library?", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        let cameraChoice = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default)
        { (action) in  //camera
            if UIImagePickerController.isSourceTypeAvailable(.camera)
            {
                print("Camera available")
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
                
            }
            else
            {
                print("No camera available")
                let popup = UIAlertController(title: "ERROR😞", message: "Sorry, this iphone have no camera.😭", preferredStyle: UIAlertController.Style.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                popup.addAction(ok)
                self.present(popup, animated: true, completion: nil)
            }
        }// image library
        let ImageChoice = UIAlertAction(title: "Image Library", style: UIAlertAction.Style.default)
        { (action) in  // image library
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
            {
                print("library availale")
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
            else
            {
                print("no library available")
                let popup = UIAlertController(title: "ERROR😞", message: "Sorry, this iphone have no phooLibrary.😭", preferredStyle: UIAlertController.Style.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                popup.addAction(ok)
                self.present(popup, animated: true, completion: nil)
            }
            
            
        }
        //saved photo album
        let album = UIAlertAction(title: "Saved Photo Album", style: UIAlertAction.Style.default)
        { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
            {
                print("album available")
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .savedPhotosAlbum
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
                
            }
            else
            {
                print("no album available")
                let popup = UIAlertController(title: "ERROR😞", message: "Sorry, this iphone have no saved photo album.😭", preferredStyle: UIAlertController.Style.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                popup.addAction(ok)
                self.present(popup, animated: true, completion: nil)
            }
                
        }
        
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        cameraOrImage.addAction(cameraChoice)
        //cameraOrImage.addAction(ImageChoice)
        cameraOrImage.addAction(album)
        cameraOrImage.addAction(cancel)
        self.present(cameraOrImage, animated: true, completion: nil)
        
        
        
    }
    
    //camera functions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let imageData = image.pngData()
        {
            imageOfStudent.image = image
            //MARK: uploadImageToStorage
            let storage = Storage.storage()
            
            let StorageRef = storage.reference().child(idd).child("\(idd).png")
            let metaData = StorageMetadata()
            metaData.contentType = "image/png"
            StorageRef.putData(imageData, metadata: metaData){ (metaData, error) in
                if error == nil, metaData != nil {
                    StorageRef.downloadURL{ url, error in
                        if let url = url {
                            print(url)
                            
                        }
                    }
                }
                else
                {
                    print(error?.localizedDescription)
                }
                
            }
            
            
            
            
            
            
            

//            let data = Data()
//            let imageRef = StorageRef.child("myImage.png")
//            let iploadTask = imageRef.putData(image.pngData()!, metadata: nil){ (metadata, error) in
//                guard let metadata = metadata else{
//                    return
//                }
//                let size = metadata.size
//                imageRef.downloadURL{ (url, error) in
//                    guard let downloadURL = url else{
//                        return
//                    }
//                }
//            }
            
            dismiss(animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Share
    @IBAction func share(_ sender: Any) {
        let w2: String = String(studentDetailNew?.w2 ?? 0)
        let w3: String = String(studentDetailNew?.w3 ?? 0)
        let w4: String = String(studentDetailNew?.w4 ?? 0)
        let w5: String = String(studentDetailNew?.w5 ?? 0)
        let w6: String = String(studentDetailNew?.w6 ?? 0)
        let w7: String = String(studentDetailNew?.w7 ?? 0)
        let w8: String = String(studentDetailNew?.w8 ?? 0)
        let w9: String = String(studentDetailNew?.w9 ?? 0)
        let w10: String = String(studentDetailNew?.w10 ?? 0)
        let w11: String = String(studentDetailNew?.w11 ?? 0)
        let w12: String = String(studentDetailNew?.w12 ?? 0)
        let a = """
        {
            Mark list of \(String((studentDetailNew?.firstName)!)) \(String(studentDetailNew!.familyName)).
        ID: \(studentDetailNew?.id ?? "ERROR"). Week 2: \(w2);
        Week 3: \(w3); Week 4: \(w4); Week 5: \(w5); Week 6: \(w6);
        Week 7: \(w7); Week 8: \(w8); Week 9: \(w9); Week 10: \(w10);
        Week 11: \(w11); Week 12: \(w12); Summary: \(summaryForShare).

        }
        """
        
        let shareViewController = UIActivityViewController(
            activityItems: [a], applicationActivities: [])
        present(shareViewController, animated: true, completion: nil)
    }
    
    
    
    
    
    //MARK: View==didload
    override func viewDidLoad() {
        super.viewDidLoad()
        // reload data
        let schemeCollection = db.collection("students")
        schemeCollection.document(idd).getDocument{ [self]
            (resultt, err) in
            if let err = err{
                print("Error getting document: \(err)")
            }else{
                let value = resultt?.data()
                let w2: String = String(value?["w2"] as? Int ?? 0)
                let w3: String = String(value?["w3"] as? Int ?? 0)
                let w4: String = String(value?["w4"] as? Int ?? 0)
                let w5: String = String(value?["w5"] as? Int ?? 0)
                let w6: String = String(value?["w6"] as? Int ?? 0)
                let w7: String = String(value?["w7"] as? Int ?? 0)
                let w8: String = String(value?["w8"] as? Int ?? 0)
                let w9: String = String(value?["w9"] as? Int ?? 0)
                let w10: String = String(value?["w10"] as? Int ?? 0)
                let w11: String = String(value?["w11"] as? Int ?? 0)
                let w12: String = String(value?["w12"] as? Int ?? 0)
                week2Mark.setTitle(w2, for: .normal)
                week3Mark.setTitle(w3, for: .normal)
                week4Mark.setTitle(w4, for: .normal)
                week5Mark.setTitle(w5, for: .normal)
                week6Mark.setTitle(w6, for: .normal)
                week7Mark.setTitle(w7, for: .normal)
                week8Mark.setTitle(w8, for: .normal)
                week9Mark.setTitle(w9, for: .normal)
                week10Mark.setTitle(w10, for: .normal)
                week11Mark.setTitle(w11, for: .normal)
                week12Mark.setTitle(w12, for: .normal)
                
                print("where??")

             
                
                
            }
        }
        
        
        
        //MARK: -show image
        let storage = Storage.storage()
        
        let StorageRef = storage.reference().child(self.idd).child("\(self.idd).png")
        StorageRef.downloadURL{ url, error in
            if let error = error{
                print("image error: \(error)")
                self.imageLoading.text = "No image yet 😅"
            }
            else
            {
                print("this is image! \(url)")
                if let data = try? Data(contentsOf: url!)
                {
                    let image = UIImage(data:data)
                    self.imageOfStudent.image = image
                    self.imageLoading.text = ""
                }
            }
        }
        //MARK: -  this week and mark
        scheme.text = schemeVar
        currentWeek.text = wk
        var Mark: Int? = nil
        switch wk {
        case "Week 2":
            Mark = studentDetailNew?.w2
        case "Week 3":
            Mark = studentDetailNew?.w3
        case "Week 4":
            Mark = studentDetailNew?.w4
        case "Week 5":
            Mark = studentDetailNew?.w5
        case "Week 6":
            Mark = studentDetailNew?.w6
        case "Week 7":
            Mark = studentDetailNew?.w7
        case "Week 8":
            Mark = studentDetailNew?.w8
        case "Week 9":
            Mark = studentDetailNew?.w9
        case "Week 10":
            Mark = studentDetailNew?.w10
        case "Week 11":
            Mark = studentDetailNew?.w11
        case "Week 12":
            Mark = studentDetailNew?.w12
        default:
            print("")
        }
                
        if let mk: Int = Mark
        {
            let mk2 = String(mk)
            currentMark.setTitle(mk2, for: .normal)
        }
        else
        {
            currentMark.setTitle("0", for: .normal)
        }
        
        //MARK: - display all marks
        //week2
        if let w: Int = studentDetailNew?.w2{
            let ws = String(w)
            week2Mark.setTitle(ws, for: .normal)
            summaryPlus += w
        }
        else
        {
            week2Mark.setTitle("0", for: .normal)
        }
        
        //week3
        if let w: Int = studentDetailNew?.w3{
           
            let ws = String(w)
            week3Mark.setTitle(ws, for: .normal)
            summaryPlus += w
        }
        else
        {
            week3Mark.setTitle("0", for: .normal)
        }
        
        //week4
        if let w: Int = studentDetailNew?.w4{
            let ws = String(w)
            week4Mark.setTitle(ws, for: .normal)
            summaryPlus += w
        }
        else
        {
            week4Mark.setTitle("0", for: .normal)
        }
        
        //week5
        if let w: Int = studentDetailNew?.w5{
            let ws = String(w)
            week5Mark.setTitle(ws, for: .normal)
            summaryPlus += w
        }
        else
        {
            week5Mark.setTitle("0", for: .normal)
        }
        
        //week6
        if let w: Int = studentDetailNew?.w6{
            let ws = String(w)
            week6Mark.setTitle(ws, for: .normal)
            summaryPlus += w
        }
        else
        {
            week6Mark.setTitle("0", for: .normal)
        }
        
        //week7
        if let w: Int = studentDetailNew?.w7{
            let ws = String(w)
            week7Mark.setTitle(ws, for: .normal)
            summaryPlus += w
        }
        else
        {
            week7Mark.setTitle("0", for: .normal)
        }
        
        //week8
        if let w: Int = studentDetailNew?.w8{
            let ws = String(w)
            week8Mark.setTitle(ws, for: .normal)
            summaryPlus += w
        }
        else
        {
            week8Mark.setTitle("0", for: .normal)
        }
        
        //week 9
        if let w: Int = studentDetailNew?.w9{
            let ws = String(w)
            week9Mark.setTitle(ws, for: .normal)
            summaryPlus += w
        }
        else
        {
            week9Mark.setTitle("0", for: .normal)
        }
        
        //week 10
        if let w: Int = studentDetailNew?.w10{
            let ws = String(w)
            week10Mark.setTitle(ws, for: .normal)
            summaryPlus += w
        }
        else
        {
            week10Mark.setTitle("0", for: .normal)
        }
        
        //week 11
        if let w: Int = studentDetailNew?.w11{
            let ws = String(w)
            week11Mark.setTitle(ws, for: .normal)
            summaryPlus += w
        }
        else
        {
            week11Mark.setTitle("0", for: .normal)
        }
        
        //week12
        if let w: Int = studentDetailNew?.w12{
            let ws = String(w)
            week12Mark.setTitle(ws, for: .normal)
            summaryPlus += w
        }
        else
        {
            week12Mark.setTitle("0", for: .normal)
        }
        let summary1: Int = summaryPlus/11
        summaryForShare = String(summary1)
        print(summaryPlus)
        print(summary1)
        
        summary.text = String(summary1)
        
        
       
        
        
        
            
        
        // MARK: - display common information
        if let displayStudents = studentDetailNew
        {
            self.navigationItem.title = displayStudents.familyName
            FirstnameLabel.text = displayStudents.firstName
            familynameLabel.text = displayStudents.familyName
            IDLabel.text = displayStudents.id
        }

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
