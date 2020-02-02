//
//  MainTableViewContoller.swift
//  DeepCare-iOS
//
//  Created by Param Bole on 2/1/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import UIKit

class MainTableViewContoller: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var personList = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setDummy()
        tableView.reloadData()
    }
    
    func setDummy() {
        let person1 = Person(name: "Elon Musk", image: "elonmusk")
        personList.append(person1)
        let person2 = Person(name: "Grandma", image: "grandma")
        personList.append(person2)
        let person3 = Person(name: "Uncle", image: "uncle")
        personList.append(person3)
        let person4 = Person(name: "Kevin Hart", image: "kevinhart")
        personList.append(person4)
        let person5 = Person(name: "Grandpa", image: "grandpa")
        personList.append(person5)
        let person6 = Person(name: "Aunt", image: "aunt")
        personList.append(person6)
    }
}

extension MainTableViewContoller: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO understand how to return count
        return personList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.configuration(personList[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

extension MainTableViewContoller: TalkerTableViewCellDelegate {
    func talkerInformation(_ tableViewCell: TableViewCell, button: String, talker: Person) {
        if button == "Video" {
            let videoVC = UIStoryboard.init(name: "MainVideoCall", bundle: nil).instantiateInitialViewController() as? MainVideoCallViewController
            if let vc = videoVC {
                vc.data = talker
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            let phoneVC = UIStoryboard.init(name: "MainPhoneCall", bundle: nil).instantiateInitialViewController() as? MainPhoneCallViewController
            if let vc = phoneVC {
                vc.data = talker
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
