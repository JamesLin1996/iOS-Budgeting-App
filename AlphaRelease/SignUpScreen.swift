import UIKit
import Firebase

class SignUpScreen: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        userNameField.delegate = self
        confirmField.delegate = self
        passwordField.delegate = self
        emailField2.delegate = self
        super.viewDidLoad()
    }
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var confirmField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField2: UITextField!
    @IBOutlet weak var dynamicLabel2: UILabel!
    
    @IBAction func signUpButton(_ sender: Any) {
        let userNameFieldText = userNameField.text!
        let confirmFieldText = confirmField.text!
        let passwordFieldText = passwordField.text!
        let emailField2Text = emailField2.text!
        if passwordFieldText == confirmFieldText && emailField2Text != "" && passwordFieldText != "" && emailField2Text != "" && confirmFieldText != "" && userNameFieldText != "" {
            dynamicLabel2.text = "Sign up successful!"
        } else {
            dynamicLabel2.text = "Invalid input, retry."
        }
        
    }

//    @IBOutlet weak var createAccountAction: UIButton!
    
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        //check if name matches
//        let usernme = userNameField.text!
//        let pass = passwordField.text!

        if identifier == "cellid"
        {
            
        let id = userNameField.text!
        let pass = passwordField.text!
        
        let personInfo = [
            "password": passwordField.text,
            "email": emailField2.text,
            "confirmpass": confirmField.text
        ]

        if id != "" && pass != ""{
            let ref = Database.database().reference()

            print("ref")
            ref.child("people").child(id).setValue(personInfo)
            return true
        }
        }
        else {
            return false
        }
    //return false
        if identifier == "logid" {
            return true
            }
    return false
    }
        // return true
        //copy code from slide
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // override function that resigns the name and city keyboards when either background or return is pressed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailField2.resignFirstResponder()
        userNameField.resignFirstResponder()
        confirmField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
}


