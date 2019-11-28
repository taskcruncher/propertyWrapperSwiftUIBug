//
//  ContentView.swift
//  testobservableobject
//
//  Created by Steedman Bass on 11/22/19.
//  Copyright © 2019 Steedman Bass. All rights reserved.
//

import SwiftUI
import Combine



class AppleUser: ObservableObject {
    
    static var shared = AppleUser()
    
    
    @Published var appleID: String = UserDefaults.standard.object(forKey: "appleID") as? String ?? "Blank" {willSet {
        
        UserDefaults.standard.set(newValue, forKey: "appleID")
        }
        
    }
}


struct ContentView: View {
    
    @ObservedObject var appleUser: AppleUser
    
    var body: some View {
        
        return VStack {
            Text(appleUser.appleID)
            
        }.onAppear{
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                         self.appleUser.appleID = "Leonard"
                     }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.appleUser.appleID = "Bill"
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                          self.appleUser.appleID = "Blank"
                      }
            
        }
    }

}

