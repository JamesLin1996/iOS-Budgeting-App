import UIKit
import CoreData

class ReceiptTableView: UITableViewController //UISearchResultsUpdating {
{
    var receipt = [NSManagedObject]()
    //    var searchController : UISearchController!
    //    var resultsController = UITableViewController()
    
    override func viewDidLoad() {
        self.title = "Receipts"
        super.viewDidLoad()
        //        self.searchController  = UISearchController(searchResultsController: self.resultsController)
        //        self.tableView.tableHeaderView = self.searchController.searchBar
        // self.searchController.searchResultsUpdater = self
    }
    
    //    // filters through tableview, then updates the results in tableview
    //    func updateSearchResults(for searchController: UISearchController) {
    //        self.receipt.filter { (item: String) -> Bool in
    //            return true
    //        }
    //    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        populateData1()
    }
    
    private func populateData1() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Receipt")
        
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        if let results = fetchedResults {
            receipt = results
            tableView.reloadData()
        } else {
            print("Could not fetch")
        }
    }
    
    // number of sections is indicated here
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.receipt.count
    }
    
    //function designed to populate name and party data in the TableView rtghrthrth
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell1", for: indexPath)
        let entry = receipt[indexPath.row]
        
        // Configuring the cell...
        let item: String = (entry.value(forKey: "item") as? String)!
        let source: String = (entry.value(forKey: "source") as? String)!
        let date: String = (entry.value(forKey: "date") as? String)!
        cell.textLabel?.text = source
        
        let cost: Float = (entry.value(forKey: "cost") as? Float)!
        
        cell.detailTextLabel?.text = date
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            deleteReceipt(receipt: self.receipt[indexPath.row])
            populateData1()
        }
    }
    
    private func deleteReceipt(receipt: NSManagedObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(receipt)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // function prepares data that will be passed to the detailViewController, allows for correct segueing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDetail1" {
            let dsvc = segue.destination as! ReceiptView
            let selectedIndex = tableView.indexPathForSelectedRow!
            dsvc.entry = receipt[(selectedIndex.row)]
        }
        // implementing back button
        let back = UIBarButtonItem()
        back.title = "Back"
        navigationItem.backBarButtonItem = back
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
