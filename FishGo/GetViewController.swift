//
//  GetViewController.swift
//  FishGo
//
//  Created by nttr on 2017/07/20.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation


class GetViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet var sampleImageView: UIImageView!
    @IBOutlet var fishImageView: UIImageView!
    
    @IBOutlet var flash: UILabel!
    
    var player : AVAudioPlayer!//

    
    var id : Int!
    
    var fishIndex : [[String : Any]]=[]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //var soundIdRing:SystemSoundID = 0
        /*
        if let soundUrl:NSURL = NSURL.fileURL(withPath: Bundle.main.path(forResource: "sea1", ofType:"mp3")!) as NSURL?{
            AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
            AudioServicesPlaySystemSound(soundIdRing)
        }*/
        tonPrepareAudio()
        player.play()
        
        //ファイル読み込み
        let ud = UserDefaults.standard
        if let array = ud.array(forKey: "index") as? [[String : Any]] {
            fishIndex = array
        }
        
        
        let rand : Int = Int(arc4random_uniform(UInt32(fishIndex.count)))
        fishImageView.image = UIImage(named : fishIndex[rand]["imageName"] as! String)
        id = rand
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapDisplay() {
        
        var soundIdRing:SystemSoundID = 0
        if let soundUrl:NSURL = NSURL.fileURL(withPath: Bundle.main.path(forResource: "knife-throw1", ofType:"mp3")!) as NSURL?{
            AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
            AudioServicesPlaySystemSound(soundIdRing)
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.sampleImageView.frame = CGRect(x: self.sampleImageView.frame.origin.x, y: self.sampleImageView.center.y - 400, width: self.sampleImageView.bounds.width, height: self.sampleImageView.bounds.width)
        }) { (finished) in
            UIView.animate(withDuration: 5.0, animations: {
                var soundIdRing:SystemSoundID = 0
                if let soundUrl:NSURL = NSURL.fileURL(withPath: Bundle.main.path(forResource: "decision12", ofType:"mp3")!) as NSURL?{
                    AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
                    AudioServicesPlaySystemSound(soundIdRing)
                }
                self.flash.backgroundColor = UIColor.white
            }, completion: { (finished) in
                self.performSegue(withIdentifier: "toResult", sender: nil)
            })
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResult" {
            player.stop()
        
            
            
            let resultViewController = segue.destination as! ResultViewController
            resultViewController.id = id
            //resultViewController.fishName = fishIndex[id]["name1"]
            //resultViewController.fishName2 = fishIndex[id]["name2"]
            //resultViewController.hold = fishIndex[id]["hold"]
            //resultViewController.imageName = fishIndex[id]["imageName"]
        }
    }
    
    func tonPrepareAudio(){
        // 再生する audio ファイルのパスを取得
        let audioPath = Bundle.main.path(forResource: "sea1", ofType:"mp3")!
        let audioUrl = URL(fileURLWithPath: audioPath)
        // auido を再生するプレイヤーを作成する
        var audioError:NSError?
        do {
            player = try AVAudioPlayer(contentsOf: audioUrl)
            player.delegate = self;
        } catch let error as NSError {
            audioError = error
            player = nil
        }
        
        // エラーが起きたとき
        if let error = audioError {
            print("Error \(error.localizedDescription)")
        }
        
        player.prepareToPlay()
    }
    
    
    
    
    @IBAction func back(){
        player.stop()
  
        var soundIdRing:SystemSoundID = 0
        if let soundUrl:NSURL = NSURL.fileURL(withPath: Bundle.main.path(forResource: "door-wood-knock1", ofType:"mp3")!) as NSURL?{
            AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
            AudioServicesPlaySystemSound(soundIdRing)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
