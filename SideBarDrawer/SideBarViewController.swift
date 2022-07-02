//
//  SideBarViewController.swift
//  SideBarDrawer
//
//  Created by Manu Singh on 26/06/22.
//

import UIKit

open class SideBarViewController: UIViewController {
    
    var transition:UIViewControllerTransitioningDelegate? = SideBarTransitioningDelegate()
    
    public override var transitioningDelegate: UIViewControllerTransitioningDelegate? {
        get {
            return transition
        }
        set {
            transition = newValue
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    public func openDrawer(_ controller:UIViewController) {
        self.modalPresentationStyle = .overCurrentContext
        controller.present(self, animated: true)
    }
    
    @objc public func closeDrawer(){
        self.dismiss(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class SideBarTransitioningDelegate:NSObject, UIViewControllerTransitioningDelegate {
    
    var drawerTransitioning = DrawerTransitioning()
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return drawerTransitioning
    }

    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return drawerTransitioning
    }
}

class DrawerTransitioning : NSObject ,UIViewControllerAnimatedTransitioning {
    
    var duration:TimeInterval = 0.3
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if (transitionContext.view(forKey: UITransitionContextViewKey.to)) != nil {
            //present
            presentDrawer(using: transitionContext)
        } else if (transitionContext.view(forKey: UITransitionContextViewKey.from)) != nil {
            //dismiss
            dismissDrawer(using: transitionContext)
        }
    }
    
    func presentDrawer(using transitionContext: UIViewControllerContextTransitioning){
        let contentView = transitionContext.containerView
        let drawerView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        contentView.addSubview(drawerView!)
        drawerView?.frame = CGRect(x: -contentView.bounds.width, y: 0, width: contentView.bounds.width*0.7, height: contentView.bounds.height)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            drawerView?.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width*0.7, height: contentView.bounds.height)
            contentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }) { completed in
            transitionContext.completeTransition(true)
        }
        addTapGesture(using: transitionContext)
    }
    
    func dismissDrawer(using transitionContext: UIViewControllerContextTransitioning){
        let contentView = transitionContext.containerView
        let drawerView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            drawerView?.frame = CGRect(x: -contentView.bounds.width, y: 0, width: contentView.bounds.width*0.7, height: contentView.bounds.height)
            contentView.backgroundColor = UIColor.clear
        }) { completed in
            transitionContext.completeTransition(true)
        }
    }
    
    func addTapGesture(using transitionContext: UIViewControllerContextTransitioning){
        let contentView = transitionContext.containerView
        let drawer = transitionContext.viewController(forKey: .to) as! SideBarViewController
        let button = UIButton(type: .custom)
        button.setTitle(nil, for: .normal)
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .width, multiplier: 0.3, constant: 0).isActive = true
        button.addTarget(drawer, action: #selector(SideBarViewController.closeDrawer), for: .touchUpInside)

    }
    
    
}
