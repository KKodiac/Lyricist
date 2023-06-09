//
//  LyricsView.swift
//  Lyricist
//
//  Created by Sean Hong on 2023/04/20.
//

import SwiftUI
import LyricsKit

struct LyricsView: View {
    @StateObject private var service = LyricsKit()
    @State var artist: String?
    @State var title: String? 
    
    var body: some View {
        VStack {
            Text(title ?? "Title").font(.headline)
            Text(artist ?? "Artist").font(.caption)
        }
        .padding(.top)
        Divider()
        List($service.lyrics, id: \.self) { lyric in
            Text(lyric.wrappedValue)
        }
        
        Divider()
        
        HStack {
            Button(action: {
                currentlyPlaying()
            }, label: {
                Text("Request")
                HStack {
                    Image(systemName: "command")
                    Text("+")
                    Image(systemName: "r.square")
                }
                .font(.caption)
            })
            .keyboardShortcut("r")
            .frame(minWidth: 100)
            
            Divider().frame(height: 20)
            
            Button(action: {
                NSApplication.shared.terminate(nil)
            }, label: {
                Text("Quit")
                HStack {
                    Image(systemName: "command")
                    Text("+")
                    Image(systemName: "q.square")
                }
                .font(.caption)
            })
            .keyboardShortcut("q")
            .frame(minWidth: 100)
        }
        .font(.headline)
        .buttonStyle(.plain)
        .padding(.bottom)
    }
    
    // MARK: Receiving title and artist information of current music
    private func currentlyPlaying() {
        let bundle = CFBundleCreate(kCFAllocatorDefault, NSURL(fileURLWithPath: "/System/Library/PrivateFrameworks/MediaRemote.framework"))
        
        guard let MRMediaRemoteGetNowPlayingInfoPointer = CFBundleGetFunctionPointerForName(bundle, "MRMediaRemoteGetNowPlayingInfo" as CFString) else { return }
        typealias MRMediaRemoteGetNowPlayingInfoFunction = @convention(c) (DispatchQueue, @escaping ([String: Any]) -> Void) -> Void
        let MRMediaRemoteGetNowPlayingInfo = unsafeBitCast(MRMediaRemoteGetNowPlayingInfoPointer, to: MRMediaRemoteGetNowPlayingInfoFunction.self)
        
        guard let MRNowPlayingClientGetBundleIdentifierPointer = CFBundleGetFunctionPointerForName(bundle, "MRNowPlayingClientGetBundleIdentifier" as CFString) else { return }
        typealias MRNowPlayingClientGetBundleIdentifierFunction = @convention(c) (AnyObject?) -> String
        _ = unsafeBitCast(MRNowPlayingClientGetBundleIdentifierPointer, to: MRNowPlayingClientGetBundleIdentifierFunction.self)
        
        // Get song info
        MRMediaRemoteGetNowPlayingInfo(DispatchQueue.main, { (information) in
            NSLog("%@", information["kMRMediaRemoteNowPlayingInfoArtist"] as! String)
            NSLog("%@", information["kMRMediaRemoteNowPlayingInfoTitle"] as! String)
            NSLog("%@", information["kMRMediaRemoteNowPlayingInfoAlbum"] as! String)
            let artwork = NSImage(data: information["kMRMediaRemoteNowPlayingInfoArtworkData"] as! Data)
            self.artist = information["kMRMediaRemoteNowPlayingInfoArtist"] as? String
            self.title = information["kMRMediaRemoteNowPlayingInfoTitle"] as? String
            service.fetch(title: title ?? "", artist: artist ?? "")
        })
    }
}

struct LyricsView_Previews: PreviewProvider {
    static var previews: some View {
        LyricsView()
    }
}
