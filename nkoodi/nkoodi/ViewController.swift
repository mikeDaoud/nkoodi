//
//  ViewController.swift
//  nkoodi
//
//  Created by Michael Attia on 8/1/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import UIKit
import BATabBarController


class ViewController: UIViewController {

    var baTabBarController: BATabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let vc1 = MainViewController.create()
        let vc2 = BalanceViewController.create()
        let vc3 = QRReaderViewController.create()
        let vc4 = StoresViewController.create()
        let vc5 = UIViewController()

        vc5.view.backgroundColor = UIColor(hex: 0x00c6c10)
        let option1 = NSMutableAttributedString(string: "QR")
        option1.addAttribute(NSForegroundColorAttributeName, value: UIColor(hex: 0x757575), range: NSRange(location: 0, length: option1.length))
        option1.addAttribute(NSFontAttributeName, value: UIFont.init(name: "Acens", size: 12), range: NSRange(location: 0, length: option1.length))
        let tabBarItem = BATabBarItem(image: UIImage(named: "ico_01")?.withRenderingMode(.alwaysTemplate).maskWithColor(color: UIColor(hex: 0x757575)), selectedImage: UIImage(named: "ico_01")?.withRenderingMode(.alwaysTemplate).maskWithColor(color: UIColor(hex: 0x009efd)), title: option1)
        let option2 = NSMutableAttributedString(string: "Balance")
        option2.addAttribute(NSFontAttributeName, value: UIFont.init(name: "Acens", size: 12), range: NSRange(location: 0, length: option2.length))
        option2.addAttribute(NSForegroundColorAttributeName, value: UIColor(hex: 0x757575), range: NSRange(location: 0, length: option2.length))
        let tabBarItem2 = BATabBarItem(image: UIImage(named: "ico_02")?.withRenderingMode(.alwaysTemplate).maskWithColor(color: UIColor(hex: 0x757575)), selectedImage: UIImage(named: "ico_02")?.withRenderingMode(.alwaysTemplate).maskWithColor(color: UIColor(hex: 0x009efd)), title: option2)
        let option3 = NSMutableAttributedString(string: "Transfer")
        option3.addAttribute(NSFontAttributeName, value: UIFont.init(name: "Acens", size: 12), range: NSRange(location: 0, length: option3.length))
        option3.addAttribute(NSForegroundColorAttributeName, value: UIColor(hex: 0x757575), range: NSRange(location: 0, length: option3.length))
        let tabBarItem3 = BATabBarItem(image: UIImage(named: "ico_03")?.withRenderingMode(.alwaysTemplate).maskWithColor(color: UIColor(hex: 0x757575)), selectedImage: UIImage(named: "ico_03")?.withRenderingMode(.alwaysTemplate).maskWithColor(color: UIColor(hex: 0x009efd)), title: option3)
        let option4 = NSMutableAttributedString(string: "Stores")
        option4.addAttribute(NSFontAttributeName, value: UIFont.init(name: "Acens", size: 12), range: NSRange(location: 0, length: option4.length))
        option4.addAttribute(NSForegroundColorAttributeName, value: UIColor(hex: 0x757575), range: NSRange(location: 0, length: option4.length))
        let tabBarItem4 = BATabBarItem(image: UIImage(named: "ico_04")?.withRenderingMode(.alwaysTemplate).maskWithColor(color: UIColor(hex: 0x757575)), selectedImage: UIImage(named: "ico_04")?.withRenderingMode(.alwaysTemplate).maskWithColor(color: UIColor(hex: 0x009efd)), title: option4)
        let option5 = NSMutableAttributedString(string: "More")
        option5.addAttribute(NSFontAttributeName, value: UIFont.init(name: "Acens", size: 12), range: NSRange(location: 0, length: option5.length))
        option5.addAttribute(NSForegroundColorAttributeName, value: UIColor(hex: 0x757575), range: NSRange(location: 0, length: option5.length))
        let tabBarItem5 = BATabBarItem(image: UIImage(named: "ico_05")?.withRenderingMode(.alwaysTemplate).maskWithColor(color: UIColor(hex: 0x757575)), selectedImage: UIImage(named: "ico_05")?.withRenderingMode(.alwaysTemplate).maskWithColor(color: UIColor(hex: 0x009efd)), title: option5)
        baTabBarController = BATabBarController()
        baTabBarController.tabBarItemStrokeColor = UIColor(hex: 0x009efd)
        baTabBarController.viewControllers = [vc1, vc2, vc3, vc4, vc5]
        baTabBarController.tabBarItems = [tabBarItem ?? BATabBarItem(), tabBarItem2 ?? BATabBarItem(), tabBarItem3 ?? BATabBarItem(), tabBarItem4 ?? BATabBarItem(), tabBarItem5 ?? BATabBarItem()]
        baTabBarController.setSelectedView(vc1, animated: false)
        baTabBarController.delegate = self
        baTabBarController.tabBarBackgroundColor = UIColor.white
        view.addSubview(baTabBarController.view)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: BATabBarControllerDelegate{
    func tabBarController(_ tabBarController: BATabBarController!, didSelect viewController: UIViewController!) {
        
    }
    
    
}

extension UIImage {
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
}

