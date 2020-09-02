import Foundation


class Config: NSObject {
    // Define keys for the values to store
    fileprivate static let kUserNKey = "username"
    fileprivate static let kPassKey = "password"
    
    class func setUserNme(_ userN:String) {
        UserDefaults.standard.set(userN, forKey: kUserNKey)
        UserDefaults.standard.synchronize()
    }
    class func setPassWrd(_ passW:String) {
        UserDefaults.standard.set(passW, forKey: kPassKey)
        UserDefaults.standard.synchronize()
    }
    
    class func userN() -> String {
        return UserDefaults.standard.string(forKey: kUserNKey) as! String
    }
    class func passW() -> String {
        return UserDefaults.standard.object(forKey: kPassKey) as! String
    }
}
