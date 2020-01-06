//
//  ViewController.swift
//  Persistent Image Gallery
//
//  Created by Admin on 24/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ImageGalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    
    // MARK:- UIDOCUMENT
    
    var document: ImageGalleryDocument?
    
    // MARK:- LOADING FROM JSON DATA IN VIEWWILLAPPEAR()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        document?.open { success in
            if success {
                self.title = self.document?.localizedName
                if let imageGallery = self.document?.imageGallery {
                    self.imageGallery = imageGallery
                    self.imageCollectionView.reloadData()
                    
                }
                 
            }
            
        }
      
    }
    
    
    // MARK:- MODEL
    private var imageGallery: ImageGallery? {
        get {
            var urls: [URL] = []
            /* Populate it using json representation */
            if let range = localImageGallery?.indices {
                for indice in range {
                    if let url = localImageGallery?[indice].url {
                        urls.append(url)
                    }
                }
            }
             return ImageGallery(urls: urls)
        }
        set {
            self.localImageGallery = []
            newValue?.urls.forEach {
                if let image = retrieveCachedResponseAsImage(url: $0.imageURL, completionHandler: { (result) in
                           switch result {
                           case .success(let yourData):
                               print("I have found data \(yourData)")

                           case .failure(let error):
                               debugPrint(error.localizedDescription)
                           } }) {
                        let element = ImageGalleryViewController.ImageUrl(url: $0, image: UIImage(data: image))

                        localImageGallery?.append(element)
                        
                }
            }
        }
    }
    
    private var localImageGallery : [ImageUrl]?
    /* This should never be an optional */
    
    private var image: UIImage?
     
  //MARK:- DIRECTORY
    
    let sandboxDirectory = try? FileManager.default.url(
        for: .cachesDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: true).appendingPathComponent("Untitled.json")
    
    
    // MARK:- CACHE
    
    let diskCapacity = 500 * 1024 * 1024
    let memoryCapacity = 100 * 1024 * 1024
   
    lazy var cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, directory: sandboxDirectory)
    typealias DownloadCompletionHandler = (Result<Data,Error>) -> ()
    
    private func createAndRetrieveURLSession() -> URLSession {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.requestCachePolicy = .returnCacheDataElseLoad
        sessionConfiguration.urlCache = cache
        return URLSession(configuration: sessionConfiguration)
    }
    /* This is the method I will use while dropping images, updating my model, setting my model */
    private func retrieveCachedResponseAsImage(url: URL, completionHandler: @escaping DownloadCompletionHandler) -> Data? {
        var sharedData: Data?
        let url = url.imageURL
        let urlRequest = URLRequest(url: url)
        // First try fetching the data if available in cache
        
        if let cachedData = self.cache.cachedResponse(for: urlRequest) {
            sharedData = cachedData.data
            self.notCacheRespose = true
            print("Are we caching from here")
         }
        else {
            
                self.createAndRetrieveURLSession().dataTask(with: urlRequest) { (data, response, error) in
                        if let error = error {
                            completionHandler(.failure(error))
                            print("Error")
                        }
                        else {
                            print("3) I am in CACHE")
                            let cachedData = CachedURLResponse(response: response!, data: data!)
                            self.cache.storeCachedResponse(cachedData, for: urlRequest)
                            sharedData = cachedData.data
                            //self.notCacheRespose = true
                            completionHandler(.success(data!))
                        }
                         
                    }.resume()
                }
                
        
          return sharedData
        }
      
    
    
    // MARK:- DATA SOURCE
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return localImageGallery?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Image Cell", for: indexPath)
       
        if let imageCell = cell as? ImageGalleryViewCell {
            imageCell.image.image = localImageGallery?[indexPath.item].image
        }
           return cell
      }
   
    // MARK:- DRAG AND DROP
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        session.localContext = collectionView
        return dragItems(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        session.localContext = collectionView
        return dragItems(at: indexPath)
        
    }
    
    private func dragItems(at indexPath: IndexPath) -> [UIDragItem] {
          if let image = (imageCollectionView.cellForItem(at: indexPath) as? ImageGalleryViewCell)?.image.image {
               let dragItem = UIDragItem(itemProvider: NSItemProvider(object: image))
               dragItem.localObject = image
               return [dragItem]
           }
           else{
               return []
           }
       }
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self) && session.canLoadObjects(ofClass: NSURL.self)
          }
    
       
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
           let isSelf = (session.localDragSession?.localContext as? UICollectionView) == collectionView
           return UICollectionViewDropProposal(operation: isSelf ? .move : .copy, intent: .insertAtDestinationIndexPath)
       }
       
    var notCacheRespose = true
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        for item in coordinator.items {
            if let sourceIndexPath = item.sourceIndexPath {
                if let image = item.dragItem.localObject as? UIImage {
                    collectionView.performBatchUpdates({
                        if let url = localImageGallery?[sourceIndexPath.item].url {
                            localImageGallery?.remove(at: sourceIndexPath.item)
                            let imageUrl = ImageGalleryViewController.ImageUrl(url: url, image: image)
                            localImageGallery?.insert(imageUrl, at: destinationIndexPath.item)
                            collectionView.deleteItems(at: [sourceIndexPath])
                            collectionView.insertItems(at: [destinationIndexPath])
                            
                        }
                           
                    })
                        coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
                }
            }
            else {
                let placeholderContext = coordinator.drop(item.dragItem, to:UICollectionViewDropPlaceholder(insertionIndexPath: destinationIndexPath, reuseIdentifier: "DropPlaceHolderCell"))
                item.dragItem.itemProvider.loadObject(ofClass: NSURL.self){(provider, error) in
                    
                        if let url = provider as? URL {
                             if let imageData = self.retrieveCachedResponseAsImage(url: url, completionHandler: { (result) in
                                   switch result {
                                   case .success(let data):
                                    DispatchQueue.main.async {
                                        placeholderContext.commitInsertion(dataSourceUpdates: { [weak self] insertionIndexPath in
                                         
                                         let image = UIImage(data: data)
                                         let imageUrl = ImageGalleryViewController.ImageUrl(url: url, image: image)
                                            if self?.localImageGallery != nil {
                                                self?.localImageGallery?.insert(imageUrl, at: insertionIndexPath.item)
                                            }
                                            else {
                                                self?.localImageGallery = []
                                                self?.localImageGallery?.append(imageUrl)
                                            }
                                            
                                            self?.notCacheRespose = false
                                            //self?.imageCollectionView
                                           })
                                    }
                                       print("2) Got my data \(data)")
                                   case .failure(let error):
                                      debugPrint(error.localizedDescription)
                                   }}){
                                if self.notCacheRespose {
                                    DispatchQueue.main.async {
                                        placeholderContext.commitInsertion(dataSourceUpdates: { [weak self] insertionIndexPath in
                                         
                                         let image = UIImage(data: imageData)
                                         let imageUrl = ImageGalleryViewController.ImageUrl(url: url, image: image)
                                            self?.localImageGallery?.insert(imageUrl, at: insertionIndexPath.item)
                                            self?.notCacheRespose = false
                                           })
                                    }
                                }
                                 }
                           }
                           else {
                               placeholderContext.deletePlaceholder()
                           }
                    
                }
            }
        }
        
    }
    
    // MARK:- CLOSE
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        save()
        dismiss(animated: true){
            self.document?.close()
        }
        
    }
    
    
    // MARK:- SAVE
    
    @IBAction func save(_ sender: UIBarButtonItem? = nil) {
        document?.imageGallery = imageGallery
        if document?.imageGallery != nil {
            document?.updateChangeCount(.done)
        }
    }
    
    @IBOutlet weak var imageCollectionView: UICollectionView! {
        didSet {
            imageCollectionView.dataSource = self
            imageCollectionView.delegate = self
            imageCollectionView.dragDelegate = self
            imageCollectionView.dropDelegate = self
            
        }
    }


}
extension ImageGalleryViewController {
    struct ImageUrl {
        var image: UIImage?
        var url: URL?
        
        init(url: URL? = nil, image: UIImage? = nil) {
            self.image = image
            self.url = url
        }
    }
}

