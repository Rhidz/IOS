
//  GalleryChooserViewController.swift
//  Image Gallery 1.0
//  Created by Admin on 14/11/2019.
//  Copyright © 2019 Admin. All rights reserved.

import UIKit

class GalleryChooserViewController: UITableViewController {
    
    private var chosenAlbum = ""
   
    // CVC model
    private var imageGallery : [String:[UIImage]] = [:]
    
     override func viewDidLoad() {
        super.viewDidLoad()
        populateImageGallery()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
   
    private func populateImageGallery() {
        let images : [UIImage] = []
        for index in albums.indices {
            imageGallery.updateValue(images, forKey: albums[index])
        }
    }
    
    // TVC Model
    var albums = ["Rhidita", "Saadat"]

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = albums[indexPath.row]

        return cell
    }
  
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenAlbum = albums[indexPath.row]
        if let cvc = lastSeguedTo {
            cvc.chosenGallery = chosenAlbum
            print("Not Segueing")
        }
        else {
           performSegue(withIdentifier:"ChooseGallery" , sender: self)
           print("Segueing")
        }
    }
    
    var galleries : [ImageGalleryViewController?] = []
    
    private var lastSeguedTo : ImageGalleryViewController? {
    
       for index in galleries.indices {
        if galleries[index]?.chosenGallery == chosenAlbum {
                return galleries[index]!
            }
        }
        return nil
    }
  

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
     
 
    // MARK: - Navigation


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "ChooseGallery" {
            let cvc = segue.destination as? ImageGalleryViewController
            if let gallery = imageGallery[chosenAlbum] {
                cvc?.gallery = gallery
                cvc?.chosenGallery = chosenAlbum
                galleries.append(cvc)
            }
           /* else {
                let gallery : [UIImage] = []
                imageGallery.updateValue(gallery, forKey: chosenAlbum)
                cvc?.gallery = imageGallery[chosenAlbum]!
                cvc?.chosenGallery = chosenAlbum
            } */
            
            
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
   
}

/*
   
   private var slpitViewDetailImageGalleryViewController : ImageGalleryViewController? {
       return splitViewController?.viewControllers.last as? ImageGalleryViewController
   }  */
   /*   */
     

