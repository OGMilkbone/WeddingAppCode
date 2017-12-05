//
//  MessageViewController.swift
//  FarceBookTheApp
//
//  Created by jwilson on 11/14/17.
//  Copyright © 2017 jwilson. All rights reserved.
//
import Foundation
import UIKit

class MessageViewController: UIViewController {
    
    var messages: [Message] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        Network.shared.getMessages(){ (messages) in
            DispatchQueue.main.async {
                self.messages = messages
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let destination = segue.destination as? RecipieViewController else { return }
//        guard let source = sender as? RecipieCell else { return }
//        destination.recipie = source.recipie
//    }
    
}

extension MessageViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        cell.message = message
        return cell
    }
    
}

