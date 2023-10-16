import Foundation
import AVFoundation
import AudioStreaming

@objc public class ElevenStreaming: NSObject {
    var player = AudioPlayer()
    var audioEngine = AudioEngine()
    var audioBuffer: AVAudioPCMBuffer
    
//    @objc public func echo(_ value: String) -> String {
//        print(value)
//        return value
//    }
    
    @objc public func initStream() {
        
        return
    }
    
    
    @objc public func stop() {
        player.stop()
        flushBuffer()
        return
    }
    
    
    @objc public func playChunk(_ value: String) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch {
            print("audio engine could not be set")
        }
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
                print("error playing mp3 chunk")
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

    public playPcmBuffer(_ value: String) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch {
            print("audio engine could not be set")
        }
        if let data = Data(base64Encoded: value) {
            let tempDir = FileManager.default.temporaryDirectory
            let filename = ProcessInfo().globallyUniqueString
            let tempUrl = tempDir.appendingPathComponent(filename)
            do {
                try data.write(to: tempUrl)
                let audioFile = try AVAudioFile(forReading: tempUrl)

                let audioFormat = audioFile.processingFormat
                let audioFrameCount = UInt32(audioFile.length)

                let audioFileBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: audioFrameCount)

                try audioFile.read(into: audioFileBuffer!, frameCount: audioFrameCount)

                let mainMixer = audioEngine.mainMixerNode
                audioEngine.attach(audioFilePlayer)
                audioEngine.connect(audioFilePlayer, to:mainMixer, format: audioFileBuffer?.format)

                try audioEngine.start()
                audioFilePlayer.play()
                audioFilePlayer.scheduleBuffer(audioFileBuffer!, at: nil, options: [], completionHandler: {})

            catch {
                print("error playing pcm chunk")
            }
        }
        return
    }
    
}
