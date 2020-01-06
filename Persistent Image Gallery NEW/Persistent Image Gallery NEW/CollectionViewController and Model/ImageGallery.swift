//
//  ImageGallery.swift
//  Persistent Image Gallery
//
//  Created by Admin on 27/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation


struct ImageGallery: Codable {
    // MARK:- URLS of all images in the document.
    var urls: [URL] = []
    
    init(urls: [URL]) {
        self.urls = urls
    }
    
    init?(json: Data){
        if let newValue = try? JSONDecoder().decode(ImageGallery.self, from: json) {
            self = newValue
        }
        else{
             return nil
        }
        
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
}

