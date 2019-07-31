//
//  ViewController.swift
//  NamedPipe
//
//  Created by Yuki Okubo on 7/31/19.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func writePipe(_ sender: Any) {
        let data = "俺はジャイアンガキ大将"
        let pipe = NSURL.fileURL(withPathComponents: [NSTemporaryDirectory(), NSUUID().uuidString])!.path
        print("pipe path: \(pipe)")
        mkfifo(pipe, 0600)

        do {
            try data.write(toFile: pipe, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            fatalError()
        }

        let child = Process()
        child.launchPath = Bundle.main.url(forAuxiliaryExecutable: "receiver")!.path
        child.arguments = ["-p", pipe]
        child.launch()
    }

}

