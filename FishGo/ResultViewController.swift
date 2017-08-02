//
//  ResultViewController.swift
//  FishGo
//
//  Created by nttr on 2017/07/20.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation//

class ResultViewController: UIViewController, AVAudioPlayerDelegate{
    
    var id : Int = 0
    var ansnumber : Int = 0
    
    var player : AVAudioPlayer!//
    
    var count : Double = 6.00
    var timer : Timer!
    @IBOutlet var timerLabel : UILabel!
    
    @IBOutlet var label : UILabel!
    @IBOutlet var label2 : UILabel!
    @IBOutlet var textbox : UITextField!
    @IBOutlet var fishImageView : UIImageView!
    
    @IBOutlet var ans1 : UIButton!
    @IBOutlet var ans2 : UIButton!
    @IBOutlet var ans3 : UIButton!
    @IBOutlet var ans4 : UIButton!
    
    
    var fishIndex : [[String : Any]]=[]
    
    func audioPlayerDif(){
        
        // 音声ファイルのパスを定義 ファイル名, 拡張子を定義
        //let audioPath = NSBundle.mainBundle().pathForResource("oven-timer1", ofType: "mp3")!
        let audioPath = Bundle.main.path(forResource: "oven-timer1", ofType:"mp3")!
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //ファイル読み込み
        let ud = UserDefaults.standard
        if let array = ud.array(forKey: "index") as? [[String : Any]] {
            fishIndex = array
        }
        
        tonPrepareAudio()
        
        
        /*let rand1 : Int = Int(arc4random_uniform(UInt32(fishIndex[id].count)))
        let rand2 : Int = Int(arc4random_uniform(UInt32(fishIndex[id].count)))
        let rand3 : Int = Int(arc4random_uniform(UInt32(fishIndex[id].count)))
        let rand4 : Int = Int(arc4random_uniform(UInt32(fishIndex[id].count)))
        */
        
        var a : [Int] = randAAA(number: fishIndex.count)
     
        let rand1 : Int = a[0]
        let rand2 : Int = a[1]
        let rand3 : Int = a[2]
        let rand4 : Int = a[3]
        
        
        ans1.setTitle(fishIndex[rand1]["name1"] as! String, for: .normal)
        ans2.setTitle(fishIndex[rand2]["name1"] as! String, for: .normal)
        ans3.setTitle(fishIndex[rand3]["name1"] as! String, for: .normal)
        ans4.setTitle(fishIndex[rand4]["name1"] as! String, for: .normal)
        
        
        let rand : Int = Int(arc4random_uniform(UInt32(4)))
        ansnumber = rand
        fishImageView.image = UIImage(named : fishIndex[id]["imageName"] as! String)
        
        
        print("id")
        print(id)
        print("ans")
        print(ansnumber)
        //print("あ:")
        //print(rand1)
        //print("い:")
        //print(rand2)
        //print("う:")
        //print(rand3)
        //print("え:")
        //print(rand4)

        
        if ansnumber == 0 {
            ans1.setTitle(fishIndex[id]["name1"] as! String, for: .normal)  //.title = fishIndex[id]["name1"]
            print("一つ目のぼたん")
        }
        else if ansnumber == 1 {
            ans2.setTitle(fishIndex[id]["name1"] as! String, for: .normal)  //.title = fishIndex[id]["name1"]
            print("2つ目のぼたん")
        }
        else if ansnumber == 2 {
            ans3.setTitle(fishIndex[id]["name1"] as! String, for: .normal)  //.title = fishIndex[id]["name1"]
            print("3つ目のぼたん")
        }
        else if ansnumber == 3 {
            ans4.setTitle(fishIndex[id]["name1"] as! String, for: .normal)  //.title = fishIndex[id]["name1"]
            print("4つ目のぼたん")
        }
        
        
        
        
        //timer---
        timerLabel.text  = String(count)
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ResultViewController.update), userInfo: nil, repeats: true)
        
        
        player.play()
        
        
        
        
    }

    func tonPrepareAudio(){
        // 再生する audio ファイルのパスを取得
        let audioPath = Bundle.main.path(forResource: "oven-timer1", ofType:"mp3")!
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update(){
        count=count-0.01
        timerLabel.text = String(format: "%.2f", count)
        if timerLabel.text == "3.00"{
            timerLabel.textColor = UIColor.red
        }
        
        if count < 0{
            timer.invalidate()
            bad()
        }
    }
    
    
    @IBAction func answer1(){
        if ansnumber == 0 {
            good()
        }
        else{
            bad()
        }
    }
    @IBAction func answer2(){
        if ansnumber == 1 {
            good()
        }
        else{
           bad()
        }
    }
    @IBAction func answer3(){
        if ansnumber == 2 {
            good()
        }
        else{
           bad()
        }
    }
    @IBAction func answer4(){
        if ansnumber == 3 {
            good()
        }
        else{
            bad()
        }
    }
    
    func good(){
        timer.invalidate()
        player.stop()
        audioPlayerDif()
        var soundIdRing:SystemSoundID = 0
        if let soundUrl:NSURL = NSURL.fileURL(withPath: Bundle.main.path(forResource: "correct2", ofType:"mp3")!) as NSURL?{
            AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
            AudioServicesPlaySystemSound(soundIdRing)
        }
        
        
        // fishIndex[id].updateValue( fishIndex[id]["hold"] as! Int , forKey: "hold")
        
//        print(fishIndex)
//        
//        if let holdAny = fishIndex[id]["hold"] {
//            if let hold = holdAny as? Int {
//                fishIndex[id]["hold"] = hold + 1
//            } else {
//                print("謎")
//                print(type(of: fishIndex[id]["hold"]), holdAny, type(of: holdAny))
//            }
//        } else {
//            print(fishIndex[id]["hold"])
//        }
        
        fishIndex[id]["hold"] = (fishIndex[id]["hold"]! as! Int) + 1
        
        let ud = UserDefaults.standard
        ud.set(fishIndex, forKey: "index")
        ud.synchronize()
        
        
        self.performSegue(withIdentifier: "toMain", sender: nil)
        
        
    }
    func bad(){
        timer.invalidate()
        player.stop()
        audioPlayerDif()
        var soundIdRing:SystemSoundID = 0
        if let soundUrl:NSURL = NSURL.fileURL(withPath: Bundle.main.path(forResource: "incorrect1", ofType:"mp3")!) as NSURL?{
            AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
            AudioServicesPlaySystemSound(soundIdRing)
        }
        
        self.performSegue(withIdentifier: "toMain", sender: nil)

    }
    
    func randAAA(number: Int) -> [Int]{
        var rands : [Int]
        rands = []
        for n  in 0..<number{
            rands.append(n)
        }
        var rand1 : Int = 1
        var rand2 : Int = 2
        var rand3 : Int = 3
        var rand4 : Int = 4
        
        
        
        for n in 0..<1000{
            var aaa : Int = Int(arc4random_uniform(UInt32(number)))
            if aaa != id{
                rand1 = aaa
                break
            }
        }
        for n in 0..<1000{
            var aaa : Int = Int(arc4random_uniform(UInt32(number)))
            if aaa != rand1 && aaa != id{
                rand2 = aaa
                break
            }
        }
        for n in 0..<1000{
            var aaa : Int = Int(arc4random_uniform(UInt32(number)))
            if aaa != rand1 && aaa != rand2 && aaa != id{
                rand3 = aaa
                break
            }
        }
        for n in 0..<1000{
            var aaa : Int = Int(arc4random_uniform(UInt32(number)))
            if aaa != rand1 && aaa != rand2 && aaa != rand3 && aaa != id{
                rand4 = aaa
                break
            }
        }
        //rands.append(rand1)
        //rands.append(rand2)
        //rands.append(rand3)
        //rands.append(rand4)
        
        rands[0]=rand1
        rands[1]=rand2
        rands[2]=rand3
        rands[3]=rand4
        
        return rands
    }

}
