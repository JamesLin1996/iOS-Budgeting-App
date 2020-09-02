import UIKit
import CoreData

class CheckSplitterItems: UITableViewController {
    var personDetails = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Split Check"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        populateData()
    }

    private func populateData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"PersonDetails")
        
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
            personDetails = results.reversed()
            tableView.reloadData()
        } else {
            print("Could not fetch")
        }
    }
    @IBAction func didTapAddPersonButton(_ sender: Any) {
        let tipViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tipViewController") as! TipViewController
        navigationController?.pushViewController(tipViewController, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.personDetails.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let detailEntry = personDetails[indexPath.row]

        // Configure the cell...
        cell.textLabel?.text = detailEntry.value(forKey: "name") as? String
        cell.detailTextLabel?.text = detailEntry.value(forKey: "total") as? String

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            deleteCheck(personDetails: self.personDetails[indexPath.row])
            populateData()
        }
    }
    
    private func deleteCheck(personDetails: NSManagedObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(personDetails)
    }
}
