//
//  CollectionViewController.swift
//  FishGo
//
//  Created by nttr on 2017/07/25.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import AudioToolbox

class CollectionViewController: UIViewController, UICollectionViewDataSource {
    
    var fishIndex : [[String : Any]]=[]
    var fishimg : [UIImage] = []
    var fishname : [String] = []
    var fishhold : [String] = []
    var countF : Int = 0;
    
    
    
    @IBOutlet var fishCollectionView : UICollectionView!
    @IBOutlet var seikaiLabel : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ud = UserDefaults.standard
        if let array = ud.array(forKey: "index") as? [[String : Any]] {
            fishIndex = array
        }
        
        fishCollectionView.dataSource = self
        
        let nib = UINib(nibName: "FishCollectionViewCell", bundle: Bundle.main)
        fishCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
        
        
        //fishimg = [UIImage](count: fishIndex.count,repeatedValue: nil)
        for n in 0..<fishIndex.count{
            if (fishIndex[n]["hold"] as! Int) != 0{
                countF=countF+1
                fishimg.append(UIImage(named : fishIndex[n]["imageName"] as! String)!)
                var a : String = fishIndex[n]["name1"]! as! String
                var b : String = fishIndex[n]["name2"]! as! String
                fishname.append(a+" ("+b+")")
                fishhold.append("所持数: "+String(fishIndex[n]["hold"] as! Int))
            }
            else{
                fishimg.append(UIImage(named : "hatena.png")!)
                fishname.append("???")
                fishhold.append("0")
                
            }
            
        }
        seikaiLabel.text = String(countF)+" / "+String(fishIndex.count)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //個数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fishIndex.count
    }
    
    //2.セルに表示するデータ決め
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as! FishCollectionViewCell
        
        
        //let fishCollectionView = cell.viewWithTag(1) as! UIImageView
        cell.fishImageView.image = fishimg[indexPath.row]
        cell.fishname.text = fishname[indexPath.row]
        cell.fishhols.text = fishhold[indexPath.row]
        //fishCollectionView.image = fishimg[indexPath.row]
        
        return cell
    }
    
    @IBAction func back(){
        var soundIdRing:SystemSoundID = 0
        if let soundUrl:NSURL = NSURL.fileURL(withPath: Bundle.main.path(forResource: "door-wood-knock1", ofType:"mp3")!) as NSURL?{
            AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
            AudioServicesPlaySystemSound(soundIdRing)
        }
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
