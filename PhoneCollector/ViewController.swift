//
//  ViewController.swift
//  PhoneCollector
//
//  Created by Jernej Hartman on 06/04/2017.
//  Copyright © 2017 B0nty. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var phones: [Phones] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
        phones = try context.fetch(Phones.fetchRequest())
            tableView.reloadData()
        } catch {
        
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phones.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let phone = phones[indexPath.row]
        cell.textLabel?.text = phone.model
        cell.imageView?.image = UIImage(data: phone.image! as Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let phone = phones[indexPath.row]
        performSegue(withIdentifier: "phoneSegue", sender: phone)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! addPhoneViewController
        nextVC.phone = sender as? Phones
        
    }
}

