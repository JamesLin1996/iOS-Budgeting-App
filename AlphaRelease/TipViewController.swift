import UIKit
import CoreData

class TipViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var taxTotalLabel: UILabel!
    @IBOutlet weak var taxPercentLabel: UILabel!
    
    @IBOutlet weak var stateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationController.hide

        // Do any additional setup after loading the view.
        billField.text = "100.00"
        taxPercentLabel.text = "0.00"
        stateLabel.text = " "
        tipControl.selectedSegmentIndex = 0
        calculateTipHelper()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print("view will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("view did appear")
        
        billField.becomeFirstResponder()
        let defaults = UserDefaults.standard
        let defaultTipIndex = defaults.integer(forKey: "defaultTipIndex")
        tipControl.selectedSegmentIndex = defaultTipIndex
        
        let stateTax = defaults.double(forKey: "stateTax") * 100
        //print(stateTax)
        taxPercentLabel.text = String(format: "%.2f", stateTax)
        stateLabel.text = defaults.string(forKey: "state")
        calculateTipHelper()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //print("view did disappear")
    }
    

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        calculateTipHelper()    }
    
    func calculateTipHelper() {
        let tipPercentages = [0.15, 0.18, 0.2, 0.25, 0.3]
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let taxPercent = Double(taxPercentLabel.text!) ?? 0
        //print("taxPercent ", taxPercent)
        
        let defaults = UserDefaults.standard
        //let taxTotalSetting = defaults.double(forKey: "customTax")
        //print("t", taxTotalSetting)
        
        var taxTotal = bill * taxPercent / 100.0
        
       // if(taxTotalSetting > 0) {
         //   taxPercentLabel.text = String(format: "%.2f", taxTotalSetting * 100.0 / bill)
         //   taxTotalLabel.text = String(format: "$%.2f", taxTotalSetting)
           // stateLabel.text = "Customized Tax"
         //   taxTotal = taxTotalSetting
            
      //  }
        let total = bill + taxTotal + tip
        
        //taxTotalLabel.text = String(format: "$%.2f", taxTotal)
        taxTotalLabel.text = formatter.string(from: taxTotal as NSNumber)
        
        //tipLabel.text = "$\(tip)"
        //tipLabel.text = String(format: "$%.2f", tip)
        tipLabel.text = formatter.string(from: tip as NSNumber)
        
        //totalLabel.text = "$\(total)"
        //totalLabel.text = String(format: "$%.2f", total)
        totalLabel.text = formatter.string(from: total as NSNumber)
        
    }

    @IBAction func savePersonBtn(_ sender: Any) {
        let name = nameTextField.text
        let total = totalLabel.text

        if let name = name, name != "" {
            savePerson(name: name, total: total)
            navigationController?.popViewController(animated: true)
        } else {
            let detailAlert = UIAlertController(title: "Message", message: "You must enter a value for all fields." , preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            detailAlert.addAction(OKAction)
            present(detailAlert, animated: true, completion:nil)
        }
    }

    private func savePerson(name: String, total: String?) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity =  NSEntityDescription.entity(forEntityName: "PersonDetails", in: managedContext)
        let detailEntry = NSManagedObject(entity: entity!, insertInto: managedContext)

        detailEntry.setValue(name, forKey: "name")
        detailEntry.setValue(total, forKey: "total")

        do {
            try managedContext.save()
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    // override function that resigns the name and city keyboards when either background or return is pressed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        billField.resignFirstResponder()
    }
}

//extension contains keyboard actions implemented to simulation
extension TipViewController : UITextFieldDelegate {
    //when tapping textfield it becomes first responder
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

