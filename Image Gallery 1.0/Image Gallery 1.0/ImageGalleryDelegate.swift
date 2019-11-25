//
//  ImageGalleryDelegate.swift
//  Image Gallery 1.0
//
//  Created by Admin on 25/11/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit
protocol ImageGalleryDelegate {
    func updateAlbums(for key: String, value: [UIImage])
}
