//
//  ViewController.swift
//  ISpy
//
//  Created by Sterling Jenkins on 10/21/22.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var sterlingImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scrollView.delegate = self
        // ^^^ This is what it means to "set the scroll view delegate to the View Controller"
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return sterlingImage
    }
    
    func updateZoomFor(size: CGSize) {
        
        let widthScale = size.width / sterlingImage.bounds.width
        let heightScale = size.height / sterlingImage.bounds.height
        let scale = min(widthScale, heightScale)
        scrollView.minimumZoomScale = scale
        scrollView.zoomScale = scale
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateZoomFor(size: view.bounds.size)
    }

}

