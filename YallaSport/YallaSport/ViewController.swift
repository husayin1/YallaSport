//
//  ViewController.swift
//  YallaSport
//
//  Created by husayn on 22/04/2024.
//
//

import UIKit
import Lottie

class ViewController: UIViewController {

    var animationView : LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView = LottieAnimationView(name: "mySplashLotti")
        animationView?.frame = view.bounds
        animationView?.animationSpeed = 0.9
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        view.addSubview(animationView!)
        animationView?.play()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
            
            if let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
 
                self.navigationController?.pushViewController(homeViewController, animated: true)
            }
            
        }
        
        
    }

}

