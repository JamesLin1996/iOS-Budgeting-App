import UIKit
import CoreData

class AddReceiptView: UIViewController {
    var receipt : [NSManagedObject] = []

    // labels are connected from storyboard
    @IBOutlet weak var sourceField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var itemField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var dynamicLabel: UILabel!
    
    override func viewDidLoad() {
        self.title = "Add Receipt"
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        let sourceText = sourceField.text!
        let dateText = dateField.text!
        let itemText = itemField.text!
        let amountText = amountField.text!
        
        if sourceText != "" && dateText != "" && itemText != "" && amountText != "" && amountText.isNumeric {
            saveReceipt(source: sourceField!.text!, date: dateField!.text!, amount: Float(amountField!.text!)!, item: (itemField?.text!)!)
            dynamicLabel?.text = "Receipt Saved!"
        } else {
            let detailAlert = UIAlertController(title: "Message", message: "You must enter a value for all fields." , preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            detailAlert.addAction(OKAction)
            present(detailAlert, animated: true, completion:nil)
        }
    }
    
    // creating, saving, updating core data entity
    private func saveReceipt(source: String, date: String, amount: Float, item: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity =  NSEntityDescription.entity(forEntityName: "Receipt", in: managedContext)
        let entry = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        // Setting core data Receipt attribute values
        entry.setValue(source, forKey: "source")
        entry.setValue(date, forKey: "date")
        entry.setValue(Float(amount), forKey: "cost")
        entry.setValue(item, forKey: "item")
        
        // implements changes and handles errors
        do {
            try managedContext.save()
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        // Addends the new entity to the array of managed objects
        receipt.append(entry)
    }
    
    // override function that resigns the name and city keyboards when either background or return is pressed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sourceField.resignFirstResponder()
        dateField.resignFirstResponder()
        itemField.resignFirstResponder()
        amountField.resignFirstResponder()
    }
}

//extension contains keyboard actions implemented to simulation
extension AddReceiptView : UITextFieldDelegate {
    //when tapping textfield it becomes first responder
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension String {
    var isNumeric: Bool {
        guard self.characters.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]
        return Set(self.characters).isSubset(of: nums)
    }
}
