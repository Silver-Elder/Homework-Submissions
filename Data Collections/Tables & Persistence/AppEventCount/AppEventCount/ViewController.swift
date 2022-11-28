//
//  ViewController.swift
//  AppEventCount
//
//  Created by Sterling Jenkins on 10/17/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var applicationDidFinishLaunching: UILabel!
    @IBOutlet weak var applicationConfigurationForConnecting: UILabel!
    @IBOutlet weak var sceneWillConnectTo: UILabel!
        var willConnectCount = 0
    @IBOutlet weak var sceneDidBecomeActive: UILabel!
        var didBecomeActiveCount = 0
    @IBOutlet weak var sceneWillResignActive: UILabel!
        var willResignActiveCount = 0
    @IBOutlet weak var sceneWillEnterForeground: UILabel!
        var willEnterForegroundCount = 0
    @IBOutlet weak var sceneDidEnterBackground: UILabel!
        var didEnterBackgroundCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    func updateView() {
        applicationDidFinishLaunching.text = "The app has launched \(appDelegate.launchCount) time(s)."
        applicationConfigurationForConnecting.text = "The app has configured \(appDelegate.configurationForConnectingCount) time(s)."
        sceneWillConnectTo.text = "The app has prepared to connect \(willConnectCount) time(s)."
        sceneDidBecomeActive.text = "The app has become active \(didBecomeActiveCount) time(s)."
        sceneWillResignActive.text = "The app has prepared to regin from active state \(willResignActiveCount) time(s)."
        sceneWillEnterForeground.text = "The app has prepared to enter the foreground \(willEnterForegroundCount) time(s)."
        sceneDidEnterBackground.text = "The app has entered the Background \(didEnterBackgroundCount) time(s)."
    }

}

