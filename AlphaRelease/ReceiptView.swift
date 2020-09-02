import UIKit
import CoreData

class ReceiptView: UIViewController {
    var entry: NSManagedObject?
    
    // labels are connected from storyboard
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        self.title = "Receipt Details"
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        itemLabel.text = entry?.value(forKey: "item") as! String?
        sourceLabel.text = entry?.value(forKey: "source") as! String?
        dateLabel.text = entry?.value(forKey: "date") as! String?
        let tempCost1 = entry?.value(forKey: "cost")! as! Float
        amountLabel.text = String(format:"%.2f", tempCost1)
    }

}
