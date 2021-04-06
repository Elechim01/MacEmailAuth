//
//  MacEmailAuthApp.swift
//  Shared
//
//  Created by Michele Manniello on 06/04/21.
//

import SwiftUI
import Firebase

@main
struct MacEmailAuthApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
class AppDelegate: NSObject,NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        FirebaseApp.configure()
    }
}
//Eliminare il focus ring dalla textfield
extension NSTextField{
    open override var focusRingType: NSFocusRingType{
        get{.none}
        set{}
    }
}
