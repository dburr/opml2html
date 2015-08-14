//
//  main.swift
//  opml2html
//
//  Created by Donald Burr on 8/12/15.
//  Copyright (c) 2015 Donald Burr. All rights reserved.
//

import Foundation

var full: Bool = false
var fileName: String?

let cli = CommandLine()

class Handler: NSObject, ParseEngineDelegate {
    var fileName: String?
    let parseEngine = ParseEngine()

    func process(#inFile: String, outFile: String, fullOutput: Bool) {
        parseEngine.delegate = self
        println("Operating on file: \(inFile)")
        print("Saving to file: \(outFile)")
        if (fullOutput) {
            println(" (full mode)")
        } else {
            println()
        }
        self.fileName = outFile
        parseEngine.parse(path: inFile, fullOutput: fullOutput)
    }

    func parseDidSucceed(output: String) {
        if let fileName = fileName {
            output.writeToFile(fileName, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
        } else {
            println(output)
        }
    }
    
    func parseDidFail(error: NSError) {
        println("Parse Failed: \(error)")
    }
}

let handler = Handler()

let filePath = StringOption(shortFlag: "f", longFlag: "input-file", required: true,
    helpMessage: "Path to the input file. (Required)")
let outputFilePath = StringOption(shortFlag: "o", longFlag: "output-file", required: false,
    helpMessage: "Path to the output file. (Optional, default = <filename without extension>.html)")
let fullMode = BoolOption(shortFlag: "l", longFlag: "full-mode",
    helpMessage: "Create full HTML output (including <head>, etc.)")
let help = BoolOption(shortFlag: "h", longFlag: "help",
    helpMessage: "Prints a help message.")

cli.addOptions(filePath, outputFilePath, fullMode, help)

let (success, error) = cli.parse()
if !success {
    println(error!)
    cli.printUsage()
    exit(EX_USAGE)
}

full = fullMode.value

if let fn = filePath.value {
    if let saveFile = outputFilePath.value {
        handler.process(inFile: fn, outFile: saveFile, fullOutput: full)
    } else {
        let saveFile = fn.stringByDeletingPathExtension.stringByAppendingPathExtension("html")!
        handler.process(inFile: fn, outFile: saveFile, fullOutput: full)
    }
} else {
    println("Error: no file name specified")
    exit(1)
}

/*
for argument in Process.arguments {
    switch argument {
    case "--full":
        println("Full mode enabled")
        full = true
        
    default:
        println("an argument: \(argument)")
    }
}
*/