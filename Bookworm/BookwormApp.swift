//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Amit Shrivastava on 14/12/21.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            Bookworm()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
