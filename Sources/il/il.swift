import ArgumentParser
import Foundation

@available(macOS 12.0, *)
@main
struct il: ParsableCommand {
    @Argument(help: "text to log")
    var log_text: String = "Empty Log "
    
    @Argument(help: "log name")
    var name: String
    
    var date = "\(Date.now)"
    
    mutating func run() {
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsDir.appendingPathComponent("\(name).log")
        let text = "\(date) : \(log_text)"
        
        guard let data = text.data(using: .utf8) else { return }
        
        do {
            try data.write(to: fileURL)
            print("Succsesfully saved into the docs dir.")
            print("Danketsu Studio©, 2026")
        } catch {
            print("Error while saving a file")
        }
    }
}
