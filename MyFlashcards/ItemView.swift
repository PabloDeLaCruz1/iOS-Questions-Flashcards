//
//  ItemView.swift
//  MyFlashcards
//
//  Created by Pablo De La Cruz on 3/1/22.
//

import UIKit

class ItemView: UIView {
    var label: UILabel?


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect, imageName: String, labelText: String) {
        self.init(frame: frame)

        UIGraphicsBeginImageContext(self.frame.size)
        UIImage(named: imageName)?.draw(in: self.bounds)

        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            self.backgroundColor = UIColor(patternImage: image)
        } else {
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
        }

//        self.backgroundColor = backgroundcolor

//        self.backgroundColor = backgroundcolor
        self.contentMode = .scaleAspectFit

        label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
        label!.numberOfLines = 20

        label!.textAlignment = NSTextAlignment.center
        label!.textColor = UIColor.white
        label?.center = self.center

        label!.text = labelText

        self.addSubview(label!)



    }



}
