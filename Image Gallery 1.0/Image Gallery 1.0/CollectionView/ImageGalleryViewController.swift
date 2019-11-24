
import UIKit

class ImageGalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDragDelegate, UICollectionViewDropDelegate {
 
    // MARK DATA SOURCE METHODS
    var chosenGallery:  String = ""
    var gallery : [UIImage] = []
       
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return gallery.count
       }
      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
           if let imageCell = cell as? ImageCell {
            imageCell.image.image = gallery[indexPath.item] // imageGallery[indexPath.item].image
        }
           return cell
       }
    
    // MARK COLLECTIONVIEW FLOW DELEGATE METHODS
    
    private let itemsPerRow : CGFloat = 3
     
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
     
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
      
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsets
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.left
    }
    
   // MARK COLLECTION VIEW DRAG DELEGATE METHODS
   
    /* What are the items that are being dragged */
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        session.localContext = collectionView  /* If local context is set here then everytime when an image is dragged locally the current image in the image var is set*/
        return dragItems(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        session.localContext = collectionView
        return dragItems(at: indexPath)
       }
    /* UIImages that are fetched from the urls are being dragged */
       private func dragItems(at indexPath: IndexPath) -> [UIDragItem] {
         /* cellForItem method always returned the image that was set in the image variable. Fixed it by fetching data from the gallery for the required indexPath */
           if let image = (imageCollectionView.cellForItem(at: indexPath) as? ImageCell)?.image.image {
               let dragItem = UIDragItem(itemProvider: NSItemProvider(object: image))
               dragItem.localObject = image
               return [dragItem]
           }
           else{
               return []
           }
       }
    
    // MARK DROP  DELEGATE METHODS
      /* What kinds of drops the collection view will handle */
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
   
        return session.canLoadObjects(ofClass: UIImage.self) && session.canLoadObjects(ofClass: NSURL.self)
       }
 
    /* What the collectionView will do with the dropped objects */
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        /* isSelf is a boolean */
        let isSelf = (session.localDragSession?.localContext as? UICollectionView) == collectionView
        return UICollectionViewDropProposal(operation: isSelf ? .move : .copy, intent: .insertAtDestinationIndexPath)
    }
    
    /* This var should fetch the image from the url that is being dropped.*/
    private var image: UIImage?
   
    
    /* When the user lets go of the data. This is where I want to initiate fetching my url, setting the image for image cell and do multithreading stuff */
   
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        /* All the items that I might drop */
    
        for item in coordinator.items {
            /* When the drop is local */
            if let sourceIndexPath = item.sourceIndexPath {
                if let image = item.dragItem.localObject as? UIImage {
                    collectionView.performBatchUpdates({
                        gallery.remove(at: sourceIndexPath.item)
                        gallery.insert(image, at: destinationIndexPath.item)
                        collectionView.deleteItems(at: [sourceIndexPath])
                        collectionView.insertItems(at: [destinationIndexPath])
                        
                    })
                    coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
                }
            } else {
                /* Do I need to do a batch update here?? */
                let placeholderContext = coordinator.drop(item.dragItem, to:UICollectionViewDropPlaceholder(insertionIndexPath: destinationIndexPath, reuseIdentifier: "DropPlaceholderCell"))
                item.dragItem.itemProvider.loadObject(ofClass: NSURL.self){ (provider, error) in
                       /* Instead of calling a function I wrote the code */
                    DispatchQueue.global(qos: .userInitiated).async {
                        if let url = provider as? URL {
                            let urlToBeFetched = url.imageURL
                            let urlContents = try? Data(contentsOf: urlToBeFetched)
                            DispatchQueue.main.async {
                                if let imageData = urlContents, url.imageURL == urlToBeFetched {
                                    self.image = UIImage(data: imageData)
                                    placeholderContext.commitInsertion(dataSourceUpdates: { insertionIndexPath in
                                        self.gallery.insert(self.image!, at: insertionIndexPath.item)
                                  
                                    })
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
    }
          
   /* This view will accept all those drops of urls and images */
    @IBOutlet weak var imageCollectionView: UICollectionView! {
        didSet {
            imageCollectionView.dataSource = self
            imageCollectionView.delegate = self
            imageCollectionView.dragDelegate = self
            imageCollectionView.dropDelegate = self
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
}




