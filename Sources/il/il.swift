import ArgumentParser
import Foundation
import AppKit

@available(macOS 12.0, *)
@main
struct il: ParsableCommand {
    @Argument(help: "text to log")
    var log_text: String = "Empty Log "
    
    @Argument(help: "log name")
    var name: String
    
    @Option(help: "multiple logs saving.")
    var savmult: Int = 1
    
    @Flag(help: "copy log's data?")
    var copy: Bool = false
    
    var date = "\(Date.now)"
    
    mutating func run() {
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        var fileURL = documentsDir.appendingPathComponent("\(name)-\(date).log")
        let text = "\(date) : \(log_text)"
        
        guard let data = text.data(using: .utf8) else { return }
        
        do {
            if savmult > 1 {
                for i in 1...savmult {
                    fileURL = documentsDir.appendingPathComponent("\(name)-\(date)-\(i).log")
                    try data.write(to: fileURL)
                }
                print("Succsesfully saved \(savmult) logs into the docs dir.")
                print("Danketsu Studio©, 2026")
            } else if savmult < 1 {
                print("Errm... You're not able to save less than 1 log, sorry.")
            } else {
                try data.write(to: fileURL)
                print("Succsesfully saved into the docs dir.")
                print("Danketsu Studio©, 2026")
            }
        } catch {
            print("Error while saving a file")
        }
        
        if copy {
            let pasteboard = NSPasteboard.general
            pasteboard.clearContents()
            pasteboard.setString(log_text, forType: .string)
        }
    }
}
