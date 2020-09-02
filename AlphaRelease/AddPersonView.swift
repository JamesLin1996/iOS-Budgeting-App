import UIKit
import CoreData

class AddPersonView: UIViewController {
    var personDetails : [NSManagedObject] = []

    override func viewDidLoad() {
        self.title = "Add Person"
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
