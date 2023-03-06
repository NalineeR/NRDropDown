
# NRDropDown

In this version of DropDown you can add a drop easily with following types - 
1. Left selection (you can provide your custom icon)
2. Right selection (you can provide your custom icon)
3. Selection background (you can provide your custom Background colour for selection).



## Authors

- [@NalineeR](https://github.com/NalineeR)


## Demo

Insert gif or link to demo


## Feedback

If you have any feedback, please reach out to us at fake@fake.com


## Features

- Left selection icon
- Right selection icon
- Selection color
- Easy to customise everything. Be it - the selection icons, color or font. 



## 🚀 About Me
iOS Developer


## 🔗 Links
GitHub - https://github.com/NalineeR
## Installation

Install my-project with npm

```bash
  npm install my-project
  cd my-project
```
    
![Logo](https://drive.google.com/file/d/1vld-WuJXGHSsq0BIhpQjEx1WbUEIHVjR/view?usp=share_link)


## Usage/Examples

import UIKit
import NRDropDown

class ViewController: UIViewController {
    @IBOutlet weak var btn:UIButton!
    var selectedIndex:Int? = nil
    var dropDownObj:NRDropDownHelper? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnTapped(sender:UIButton){
        dropDownObj = NRDropDownHelper(delegateObj: self, dataSource: ["Swift","SwiftUI"], anchorV: btn, selectedIndex: selectedIndex, selectionHandler: { [weak self] index in
            self?.selectedIndex = index
        })
        dropDownObj?.cellProperties.cellType = .selectedBackground
        dropDownObj?.cellProperties.selectedBGColor = .lightText
        dropDownObj?.cellHeight = 30
        dropDownObj?.show()
    }}
```


## Support

For support, email fake@fake.com or join our Slack channel.

