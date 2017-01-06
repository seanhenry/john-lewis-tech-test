import UIKit

class DetailsCell: UICollectionViewCell {

    @IBOutlet private var detailsLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        detailsLabel.text = nil
    }

    func setText(_ text: String) {
        guard let data = text.data(using: .utf8) else { return }
        let attributes: [String: Any] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: NSNumber(value: String.Encoding.utf8.rawValue)
        ]
        if let string = try? NSAttributedString(data: data, options: attributes, documentAttributes: nil) {
            detailsLabel.attributedText = string
        }
    }
}
