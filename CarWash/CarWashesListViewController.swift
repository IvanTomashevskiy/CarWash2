

import UIKit
import YandexMapKit
import YandexMapKitSearch
class CarWashesList: UIViewController{
    @IBOutlet weak var washes: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        washes.delegate = self
        washes.dataSource = self
    }

}

extension CarWashesList: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension CarWashesList: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avt.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = aref[indexPath.row]
        return cell
    }
}
