//
//  Document.swift
//  Persistent Image Gallery NEW
//
//  Created by Admin on 31/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ImageGalleryDocument: UIDocument {
    
    var imageGallery: ImageGallery?
    
    override func contents(forType typeName: String) throws -> Any {
        return imageGallery?.json ?? Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        if let json = contents as? Data {
            imageGallery = ImageGallery(json: json)
        }
        // Load your document from contents
    }
}

