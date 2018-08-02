//
//  DataStore.swift
//  nkoodi
//
//  Created by Michael Attia on 8/2/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class DataStore {
    var ref: DatabaseReference
    
    private(set) static var shared = DataStore()
    
    private init() {
        ref = Database.database().reference()
    }
    
    func initUser(_ user: User,completion: @escaping (Bool)->()){
        ref.child("users").child(user.id).setValue(user.fireBaseDict) { (err, _) in
            completion(err == nil)
        }
    }
    
    func getUserData(completion: @escaping (User?)->()){
        if let userId = Auth.auth().currentUser?.uid{
            ref.child("users").child(userId).observeSingleEvent(of: .value, with: {snapShot in
                guard let userData = snapShot.value as? NSDictionary else {
                    completion(nil)
                    return
                }
                
                guard let user = User(dict: userData, id: userId) else{
                    completion(nil)
                    return
                }
                
                completion(user)
                
            })
        }
    }
    
    func getTransactionsHistory(completion: (TransactionsHistory?) -> ()){
        //To be implemented
    }
    
    func getUserNameWithQR(_ qr: String, completion: @escaping (User?)->()){
        ref.child("users").observeSingleEvent(of: .value, with: { snapShot in
            guard let users = snapShot.value as? NSDictionary,
            let keys = users.allKeys as? [String] else{
                completion(nil)
                return
            }
            
            for key in keys{
                if let userData = users[key] as? NSDictionary,
                    let user = User(dict: userData, id: key),
                user.qr == qr{
                    completion(user)
                    return
                }
            }
            completion(nil)
        })
    }
    
    func transfer(amount: Double, to user: User, completion: (Bool) -> ()){
        var transaction : [AnyHashable : Any] = ["date" : Date().timeIntervalSince1970,
                                          "amount_changed" : amount,
                                          "vendor" : "A friend",
                                          "operation" : "recieved"]
        ref.child("users").child(user.id).child("balance_history").updateChildValues(transaction)
        ref.child("users").child(user.id).child("current_balance").observeSingleEvent(of: .value, with: {snapshot in
            if let oldAmount = snapshot.value as? Double{
                let newAmount = oldAmount + amount
                self.ref.child("users").child(user.id).child("current_balance").setValue(newAmount)
            }
        })
        let userId = Auth.auth().currentUser!.uid
        ref.child("users").child(userId).child("current_balance").observeSingleEvent(of: .value, with: {snapshot in
            if let oldAmount = snapshot.value as? Double{
                let newAmount = oldAmount - amount
                self.ref.child("users").child(userId).child("current_balance").setValue(newAmount)
            }
        })
    }
    
    func beginObservingOpeartions(userId: String){
        
        ref.child("users").child(userId).child("pending_operations").observe(.childAdded, with: {snapShot in
            if var data = snapShot.value as? [AnyHashable : Any]{
                data["opId"] = snapShot.key
                NotificationCenter.default.post(name: NSNotification.Name("new_operation"), object: nil, userInfo: data as? [AnyHashable : Any])
            }
        })
    }
    
    func change(operation opId: String, to status: String){
        if let userId = Auth.auth().currentUser?.uid{
            ref.child("users").child(userId).child("pending_operations").child(opId).child("status").setValue(status)
        }
        
    }
    
    
    
}
