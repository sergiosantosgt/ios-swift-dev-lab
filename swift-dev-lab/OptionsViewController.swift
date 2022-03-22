//
//  OptionsViewController.swift
//  swift-dev-lab
//
//  Created by Sergio Roberto dos Santos Junior on 05/03/22.
//

import Foundation
import UIKit

class OptionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var options = Array<String>()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        options.append("Service (Address Search)")
        options.append("WebView")
        options.append("Biometric")
        options.append("Custom Layout (.xib)")
        options.append("Alerts")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let optionsCount = options.count
        
        if optionsCount == 0 {
            cell.textLabel?.text = "Nenhuma informação para exibir "
        } else {
            let option = options[indexPath.row]
            cell.textLabel?.text = option
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: getSegueIdentifier(index: indexPath.row), sender: options[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let svc = segue.destination as! ViewController
//        svc.someString = sender as! String
    }
    
    public func getSegueIdentifier(index: Int) -> String {
        var str: String
        
        switch index {
        case 0:
            str = "showAddressSearch"
        case 1:
            str = "showWebView"
        case 2:
            str = "showBiometric"
        case 3:
            str = "showXibCustomLayout"
        case 4:
            str = "showAlertView"
            
        default:
            fatalError("Invalid Option!")
        }
        
        return str
    }
    
}
