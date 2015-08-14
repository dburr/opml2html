//
//  ParseEngine.swift
//  opml2html
//
//  Created by Donald Burr on 8/12/15.
//  Copyright (c) 2015 Donald Burr. All rights reserved.
//

import Foundation

protocol ParseEngineDelegate {
    func parseDidSucceed(output: String)
    func parseDidFail(error: NSError)
}

class ParseEngine : NSObject, NSXMLParserDelegate {
    var parser: NSXMLParser?
    var currentElementText: String = ""
    var level: Int = 0
    var fullOutput: Bool = false
    var parseOutput: String = ""
    var delegate: ParseEngineDelegate?
    var validChars: NSMutableCharacterSet

    override init() {
        self.validChars = NSMutableCharacterSet(charactersInString: " ")
        self.validChars.formUnionWithCharacterSet(NSCharacterSet.URLPathAllowedCharacterSet())
    }
    
    init(delegate: ParseEngineDelegate) {
        self.delegate = delegate
        self.validChars = NSMutableCharacterSet(charactersInString: " ")
        self.validChars.formUnionWithCharacterSet(NSCharacterSet.URLPathAllowedCharacterSet())
    }
    
    private func setup() {

    }
    
    func parse(#path: String, fullOutput: Bool) {
        self.fullOutput = fullOutput
        if !NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let delegate = delegate {
                let userInfo: [String:String] =
                [
                    NSLocalizedDescriptionKey: "Operation was unsuccessful.",
                    NSLocalizedFailureReasonErrorKey: "File does not exist.",
                    NSLocalizedRecoverySuggestionErrorKey: "Check the filename."
                ]

                let error = NSError(domain: "ParseEngineErrorDomain", code: 1, userInfo: userInfo)
                delegate.parseDidFail(error)
            }
            return
        }
        let fileUrl = NSURL(fileURLWithPath: path)
        parser = NSXMLParser(contentsOfURL: fileUrl)
        if let p = parser {
            p.delegate = self
            if !p.parse() {
                if let delegate = delegate {
                    let userInfo: [String:String] =
                    [
                        NSLocalizedDescriptionKey: "Operation was unsuccessful.",
                        NSLocalizedFailureReasonErrorKey: "Parser failed to parse file.",
                        NSLocalizedRecoverySuggestionErrorKey: "Check to make sure that the OPML file syntax is correct."
                    ]
                    let error = NSError(domain: "ParseEngineErrorDomain", code: 2, userInfo: userInfo)
                    delegate.parseDidFail(error)
                }
                return
            }
        } else {
            if let delegate = delegate {
                let userInfo: [String:String] =
                [
                    NSLocalizedDescriptionKey: "Operation was unsuccessful.",
                    NSLocalizedFailureReasonErrorKey: "Parser failed to initialize.",
                    NSLocalizedRecoverySuggestionErrorKey: "Check to make sure that the OPML file syntax is correct."
                ]
                let error = NSError(domain: "ParseEngineErrorDomain", code: 2, userInfo: userInfo)
                delegate.parseDidFail(error)
            }
            return
        }
    }

    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        if (elementName == "outline") {
            let outlineText: String = attributeDict["text"] as! String
            let saneText = saneify(outlineText)
            addParsedText("<UL>\n")
            addParsedText("<LI>\(saneText)</LI>\n")
            level++
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        if let string = string {
            currentElementText += string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        let saneText = saneify(currentElementText)

        if (elementName == "title") {
            if (fullOutput) {
                addParsedText("<HTML>\n<HEAD>\n<TITLE>\(saneText)</TITLE>\n</HEAD>\n<BODY>\n")
            }
            addParsedText("<H1>\(saneText)</H1>\n")
            currentElementText = ""
        } else if (elementName == "outline") {
            addParsedText("</UL>\n")
            level--;
            if (level == 0 && fullOutput) {
                addParsedText("</BODY>\n</HTML>\n")
            }
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        if let delegate = delegate {
            delegate.parseDidSucceed(parseOutput)
        }
    }

    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        if let delegate = delegate {
            let userInfo: [String:String] =
            [
                NSLocalizedDescriptionKey: "Parse Failed.",
                NSLocalizedFailureReasonErrorKey: "Parse Error #\(parseError.code): \(parseError.localizedDescription)",
                NSLocalizedRecoverySuggestionErrorKey: "Check the validity of your XML."
            ]
            let error = NSError(domain: "ParseEngineErrorDomain", code: 3, userInfo: userInfo)
            delegate.parseDidFail(error)
        }
    }
    
    private func addParsedText(text: String) {
        parseOutput += text
    }
    
    private func saneify(string: String) -> String {
        //         let escapedText = currentElementText.stringByAddingPercentEncodingWithAllowedCharacters(self.validChars)!
        //        let escapedText = currentElementText.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        let string1 = string.stringByReplacingOccurrencesOfString("’", withString: "'", options: NSStringCompareOptions.LiteralSearch, range: nil)
        if (string1.rangeOfString("http") != nil) {
            return "<A HREF=\"\(string1)\">\(string1)</A>"
        } else {
            return string1
        }
    }
}