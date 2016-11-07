import UIKit
import Result

class ViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        APIClient()
            .fetchContent()
            .onSuccess { content in
                self.messageLabel.text = content
            }.onFailure { error in
                print(error)
            }
    }

}

