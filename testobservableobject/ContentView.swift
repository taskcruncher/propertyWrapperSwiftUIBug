//
//  ContentView.swift
//  testobservableobject
//
//  Created by Steedman Bass on 11/22/19.
//  Copyright © 2019 Steedman Bass. All rights reserved.
//

import SwiftUI
import Combine
//https://www.avanderlee.com/swift/property-wrappers/

@propertyWrapper
struct PersistInUserDefaults<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}


class AppleUser: ObservableObject {
    
    static var shared = AppleUser()
    
    let subject = PassthroughSubject<String, Never>()
    
    @PersistInUserDefaults(key: "appleID", defaultValue: "") var appleID: String {willSet {
        
        subject.send(newValue)
        }}
}


struct ContentView: View {
    
    @ObservedObject var appleUser: AppleUser
    
    var body: some View {
        
        return VStack {
            Text(appleUser.appleID)
            
        }.onAppear{
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                         self.appleUser.appleID = "Leonard"
                     }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.appleUser.appleID = "Bill"
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                          self.appleUser.appleID = ""
                      }
            
        }
    }

}

