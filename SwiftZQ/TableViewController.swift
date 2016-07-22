//
//  TableViewController.swift
//  SwiftZQ
//
//  Created by XGJ on 16/7/22.
//  Copyright © 2016年 XGJ. All rights reserved.
//

import UIKit

class TableViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
      addChildViewControllers()
       
        self.view.backgroundColor = UIColor.blueColor()
    }
    private func addChildViewControllers(){
        let vc = HomeViewController()

        let hNav = UINavigationController.init(rootViewController: vc)
        addChildViewController(hNav, title: "首页", imageName: "tabbar_home")
        let LNav = UINavigationController.init(rootViewController: LiveViewController())
        addChildViewController(LNav, title: "直播", imageName: "tabbar_gift")
        let aNav = UINavigationController.init(rootViewController: ALLClassViewController())
        addChildViewController(aNav, title: "所有", imageName: "tabbar_category")
        let mNav = UINavigationController.init(rootViewController: MeViewController())
        addChildViewController(mNav, title: "我", imageName: "tabbar_me")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    private func addChildViewController(controller: UIViewController, title:String, imageName:String){
        
        controller.tabBarItem.image = UIImage(named: imageName)
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
        controller.tabBarItem.title = title
        
        addChildViewController(controller)
        
        
        
        
    }
    // MARK: - Table view data source

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
