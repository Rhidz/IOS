
//  GalleryChooserViewController.swift
//  Image Gallery 1.0
//  Created by Admin on 14/11/2019.
//  Copyright © 2019 Admin. All rights reserved.

import UIKit

class GalleryChooserViewController: UITableViewController {
    
    
    @IBAction func newGallery(_ sender: UIBarButtonItem) {
        albums += ["Untitled".madeUnique(withRespectTo: albums)]
        populateImageGallery()
        //let indexPath = IndexPath(row: 0, section: 0)
        //tableView.reloadSections([indexPath.section], with: .right)
        tableView.reloadData()
    }
    
    private var loadTextField = false
    private var oldName = ""
    private var chosenAlbum = -1
   
    // CVC && TVC model
    private var imageGallery : [String:[UIImage]] = [:]
    
     override func viewDidLoad() {
        super.viewDidLoad()
        populateImageGallery()
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressIdentifier(_:)))
        longPress.delegate = self as? UIGestureRecognizerDelegate
        longPress.minimumPressDuration = 0.5
        tableView.addGestureRecognizer(longPress)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @objc func longPressIdentifier(_ gesture: UILongPressGestureRecognizer) {
        
        if gesture.state == UIGestureRecognizer.State.began {
            let touchPoint = gesture.location(in: tableView)
            
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                loadTextField = true
                oldName = albums[indexPath.row]
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
        
        
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let inputCell = cell as? TextFieldDelegateCell {
            inputCell.textField.becomeFirstResponder()
        }
    }

    // MARK: - Table view data source
   
    private func populateImageGallery() {
        let images : [UIImage] = []
        for index in albums.indices {
            if let gallery = imageGallery[albums[index]] {
                imageGallery.updateValue(gallery, forKey: albums[index])
            }
            else {
                 imageGallery.updateValue(images, forKey: albums[index])
            }
        }
     }
    var albums = ["Untitled"]
    var recentlyDeleted : [String] = []

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        switch section {
        case 0:
            label.text = "Available Galleries"
            
        default:
            label.text = "Recently Deleted"
        }
       
        label.textAlignment = .center
        label.backgroundColor = #colorLiteral(red: 0.9232471585, green: 0.8638940454, blue: 0.9115630984, alpha: 1)
        return label
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return albums.count
        }
        else {
            return recentlyDeleted.count
        }
      
    }
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          // Delete the row from the data source
        tableView.performBatchUpdates({
            let section = indexPath.section
            let sourceIndexPath = IndexPath(row: indexPath.row, section: section)
            let destinationIndexPath = IndexPath(row: 0, section: 1)
            
            switch section {
            case 0:
                recentlyDeleted.append(albums[indexPath.row])
                albums.remove(at: indexPath.row)
            default:
                recentlyDeleted.append(recentlyDeleted[indexPath.row])
                recentlyDeleted.remove(at: indexPath.row)
            }
            
            tableView.deleteRows(at: [sourceIndexPath], with: .fade)
            tableView.insertRows(at: [destinationIndexPath], with: .fade)
        })
        tableView.reloadData()
        
    
      } else if editingStyle == .insert {
          // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
      }
  }
    private func sectionsToReload() {
        
    }
   override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let undeleteSwipeAction = UIContextualAction(style: .normal, title: "Undelete", handler: { _,_,_ in
        switch indexPath.section {
        case 1:
            tableView.performBatchUpdates({ [weak self ] in
                let gallery = self?.recentlyDeleted[indexPath.row]
                let sourceIndexPath = indexPath
                let destinationIndexPath = IndexPath(row: 0, section: 0)
                self?.recentlyDeleted.remove(at: indexPath.row)
                self?.albums.insert(gallery ?? " ", at: indexPath.row)
                tableView.deleteRows(at: [sourceIndexPath], with: .left)
                tableView.insertRows(at: [destinationIndexPath], with: .left)
                self?.populateImageGallery()
                tableView.reloadData()
            })
        default:
            print("nothing to undelete")
        } } )
        undeleteSwipeAction.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        return UISwipeActionsConfiguration(actions: [undeleteSwipeAction])
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if !loadTextField {
             let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let galleryName = indexPath.section == 0 ? albums[indexPath.row] : recentlyDeleted[indexPath.row]
             cell.textLabel?.text = galleryName
             return cell
        }
         else {
             let cell = tableView.dequeueReusableCell(withIdentifier: "TextField", for: indexPath)
              if let inputCell = cell as? TextFieldDelegateCell {
                inputCell.resignHandler = {[weak self, unowned inputCell] in
                    if let text = inputCell.textField.text {
                        if let gallery = self?.imageGallery[self?.oldName ?? ""]{
                            if let index = self?.imageGallery.index(forKey: self?.oldName ?? "") {
                                self?.imageGallery.remove(at: index)
                            }
                            self?.imageGallery.updateValue(gallery, forKey: text)
                            switch indexPath.section {
                            case 0:
                                self?.albums[indexPath.row] = text
                            default:
                                self?.recentlyDeleted[indexPath.row] = text
                            }
                        }
                    }
                    self?.loadTextField = false
                    self?.tableView.reloadData()
                    
                }
            }
            
             return cell
         }
    }
 
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            chosenAlbum = indexPath.row
            performSegue(withIdentifier:"ChooseGallery" , sender: self)
        default:
            print("Not Segueing")
        }
    
    }
    
    private var detailSplitViewController : ImageGalleryViewController? {
        return splitViewController?.viewControllers.last as? ImageGalleryViewController
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       if segue.identifier == "ChooseGallery" {
        if let cvc = segue.destination as? ImageGalleryViewController, let gallery = imageGallery[albums[chosenAlbum]] {
            cvc.chosenGallery = chosenAlbum
            cvc.gallery = gallery
            cvc.delegate = self
            
        }
       
         /* If I can find a detail I will just give the array of images to show from the model in TVC */
        }
    }
 
}
                  
extension GalleryChooserViewController: ImageGalleryDelegate {
    func row(at gallery: Int) -> String {
        return albums[gallery]
    }
    
    func updateAlbums(for key: String, value: [UIImage]) {
        imageGallery.updateValue(value, forKey: key)
    }
}

   // Override to support editing the table view.
   
   

   /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

   }
   */

   /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
       // Return false if you do not want the item to be re-orderable.
       return true
   }
   */

/*  private var lastSeguedTo : ImageGalleryViewController? {
   
      for index in galleries.indices {
       if galleries[index]?.chosenGallery == chosenAlbum {
               return galleries[index]!
           }
       }
       return nil
   } */
/*if let cvc = detailSplitViewController {
           cvc.gallery = imageGallery[chosenAlbum]!
           print("Not Segueing")
       }
       else {
          performSegue(withIdentifier:"ChooseGallery" , sender: self)
          print("Segueing")
       }*/
/* let cvc = segue.destination as? ImageGalleryViewController
 cvc?.delegate = cvc as? ImageGalleryDelegate
 if let gallery = imageGallery[chosenAlbum] {
     cvc?.gallery = gallery
 }
 else {
     let gallery : [UIImage] = []
     imageGallery.updateValue(gallery, forKey: chosenAlbum)
     cvc?.gallery = imageGallery[chosenAlbum]!
     
 }

 cvc?.chosenGallery = chosenAlbum */
