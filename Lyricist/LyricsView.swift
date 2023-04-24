//
//  LyricsView.swift
//  Lyricist
//
//  Created by Sean Hong on 2023/04/20.
//

import SwiftUI
import MelonLyrics

struct LyricsView: View {
    @StateObject private var service = MelonLyrics()
    @State var artist: String?
    @State var title: String?
    
    var body: some View {
        VStack {
            Button("Request Lyrics") {
                currentlyPlaying()
            }
            VStack {
                Text(title ?? "Title").font(.headline)
                Text(artist ?? "Artist").font(.caption)
            }
            Divider()
            ScrollView {
                Text(service.lyrics)
            }
        }
        .padding([.top, .leading, .trailing])
    }
    
    // MARK: Receiving title and artist information of current music
    public func currentlyPlaying() {
        // Load framework
        let bundle = CFBundleCreate(kCFAllocatorDefault, NSURL(fileURLWithPath: "/System/Library/PrivateFrameworks/MediaRemote.framework"))
        
        // Get a Swift function for MRMediaRemoteGetNowPlayingInfo
        guard let MRMediaRemoteGetNowPlayingInfoPointer = CFBundleGetFunctionPointerForName(bundle, "MRMediaRemoteGetNowPlayingInfo" as CFString) else { return }
        typealias MRMediaRemoteGetNowPlayingInfoFunction = @convention(c) (DispatchQueue, @escaping ([String: Any]) -> Void) -> Void
        let MRMediaRemoteGetNowPlayingInfo = unsafeBitCast(MRMediaRemoteGetNowPlayingInfoPointer, to: MRMediaRemoteGetNowPlayingInfoFunction.self)
        
        // Get a Swift function for MRNowPlayingClientGetBundleIdentifier
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
            print("CHANGED")
            service.fetch(title: title ?? "", artist: artist ?? "")
            print(service.lyrics)
        })
    }
}

struct LyricsView_Previews: PreviewProvider {
    static var previews: some View {
        LyricsView()
    }
}
