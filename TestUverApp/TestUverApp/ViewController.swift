

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    let baseUrl = "https://pixabay.com/api/?key=17617424-ce248788983e8785377ef6493&q="
    
    var myApiArray: [[String: Any]] = [] {
        
        didSet {
            
            myTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.transform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: 0)
        
        myTableView.beginUpdates()
        myTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        myTableView.endUpdates()
        
        getApi()
        
    }
    
    func getApi() {
        
        guard let url = URL(string: baseUrl) else {return}
        
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
                
                guard let items = json["hits"] as? Array<[String: Any]> else {return}
                
                DispatchQueue.main.async {
                    () -> Void in
                    
                    self.myApiArray = items
                    
                }
                
            } catch {
                
                print(error)
            }
        })
        
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myApiArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell") as! MyTableViewCell
        
        let tableArray = myApiArray[indexPath.row]
        
        cell.myTableViewCellLabel.text = tableArray["tags"] as? String
        
        let imageStr = tableArray["webformatURL"] as! String
        let imageUrl = URL(string: imageStr)!
        
        do {
            
            let data = try Data(contentsOf: imageUrl)
            let image = UIImage(data: data)
            cell.myTableViewCellImageView.image = image
            
        } catch {
            
            print("error")
        }
        
        cell.transform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: 0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextWebView = self.storyboard?.instantiateViewController(identifier:"NextView") as! NextView
        nextWebView.webViewStr = myApiArray[indexPath.row]["webformatURL"] as? String
        
        self.present(nextWebView, animated: true, completion: nil)
    }
    
    
}

