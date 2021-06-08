//
//  UIImage+Mandala.swift
//  Mandala
//
//  Created by Alberto Silva on 08/06/21.
//

import UIKit

enum ImageResource: String {
    case angry
    case confused
    case crying
    case goofy
    case happy
    case meh
    case sad
    case sleepy
}

extension UIImage{
    convenience init(resource: ImageResource){
        self.init(named: resource.rawValue)!
    }
}
