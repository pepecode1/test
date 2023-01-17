//
//  ViewCell.swift
//  Prueba
//
//  Created by Pepe Ruiz on 17/01/23.
//

import Kingfisher
import UIKit

class ViewCell: UITableViewCell {
    @IBOutlet weak var imageVw: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    func configure(_ model: Items) {
        imageVw.kf.setImage(with: URL(string: model.image))
        title.text = model.name
        subtitle.text = String(model.price)
    }
}
