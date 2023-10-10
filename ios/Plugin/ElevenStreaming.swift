import Foundation
import AVFoundation
import AudioStreaming

@objc public class ElevenStreaming: NSObject {
    var player = AudioPlayer()
    
//    @objc public func echo(_ value: String) -> String {
//        print(value)
//        return value
//    }
    
    @objc public func initStream() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch {
            
        }
        return
    }
    
    
    @objc public func stop() {
        player.stop()
        flushBuffer()
        return
    }
    
    
    @objc public func playChunk(_ value: String) {
        if let data = Data(base64Encoded: value) {
            print(data)
            let tempDir = FileManager.default.temporaryDirectory
            let filename = ProcessInfo().globallyUniqueString + ".mp3"
            let tempUrl = tempDir.appendingPathComponent(filename)
            do {
                try data.write(to: tempUrl)
                player.queue(url: tempUrl)
            }
            catch {
            }
        }
        return
    }
    
    @objc public func flushBuffer() {
        let tempDir = FileManager.default.temporaryDirectory
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: tempDir, includingPropertiesForKeys: nil)
            
            for itemUrl in contents {
                try FileManager.default.removeItem(at: itemUrl)
            }
        }
        catch {
            
        }
        return
    }
    
}
