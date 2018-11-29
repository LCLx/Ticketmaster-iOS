//
//  ArtistTabViewController.swift
//  EventSearch
//
//  Created by LCL on 11/29/18.
//  Copyright © 2018 LCL. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher
import SwiftSpinner
class ArtistTabViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var NoResults: UILabel!
//    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var CollectionView: UICollectionView!
    var isArt = false
    var data = JSON()
    var PicData = JSON()
    var SpotifyData = JSON()
    var NetworkClass = NetworkService()
    var reqString = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionView.delegate = self
        CollectionView.dataSource = self
        if(data.count==0){
            CollectionView.isHidden = true
            NoResults.isHidden = false
            return 
        }
        // Do any additional setup after loading the view.
        for (_,subJson):(String, JSON) in data {
            reqString.append(subJson["name"].stringValue)
        }
        SwiftSpinner.show("Fetching Artist Info...")
        print(reqString)
        NetworkClass.GetPics(para: ["artists":reqString], finishedCallBack: {result in
            self.PicData = JSON(result)
            print(self.PicData)
            
            if(self.isArt){
                self.NetworkClass.GetSpotify(para: ["artists":self.reqString], finishedCallBack: {innerResult in
                    self.SpotifyData = JSON(innerResult)
                    
                    print(self.SpotifyData)
                    self.CollectionView.reloadData()
                    SwiftSpinner.hide()
                })
            }
            else{
                self.CollectionView.reloadData()
                SwiftSpinner.hide()
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(data[section]["name"].stringValue)
        print(PicData[data[section]["name"].stringValue].count + SpotifyData[data[section]["name"].stringValue].count)
        return PicData[data[section]["name"].stringValue].count + SpotifyData[data[section]["name"].stringValue].count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var delta = 0
        if(indexPath.row == 0){
            if(!SpotifyData[data[indexPath.section]["name"].stringValue].isEmpty){
                delta = 1
            }
        }
        if(indexPath.row - delta>=0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoogleCell", for: indexPath) as! ImageCollectionViewCell
            let url = URL(string: PicData[data[indexPath.section]["name"].stringValue][indexPath.row - delta].stringValue)
            cell.ImageView.kf.setImage(with: url)
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistCell", for: indexPath) as! InfoCollectionViewCell
            cell.Name.text = data[indexPath.section]["name"].stringValue
            cell.Followers.text = SpotifyData[data[indexPath.section]["name"].stringValue]["followers"].stringValue
            cell.Popularity.text = SpotifyData[data[indexPath.section]["name"].stringValue]["popularity"].stringValue
            cell.SpotifyUrl = SpotifyData[data[indexPath.section]["name"].stringValue]["checkAt"].stringValue
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderName", for: indexPath) as! HeaderCollectionReusableView
        reusableview.Name.text = data[indexPath.section]["name"].stringValue
        return reusableview
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
