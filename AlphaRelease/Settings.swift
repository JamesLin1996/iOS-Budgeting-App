import UIKit

class Settings: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var budgetPicker: UIPickerView!
    
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipPicker: UIPickerView!

    
    let pickerData = [
        ["10","15","20","25","30","35","40","45","50, you rich"],
        //[]
    ]
    
    let tipPickerData = [
        ["5%","10%","15%","20%","25%","30%", "40%", "50%","60%"],
        //[]
    ]
    
    let sizeComponent = 0
    let sizeComponent2 = 0
    //let toppingComponent = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //assigning to delegate
        budgetPicker.delegate = self
        budgetPicker.dataSource = self
        tipPicker.delegate = self
        tipPicker.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }

    func pickerView(_
        pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int
        ) -> Int {
        return pickerData[component].count
    }
    
    
    func numberOfComponents2(in pickerView: UIPickerView) -> Int {
        return tipPickerData.count
    }
    func pickerView2(_
        pickerView2: UIPickerView,
                    numberOfRowsInComponent component: Int
        ) -> Int {
        return tipPickerData[component].count
    }
    
    //this is similar to table view controller ui cell for row
    func pickerView(_
        pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int
        ) -> String? {
        return pickerData[component][row]

    }
    func pickerView2(_
        pickerView2: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int
        ) -> String? {
        return tipPickerData[component][row]
    }
//this is to select the row
    func pickerView(_
        pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int)
    {
        updateLabel()
    }
    func pickerView2(_
        pickerView2: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int)
    {
        updateLabel2()
    }
    
    //MARK: - Instance Methods
    
    //update the label of the selection
    func updateLabel(){
        let amount = pickerData[sizeComponent][budgetPicker.selectedRow(inComponent: sizeComponent)]
//        let monthamnt = pickerData[toppingComponent][budgetPicker.selectedRow(inComponent: toppingComponent)]
        let tipamount = tipPickerData[sizeComponent2][tipPicker.selectedRow(inComponent: sizeComponent2)]
        budgetLabel.text = "Budget: " + amount + "/week" //amount*4+ monthamnt
        //tipLabel.text = "Tip: " + tipamount + "/receipt" //amount*4+ monthamnt
    }
    
    func updateLabel2(){
        print ("------------------")
        let tipamount = tipPickerData[sizeComponent2][tipPicker.selectedRow(inComponent: sizeComponent2)]
        tipLabel.text = "Tip: " + tipamount + "/receipt" //amount*4+ monthamnt
    }
    
   // implement a "congrats" if they were under budget
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
