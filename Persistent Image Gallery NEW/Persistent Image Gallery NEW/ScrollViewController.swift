//
//  ScrollViewController.swift
//  Persistent Image Gallery NEW
//
//  Created by Admin on 06/01/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let data = data {
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = UIImage(data: data)
            }
           
        }

        // Do any additional setup after loading the view.
    }
    var data: Data?
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView?.image?.size ?? CGSize.zero
        }
    }
}
extension ScrollViewController : UIScrollViewDelegate {
    
}

