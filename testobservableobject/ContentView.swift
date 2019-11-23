//
//  ContentView.swift
//  testobservableobject
//
//  Created by Steedman Bass on 11/22/19.
//  Copyright © 2019 Steedman Bass. All rights reserved.
//

import SwiftUI
import Combine


@propertyWrapper
struct PersistInUserDefaults<T> {
  let key: String
 
    var wrappedValue: T? {
    get {
        return UserDefaults.standard.object(forKey: key) as? T
    }
    set {
      UserDefaults.standard.set(newValue, forKey: key)
    }
  }
}




class AppleUser: ObservableObject {
    
    static var shared = AppleUser()
    let subject = PassthroughSubject<String?, Never>()
    @PersistInUserDefaults(key: "appleID") var appleID: String? {willSet {
        
        
        subject.send(newValue)
        }}
}

struct InfoLineItem: Hashable, Identifiable {
   var id: UUID = UUID()
   
   let label: String
   let value: String?
   let noValueMessage: String
}

struct AppInfoLineItem: Hashable {
   
   var id: UUID = UUID()
   
   
   
   var appleUserID: InfoLineItem = {
       
       let label = "Apple user id: "
    let value =  AppleUser.shared.appleID
       let noValueMessage = "No Apple user in keychain"
       return InfoLineItem(label: label, value: value, noValueMessage: noValueMessage)
   }()
}



struct ContentView: View {
    
//    @ObservedObject var au = AppleUser.shared
    @ObservedObject var appleUser: AppleUser

   let infoLineItem = AppInfoLineItem()

    
    var body: some View {
        
        return VStack {
            Text(appleUser.appleID!)
            
//             if infoLineItem.appleUserID.value != nil { Text(infoLineItem.appleUserID.value!)} else { Text(infoLineItem.appleUserID.noValueMessage)}
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.appleUser.appleID = "bill"
                        }
            
            
        }
 
    }
    
    
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
