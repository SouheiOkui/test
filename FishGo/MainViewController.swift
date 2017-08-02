//
//  MainViewController.swift
//  FishGo
//
//  Created by nttr on 2017/07/20.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import AudioToolbox

class MainViewController: UIViewController {
    
    var fishIndex = [["name1" : "鮪",
                    "name2" : "まぐろ",
                    "hold" : 0 as Int,
                    "imageName" : "maguro.png"],
                    ["name1" : "鮃",
                    "name2" : "ひらめ",
                    "hold" : 0 as Int,
                    "imageName" : "hirame.png"],
                    ["name1" : "魷",
                     "name2" : "いか",
                     "hold" : 0 as Int,
                    "imageName" : "1ika.png"],
                    ["name1" : "鰈",
                     "name2" : "かれい",
                     "hold" : 0 as Int,
                     "imageName" : "karei.png"],
                    ["name1" : "鰍",
                    "name2" : "かじか",
                    "hold" : 0 as Int,
                    "imageName" : "kazika.png"],
                    ["name1" : "鰻",
                    "name2" : "うなぎ",
                    "hold" : 0 as Int,
                    "imageName" : "unagi.png"],
                    ["name1" : "鮹",
                     "name2" : "たこ",
                     "hold" : 0 as Int,
                     "imageName" : "tako.png"],
                    ["name1" : "鮑",
                     "name2" : "あわび",
                     "hold" : 0 as Int,
                     "imageName" : "1awabi.png"],
                    ["name1" : "鯛",
                     "name2" : "たい",
                     "hold" : 0 as Int,
                     "imageName" : "1tai.png"],
                    ["name1" : "鮨",
                     "name2" : "すし",
                     "hold" : 0 as Int,
                     "imageName" : "1susi.png"],
                    ["name1" : "鯑",
                     "name2" : "かずのこ",
                     "hold" : 0 as Int,
                     "imageName" : "1kazunoko.png"],
                    ["name1" : "魳",
                     "name2" : "かます",
                     "hold" : 0 as Int,
                     "imageName" : "1kamasu.png"],
                    ["name1" : "鰰",
                     "name2" : "はたはた",
                     "hold" : 0 as Int,
                     "imageName" : "1hatahata.png"],
                    ["name1" : "鰆",
                     "name2" : "さわら",
                     "hold" : 0 as Int,
                     "imageName" : "sawaraa.png"],
                    ["name1" : "鯳",
                     "name2" : "すけとうだら",
                     "hold" : 0 as Int,
                     "imageName" : "sukedara.png"],
                    ["name1" : "魛",
                     "name2" : "たちうお",
                     "hold" : 0 as Int,
                     "imageName" : "tati.png"],
                    ["name1" : "鯣",
                     "name2" : "するめ",
                     "hold" : 0 as Int,
                     "imageName" : "surume.png"],
                    ["name1" : "鰯",
                     "name2" : "いわし",
                     "hold" : 0 as Int,
                     "imageName" : "2iwasi.png"],
                    ["name1" : "鱚",
                     "name2" : "きす",
                     "hold" : 0 as Int,
                     "imageName" : "1kisu.png"]]
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let ud = UserDefaults.standard
        
//        ud.set(fishIndex, forKey: "index")
//        ud.synchronize()
        
        if let array = ud.array(forKey: "index") as? [[String : Any]] {

            // 中身がすでにある場合　かつ、個数が一緒　-> kousinnsaretenai
            if array.count == fishIndex.count {
                return
            }
            // arrayからhold
            ud.set(fishIndex, forKey: "index")
            ud.synchronize()
            
        } else {
            ud.set(fishIndex, forKey: "index")
            ud.synchronize()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextCollection(){
        var soundIdRing:SystemSoundID = 0
        if let soundUrl:NSURL = NSURL.fileURL(withPath: Bundle.main.path(forResource: "jail-door-close1", ofType:"mp3")!) as NSURL?{
            AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
            AudioServicesPlaySystemSound(soundIdRing)
        }
        
    }

    @IBAction func nextGet(){
        
        var soundIdRing:SystemSoundID = 0
        if let soundUrl:NSURL = NSURL.fileURL(withPath: Bundle.main.path(forResource: "splash-big1", ofType:"mp3")!) as NSURL?{
            AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
            AudioServicesPlaySystemSound(soundIdRing)
        }
        
        self.performSegue(withIdentifier: "toGet", sender: nil)
    }
    

}
