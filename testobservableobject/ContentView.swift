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

           struct PersistInUserDefaults_Wrapper {
             @PersistInUserDefaults(key: "appleID", defaultValue: "") var value
           }

           class AppleUser: ObservableObject {
               static var shared = AppleUser()
               @Published var appleID = PersistInUserDefaults_Wrapper()
           }

           struct ContentMMMMSSSView: View {

               @ObservedObject var appleUser: AppleUser

               var body: some View {

                   return VStack {
                       Text(appleUser.appleID.value)

                   }.onAppear{

                       DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                           self.appleUser.appleID.value = "Leonard"
                                }


                       DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                           self.appleUser.appleID.value = "Bill"
                       }//

                       DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                           self.appleUser.appleID.value  = ""
                                 }

                   }
               }

           }


struct ContentView: View {
    
    @ObservedObject var appleUser: AppleUser
    
    var body: some View {
        
        return VStack {
            Text(appleUser.appleID.value)
            
        }.onAppear{
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.appleUser.appleID.value = "Leonard"
                     }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.appleUser.appleID.value = "Bill"
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                self.appleUser.appleID.value = ""
                      }
            
        }
    }

}

