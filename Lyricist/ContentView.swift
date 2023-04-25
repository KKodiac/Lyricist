//
//  ContentView.swift
//  Lyricist
//
//  Created by Sean Hong on 2023/04/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LyricsView()
            .frame(minHeight: 200)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
