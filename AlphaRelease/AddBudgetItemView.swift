import UIKit
import CoreData

class AddBudgetItemView: UIViewController {
    var budgetItem : [NSManagedObject] = []
    
    @IBOutlet weak var itemField2: UITextField!
    @IBOutlet weak var amountField2: UITextField!
    @IBOutlet weak var dynamicLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Budget Item"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addItemBtn(_ sender: Any) {
        let item2Text = itemField2.text!
        let amount2Text = amountField2.text!
        
        if item2Text != "" && amount2Text != "" && amount2Text.isNumeric {
            saveBudgetItem(amount2: Float(amountField2!.text!)!, item2: (itemField2?.text!)!)
            //float?
//            dynamicLabel2?.text = "Budget Item Saved!"
            navigationController?.popViewController(animated: true)
        } else {
            let detailAlert = UIAlertController(title: "Message", message: "You must enter a value for all fields." , preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            detailAlert.addAction(OKAction)
            present(detailAlert, animated: true, completion:nil)
        }
    }
    
    // creating, saving, updating core data entity
    private func saveBudgetItem(amount2: Float, item2: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity =  NSEntityDescription.entity(forEntityName: "BudgetItem", in: managedContext)
        let budgetEntry = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        // Setting core data budget item attribute values
        budgetEntry.setValue(Float(amount2), forKey: "cost2")
        budgetEntry.setValue(item2, forKey: "item2")
        
        // implements changes and handles errors
        do {
            try managedContext.save()
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        // Addends the new entity to the array of managed objects
        budgetItem.append(budgetEntry)
    }
    
    // override function that resigns the name and city keyboards when either background or return is pressed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        itemField2.resignFirstResponder()
        amountField2.resignFirstResponder()
    }
}

//extension contains keyboard actions implemented to simulation
extension AddBudgetItemView : UITextFieldDelegate {
    //when tapping textfield it becomes first responder
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
