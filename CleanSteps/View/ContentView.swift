//
//  ContentView.swift
//  CleanSteps
//
//  Created by Hugh on 3/6/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack {
            Text("Hello World!")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Addiction.self, inMemory: true)
}
