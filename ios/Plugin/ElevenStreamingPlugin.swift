import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(ElevenStreamingPlugin)
public class ElevenStreamingPlugin: CAPPlugin {
    private let implementation = ElevenStreaming()

//    @objc func echo(_ call: CAPPluginCall) {
//        let value = call.getString("value") ?? ""
//        call.resolve([
//            "value": implementation.echo(value)
//        ])
//    }

    @objc func initStream(_ call: CAPPluginCall) {
        call.resolve([
            "value": "init"
        ])
    }
    
//    @objc func play(_ call: CAPPluginCall) {
//        call.resolve([
//            "value": "play"
//        ])
//    }
    
    @objc func stop(_ call: CAPPluginCall) {
        implementation.stop()
        call.resolve([
            "value": "pause"
        ])
    }
    
//    @objc func createBuffer(_ call: CAPPluginCall) {
//        call.resolve([
//            "value": "create buffer"
//        ])
//    }
    
    @objc func playChunk(_ call: CAPPluginCall) {
        if let value = call.getString("buffer") {
//            print(value)
            implementation.playChunk(value)
        }
        
        call.resolve([
            "value": "chunk added to queue"
        ])
    }
    
    @objc func flushBuffer(_ call: CAPPluginCall) {
        implementation.flushBuffer()
        call.resolve([
            "value": "flushed buffer successfully ss"
        ])
    }
}
