import UIKit
import Firebase

class ForgotPasswordScreen: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
    }
    
    // my connections
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var dynamicLabel: UILabel!
    
    // email validity check will be done in Beta Release, in which we will implement firebase
    @IBAction func ResetPasswordButton(_ sender: Any) {
        let emailFieldText = emailField.text!
        if emailFieldText != "" {
            dynamicLabel.text = "Password has been reset, check your email!"
        } else {
            dynamicLabel.text = "You must enter an email address!"
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // override function that resigns the name and city keyboards when either background or return is pressed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailField.resignFirstResponder()
    }
}

//extension contains keyboard actions implemented to simulation
extension ForgotPasswordScreen : UITextFieldDelegate {
    
    //when tapping textfield it becomes first responder
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
