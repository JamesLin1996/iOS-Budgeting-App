import UIKit
import CoreData

class CheckSplitterViewController: UIViewController {
    var personDetails : [NSManagedObject] = []
    
    @IBOutlet weak var personName2: UITextField!
    @IBOutlet weak var restaurant2: UITextField!
    @IBOutlet weak var amtOwed2: UITextField!
    @IBOutlet weak var date2: UITextField!
    @IBOutlet weak var dynamicLabel3: UILabel!
    
    @IBAction func goTNewScreen1(_ sender: Any) {
    }
    @IBAction func goToNewScreen2(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        self.title = "Add Person"
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func savePersonBtn(_ sender: Any) {
        let person2Text = personName2.text!
        let restaurant2Text = restaurant2.text!
        let amt2Text = amtOwed2.text!
        let date2Text = date2.text!
        
        if person2Text != "" && restaurant2Text != "" && amt2Text != "" && date2Text != "" && amt2Text.isNumeric {
            personDetailItem(amt2: Float(amtOwed2!.text!)!, date_2: (date2?.text!)!, person2: (personName2?.text!)!, restaurant_2: (restaurant2?.text!)!)
            dynamicLabel3?.text = "You Have Been Added!"
            navigationController?.popViewController(animated: true)
        } else {
            let detailAlert = UIAlertController(title: "Message", message: "You must enter a value for all fields." , preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            detailAlert.addAction(OKAction)
            present(detailAlert, animated: true, completion:nil)
        }
    }
    
    private func personDetailItem (amt2: Float, date_2: String, person2: String, restaurant_2:String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity =  NSEntityDescription.entity(forEntityName: "PersonDetails", in: managedContext)
        let detailEntry = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        detailEntry.setValue(person2, forKey: "personName2")
        detailEntry.setValue(restaurant_2, forKey: "restaurant2")
        detailEntry.setValue(Float(amt2), forKey: "owed2")
        detailEntry.setValue(date_2, forKey: "date2")
        
        do {
            try managedContext.save()
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        // Addends the new entity to the array of managed objects
        personDetails.append(detailEntry)
    }
}

//extension contains keyboard actions implemented to simulation
extension CheckSplitterViewController : UITextFieldDelegate {
    //when tapping textfield it becomes first responder
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
