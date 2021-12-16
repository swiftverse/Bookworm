//
//  DataController.swift
//  Bookworm
//
//  Created by Amit Shrivastava on 14/12/21.
//

import Foundation
import SwiftUI
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init(){
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load \(error.localizedDescription)")
            }
        }
    }
}
