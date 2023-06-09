//
//  LyricistApp.swift
//  Lyricist
//
//  Created by Sean Hong on 2023/04/20.
//

import SwiftUI

@main
struct LyricistApp: App {
    var body: some Scene {
        MenuBarExtra("Lyricist", systemImage: "music.note.tv.fill") {
            ContentView()
        }.menuBarExtraStyle(.window)
    }
}
