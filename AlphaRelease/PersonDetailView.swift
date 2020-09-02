import UIKit
import CoreData

class PersonDetailView: UIViewController {
    var detailEntry: NSManagedObject?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var owedLabel: UILabel!
    @IBOutlet weak var dateEntryLabel: UILabel!
    
    override func viewDidLoad() {
        self.title = "Person Detail"
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameLabel.text = detailEntry?.value(forKey: "personName2") as! String?
        restLabel.text = detailEntry?.value(forKey: "restaurant2") as! String?
        let tempCost2 = detailEntry?.value(forKey: "owed2") as! Float
        owedLabel.text = String(format:"%.2f", tempCost2)
        dateEntryLabel.text = detailEntry?.value(forKey: "date2") as! String?
    }
    
}
