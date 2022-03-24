

import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myTableViewCellLabel: UILabel!
    @IBOutlet weak var myTableViewCellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
