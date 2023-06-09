//
//  QuoteListCell.swift
//  Technical-test
//
//

import UIKit


protocol QuoteListCellDelegate: AnyObject {
    func favouriteProcess(with model: Quote)
}


final class QuoteListCell: UITableViewCell {

    static let reuseID = "QuoteListCell"
    private var model: Quote?
    weak var delegate: QuoteListCellDelegate?
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var percentLabel: UILabel!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        favButton.addTarget(self,action: #selector(handleNext(sender:)), for: .touchUpInside)
        favButton.setTitle("", for: .normal)
    }

    func setup(model: Quote) {
        self.model = model
        topLabel.text = model.name
        bottomLabel.text = model.last + " " + model.symbol
        percentLabel.text = model.readableLastChangePercent
        percentLabel.textColor = model.percentColor
        favButton.setImage(model.favouriteImage, for: .normal)
    }
    
    @objc
    private func handleNext(sender: UIButton) {
        if let model = model {
            delegate?.favouriteProcess(with: model)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favButton.setImage(nil, for: .normal)
    }
    
}
