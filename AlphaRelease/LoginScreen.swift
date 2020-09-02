import UIKit
import Firebase

class LoginScreen: UIViewController {
    
    var ref: DatabaseReference!

    @IBOutlet weak var user_name: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var lblMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login Screen"
        ref = Database.database().reference()
        ref.child("people").observeSingleEvent(of: .value, with: { (snapshot) in
            let entryUser = snapshot.value as? NSDictionary
            self.firebase = entryUser
        }) {(error) in
            print(error.localizedDescription)
        }
    }
    
    var firebase:NSDictionary?
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        
        Config.setUserNme(user_name.text!)
        Config.setPassWrd(password.text!)
        
        let usernme = user_name.text!
        let pass = password.text!
        
        if usernme != "" && pass != ""{
            lblMsg.text = "Invalid Log In"
        }
        else {
            let detailAlert = UIAlertController(title: "Message", message: "You must enter a value for all fields." , preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            detailAlert.addAction(OKAction)
            present(detailAlert, animated: true, completion:nil)
        }
        
    }
    
    var flag = false
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "cellid" {
            
        //check if name matches
        let usernme = user_name.text!
        let pass = password.text!
        
        if usernme != "" && pass != ""{
            self.flag = false
            // fetch the info from firebase using usrname as the key
            if let dict = self.firebase {
                print("in-------------------------------------------------")
                if let subdict = dict[usernme] as? NSDictionary {
                    let password = subdict["password"] as! String
                    print(password)
                    print(pass)
                    if password == pass {
                        return true
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            }
        }
        else {
            return false
            }
    return false
        }
        if identifier == "signid" {
            return true
        }
        else {
            return false
        }
    
    }
    
    // override function that resigns the name and city keyboards when either background or return is pressed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        user_name.resignFirstResponder()
        password.resignFirstResponder()
    }
}

//extension contains keyboard actions implemented to simulation
extension LoginScreen : UITextFieldDelegate {

    //when tapping textfield it becomes first responder
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
