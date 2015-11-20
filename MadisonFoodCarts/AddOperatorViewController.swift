//
//  AddOperatorViewController.swift
//  MadisonFoodCarts
//
//  Created by Matt Peterson on 11/19/15.
//  Copyright © 2015 Philip Tibbetts. All rights reserved.
//

import UIKit

class AddOperatorViewController: UIViewController
{

    @IBOutlet weak var errorLabel: UILabel!
    
    var operatorList: [String]?
    
    @IBOutlet weak var operatorName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    
    
    //stops the segue if someone tries to make a new operator with the same name as a current operator
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool
    {
        if let ident = identifier
        {
            if ident == "addedOperator"
            {
                if (operatorList!.contains(operatorName.text!)) == true
                {
                    let name: String = operatorName.text!
                    errorLabel.text = "\(name) is already in the list of operators! Please try again!"
                    return false
                }
            }
        }
        return true
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
            // Get the new view controller using segue.destinationViewController.
            let svc = segue.destinationViewController as! OperatorTableViewController
            
            // Pass the selected object to the new view controller.
            svc.theAddedOperator = operatorName.text!
            svc.didAddOperator = 1;
            svc.operators = operatorList!
    }
}
