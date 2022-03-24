

import UIKit
import WebKit

class NextView: UIViewController {
    
    var webViewStr: String!
    
    @IBOutlet weak var myWebView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let myUrl = URL(string: webViewStr)
        let request = URLRequest(url: myUrl!)
        myWebView.load(request)
        
    }

}
