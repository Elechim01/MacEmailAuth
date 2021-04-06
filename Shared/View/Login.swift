//
//  Login.swift
//  MacEmailAuth (iOS)
//
//  Created by Michele Manniello on 06/04/21.
//

import SwiftUI

struct Login: View {
    @StateObject var loadingData = LoginViewModel()
    var body: some View {
        let width = getRect().width / 1.6

        HStack(spacing: 0){
            VStack(alignment: .leading, spacing: 10, content: {
//               Login View
                Text("Welcome to \nWallpapers")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                if !loadingData.isNewUser{
                    //                Custom TextField
                    CustomTextField(value: $loadingData.userName, hinit: "User Name")
                    CustomTextField(value: $loadingData.password, hinit: "Password")
                    //                Forget Password Button...
                    Button(action: {
                        loadingData.resetPassword()
                    }, label: {
                        Text("Forget Password?")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                    })
                    .disabled(loadingData.userName == "")
                    .opacity(loadingData.userName == "" ? 0.8 : 1)
                    //                Action
                    Button(action: {
                        loadingData.loginUser()
                    }, label: {
                        Text("Login")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    })
                    .padding(.top,10)
                    //                lo disabilito quando non ho dati
                    .disabled(loadingData.userName == "" || loadingData.password == "")
                    .opacity(loadingData.userName == "" || loadingData.password == "" ? 0.6 : 1)
                    Button(action: {
                        withAnimation{
                            //                        Registro Nuovo Utente
                            loadingData.isNewUser.toggle()
                        }
                    }, label: {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    })
                }
                else{
//                    back Button
                    Button(action: {
                        withAnimation {
                            loadingData.isNewUser.toggle()
                        }
                    }, label: {
                        Label(
                            title: {
                                Text("Back")
                                    .fontWeight(.semibold)
                            },
                            icon: {
                                Image(systemName: "chevron.left")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            })
                    })
                    
                    //                Custom TextField
                    CustomTextField(value: $loadingData.registerUsername, hinit: "User Name")
                    CustomTextField(value: $loadingData.resisterPassword, hinit: "Password")
                    CustomTextField(value: $loadingData.reEnterPassword, hinit: "Re-Enter Password")
                    //                Forget Password Button...
                   
                    //                Action
                    Button(action: {
                        loadingData.registerUser()
                    }, label: {
                        Text("Sign up")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    })
                    .padding(.top,10)
                    //                lo disabilito quando non ho dati
                    .disabled(loadingData.registerUsername == "" || loadingData.resisterPassword == "" || loadingData.reEnterPassword == "")
                    .opacity(loadingData.registerUsername == "" || loadingData.resisterPassword == "" || loadingData.reEnterPassword == "" ? 0.6 : 1)
                }
                
            })
            .textFieldStyle(PlainTextFieldStyle())
            .buttonStyle(PlainButtonStyle())
            .padding()
            .padding(.horizontal)
            .offset(y: -50)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .zIndex(1)
//            Since Image is having many problems in SWiftUI
//            it overlay on the view actions .....
            
            
            
//            Image
            Image("pic")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width / 1.6)
                .clipped()
                .zIndex(0)
        }
        .ignoresSafeArea()
        .overlay(ZStack{  if loadingData.isLoading{LoadingScreen()}})
        .frame(width: width, height: getRect().height - 180)
        .alert(isPresented: $loadingData.error, content: {
            Alert(title: Text("Message"), message: Text(loadingData.errorMsg), dismissButton: .destructive(Text("OK"),action: {
                withAnimation {
                    loadingData.isLoading = false
                }
            }))
        })
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
//Extending View to get Screen Rect...
extension View{
    func getRect() -> CGRect {
        return NSScreen.main!.visibleFrame
    }
}

struct CustomTextField: View {
    @Binding var value : String
    var hinit : String
    var body: some View {
        VStack(alignment: .leading, spacing: 6, content: {
            Text(hinit)
                .font(.caption)
                .foregroundColor(.gray)
            ZStack{
                if hinit == "User Name"{
                    TextField(hinit == "User Name" ? "reply.michele@gmail.com" : "********", text: $value)
                }else{
                    SecureField("********", text: $value)
                }
            }
                .padding(.vertical,10)
                .padding(.horizontal)
                .background(Color.white.opacity(0.13))
                .cornerRadius(8)
            .colorScheme(.dark)
        })
    }
}
