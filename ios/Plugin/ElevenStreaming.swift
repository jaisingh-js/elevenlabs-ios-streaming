import Foundation
import AVFoundation
//import AudioStreaming

@objc public class ElevenStreaming: NSObject {
//    var player = AudioPlayer()
    var queuePlayer = AVQueuePlayer()
//    var audioEngine = AVAudioEngine()
//    var audioBuffer: AVAudioPCMBuffer?
//    var audioFilePlayer = AVAudioPlayerNode()
    
    //    @objc public func echo(_ value: String) -> String {
    //        print(value)
    //        return value
    //    }
    
    @objc public func initStream() {
        return
    }
    
    
    @objc public func stop() {
        queuePlayer.pause()
        queuePlayer.removeAllItems()
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
            let wavData = self.wavValue(pcmData: data)
            let tempDir = FileManager.default.temporaryDirectory
            let filename = ProcessInfo().globallyUniqueString + ".wav"
            let tempUrl = tempDir.appendingPathComponent(filename)
            do {
                try wavData?.write(to: tempUrl)
                let playerItem = AVPlayerItem(url: tempUrl)
                queuePlayer.insert(playerItem, after: nil)
                queuePlayer.play()
//                player.queue(url: tempUrl)
            }
            catch {
                print("error playing wav chunk")
            }
        }
        return
    }
    
    func wavValue(pcmData: Data) -> Data? {
            var numChannels: CShort = 1
            let numChannelsInt: CInt = 1
            var bitsPerSample: CShort = 16
            let bitsPerSampleInt: CInt = 16
            var samplingRate: CInt = 44100
            let numOfSamples = CInt(pcmData.count)
            var byteRate = numChannelsInt * bitsPerSampleInt * samplingRate / 8
            var blockAlign = numChannelsInt * bitsPerSampleInt / 8
            var dataSize = numChannelsInt * numOfSamples * bitsPerSampleInt / 8
            var chunkSize: CInt = 16
            var totalSize = 46 + dataSize
            var audioFormat: CShort = 1

            let wavNSData = NSMutableData()
            wavNSData.append("RIFF".cString(using: .ascii) ?? .init(), length: MemoryLayout<CChar>.size * 4)
            wavNSData.append(&totalSize, length: MemoryLayout<CInt>.size)
            wavNSData.append("WAVE".cString(using: .ascii) ?? .init(), length: MemoryLayout<CChar>.size * 4)
            wavNSData.append("fmt ".cString(using: .ascii) ?? .init(), length: MemoryLayout<CChar>.size * 4)
            wavNSData.append(&chunkSize, length: MemoryLayout<CInt>.size)
            wavNSData.append(&audioFormat, length: MemoryLayout<CShort>.size)
            wavNSData.append(&numChannels, length: MemoryLayout<CShort>.size)
            wavNSData.append(&samplingRate, length: MemoryLayout<CInt>.size)
            wavNSData.append(&byteRate, length: MemoryLayout<CInt>.size)
            wavNSData.append(&blockAlign, length: MemoryLayout<CShort>.size)
            wavNSData.append(&bitsPerSample, length: MemoryLayout<CShort>.size)
            wavNSData.append("data".cString(using: .ascii) ?? .init(), length: MemoryLayout<CChar>.size * 4)
            wavNSData.append(&dataSize, length: MemoryLayout<CInt>.size)

            wavNSData.append(pcmData)

            let wavData = Data(referencing: wavNSData)

            return wavData
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
    
//    public func playPcmBuffer(_ value: String) {
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
//            try AVAudioSession.sharedInstance().setActive(true)
//        }
//        catch {
//            print("audio engine could not be set")
//        }
//        if let data = Data(base64Encoded: value) {
////            let tempDir = FileManager.default.temporaryDirectory
////            let filename = ProcessInfo().globallyUniqueString
////            let tempUrl = tempDir.appendingPathComponent(filename)
//            do {
////                try data.write(to: tempUrl)
////                let audioFile = try AVAudioFile(forReading: tempUrl)
////                print(audioFile.processingFormat)
////                guard let audioFormat = AVAudioFormat(commonFormat: AVAudioCommonFormat.pcmFormatInt16, sampleRate: 44100.0, channels: 1, interleaved: false) else {
////                    return
////                }
////                let audioFrameCount = UInt32(data.count/2)
////                
////                guard let audioFileBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: audioFrameCount) else {
////                    return
////                }
//////                audioFileBuffer.frameLength = audioFrameCount
////                
////                guard let int16channel = audioFileBuffer.int16ChannelData else {
////                    return
////                }
////                
////                let copied = data.copyBytes(to: UnsafeMutableBufferPointer(start: int16channel[0], count: data.count/2))
//                let audioFormat = AVAudioFormat(commonFormat: .pcmFormatInt16, sampleRate: 44100.0, channels: 1, interleaved: false)
//                let audioBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat!, frameCapacity: AVAudioFrameCount(data.count / 2)) // Assuming 16-bit samples (2 bytes per sample)
//                audioBuffer!.frameLength = AVAudioFrameCount(data.count / 2)
//                data.copyBytes(to: UnsafeMutableBufferPointer(start: audioBuffer!.int16ChannelData![0], count: data.count / 2))
//
//
//
//
//
//
//                let mainMixer = audioEngine.mainMixerNode
//                audioEngine.attach(audioFilePlayer)
//                audioEngine.connect(audioFilePlayer, to:mainMixer, format: audioFormat)
//                
//                try audioEngine.start()
//                audioFilePlayer.play()
//                audioFilePlayer.scheduleBuffer(audioBuffer!, at: nil, options: [], completionHandler: {})
//                
////                guard let audioFormat = AVAudioFormat(commonFormat: .pcmFormatInt16, sampleRate: 44100, channels: 1, interleaved: false) else {
////                    return
////                }
////                let frameCount = AVAudioFrameCount(data.count/2)
////                
////                guard let audioBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: frameCount) else {
////                    return
////                }
////                
////                data.copyBytes(to: UnsafeMutableRawBufferPointer(audioBuffer), count: frameCount)
////                
////                let mainMixer = audioEngine.mainMixerNode
////                audioEngine.attach(audioFilePlayer)
////                audioEngine.connect(audioFilePlayer, to:mainMixer, format: audioFormat)
////
////                try audioEngine.start()
////                audioFilePlayer.play()
////                audioFilePlayer.scheduleBuffer(audioBuffer, at: nil, options: [], completionHandler: {})
//            }
//                
//                catch {
//                    print("error playing pcm chunk")
//                }
//            
//            }
//        
//        
//            return
//        }
        
    
}
