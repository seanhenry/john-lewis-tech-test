import UIKit

class ProductDetailLayout: UICollectionViewFlowLayout {

    var orientation: UIInterfaceOrientation = .portrait {
        didSet { invalidateLayout() }
    }

    private var collectionViewWidth: CGFloat {
        return collectionView?.frame.width ?? 0
    }

    private var landscapeXOffset: CGFloat {
        return landscapeLeftColumnWidth
    }

    private var landscapeLeftColumnWidth: CGFloat {
        return collectionViewWidth * 0.7
    }

    private var landscapeRightColumnWidth: CGFloat {
        return collectionViewWidth * 0.3
    }
    
    override func invalidateLayout() {
        itemSize = CGSize(width: collectionViewWidth, height: itemSize.height)
        super.invalidateLayout()
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard var attributes = super.layoutAttributesForElements(in: rect),
              !attributes.isEmpty else { return nil }
        if UIInterfaceOrientationIsPortrait(orientation) {
            return attributes
        }
        let section0Height = height(forSection: 0, from: attributes)
        let section1Height = height(forSection: 1, from: attributes)
        attributes = attributes.map { a in
            var frame = a.frame
            frame.size.width = landscapeLeftColumnWidth
            if a.indexPath.section > 1 {
                frame.origin.y -= section1Height
            } else if a.indexPath.section == 1 {
                frame.origin.x = landscapeXOffset
                frame.origin.y -= section0Height
                frame.size.width = landscapeRightColumnWidth
            }
            a.frame = frame
            return a
        }
        return attributes
    }

    private func height(forSection section: Int, from attributes: [UICollectionViewLayoutAttributes]) -> CGFloat {
        let sectionAttributes = attributes.filter { $0.indexPath.section == 1 }
        let maxY = sectionAttributes.max { a, b in
            return a.frame.maxY < b.frame.maxY
        }?.frame.maxY ?? 0
        let minY = sectionAttributes.min { a, b in
            return a.frame.minY < b.frame.minY
        }?.frame.minY ?? 0
        return maxY - minY
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return super.layoutAttributesForItem(at: indexPath)
    }
}
