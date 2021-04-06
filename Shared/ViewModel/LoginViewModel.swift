//
//  LoginViewModel.swift
//  MacEmailAuth
//
//  Created by Michele Manniello on 06/04/21.
//

import SwiftUI
import Firebase

class LoginViewModel: ObservableObject {
//    Login properties...
    @Published var userName = ""
    @Published var password = ""
//    Proprietà di registrazione
    @Published var isNewUser = false
    @Published var registerUsername = ""
    @Published var resisterPassword = ""
    @Published var reEnterPassword = ""
//    Loading Screen
    @Published var isLoading = false
//    Error
    @Published var errorMsg = ""
    @Published var error = false
//    log Status
    @AppStorage("log_Status") var status = false
    
    func loginUser(){
//        Loading Screen
        withAnimation{
            isLoading = true
        }
//        loggin in User
        Auth.auth().signIn(withEmail: userName, password: password) { [self] (result, err) in
            if let error = err {
//                Promoting Error...
                errorMsg = error.localizedDescription
                self.error.toggle()
                return
            }
            guard let _ = result else{
                errorMsg = "Please try again Later !!!"
                error.toggle()
                return
            }
//            Success
            print("Success")
            withAnimation { status = true
            }
            
        }
    }
    func resetPassword(){
        withAnimation{isLoading = true}
        Auth.auth().sendPasswordReset(withEmail: userName) { [self](err) in
            if let error = err {
//                Promoting Error...
                errorMsg = error.localizedDescription
                self.error.toggle()
                return
            }
            //                Promoting User Success Msg...
                            errorMsg = "Reset Link  Successfully !!!"
                            error.toggle()
            
        }
        
    }
    func registerUser(){
//        Checking Password Match
        if reEnterPassword == resisterPassword{
            withAnimation{isLoading = true}
            Auth.auth().createUser(withEmail: registerUsername, password: reEnterPassword) { [self] (result, err) in
                if let error = err {
                    //                Promoting Error...
                    errorMsg = error.localizedDescription
                    self.error.toggle()
                    return
                }
                guard let _ = result else{
                    errorMsg = "Please try again Later !!!"
                    error.toggle()
                    return
                }
//            Success.....
                print("Success")
//                Promoting User Success Msg...
                errorMsg = "Account Created Successfully !!!"
                error.toggle()
//                promoting User back....
                withAnimation{isNewUser = false}
                withAnimation{isLoading = false}
                
            }
        }else{
            errorMsg = "Password Mismatch"
            error.toggle()
        }
        
    }
}

