//
//  ViewController.swift
//  SideBarDrawerDemo
//
//  Created by Manu Singh on 26/06/22.
//

import UIKit
import SideBarDrawer

class ViewController: UIViewController {
    
    var drawer:SideMenuViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        drawer = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuViewController") as? SideMenuViewController
    }
    
    @IBAction func onOpenSideBar(_ sender:Any) {
        drawer?.openDrawer(self)
    }
}

class SideMenuViewController: SideBarViewController {
    
    @IBAction func onClickClose(_ sender:Any) {
        self.closeDrawer()
    }
    
}
