//
//  CostomLayout.swift
//  GalaxyWars
//
//  Created by Alice Krutienko on 20.01.2021.
//

import UIKit

protocol CustomLayoutDelegate: class {
     func theNumberOfItemsInCollectionView() -> Int
}

extension CustomLayoutDelegate {
    func heightForContentInItem(inCollectionView collectionView: UICollectionView, at indexPath: IndexPath) -> CGFloat {
        return 0
    }
}

class CustomLayout: UICollectionViewLayout {
    fileprivate var numberOfColumns = 3
    fileprivate var cellPadding: CGFloat = 6
    fileprivate let cellHeight: CGFloat = 150

    weak var delegate: CustomLayoutDelegate?

    fileprivate var cache = [UICollectionViewLayoutAttributes]()

    fileprivate var contentHeight: CGFloat = 0
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {return 0}
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func prepare() {
        
        guard cache.isEmpty == true, let collectionView = collectionView else {return}

        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()

        for column in 0..<numberOfColumns {

            if column == 0 {
                 xOffset.append(0)
            }
            if column == 1 {
                 xOffset.append(2 * columnWidth)
            }
            if column == 2
            {
                 xOffset.append( columnWidth)
            }
        }

        var column = 0
        var yOffset = [CGFloat]()

        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)

            for column in 0..<numberOfColumns {
                switch column {
                case 0:
                    yOffset.append(2 * cellPadding)
                case 1:
                    yOffset.append(2 * cellPadding)
                case 2:

                    yOffset.append(cellPadding + cellHeight)
                default:
                    break
                }
            }

            let height = cellPadding * 2 + cellHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: columnWidth)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            print ("frame.maxY", frame.maxY)

            contentHeight = max(collectionView.frame.height + 10, frame.maxY)

            yOffset[column] = yOffset[column] + 2 * (height - cellPadding)

            let numberOfItems = delegate?.theNumberOfItemsInCollectionView()

            if let numberOfItems = numberOfItems, indexPath.item == numberOfItems - 1
            {

                print ("indexPath.item: \(indexPath.item), numberOfItems: \(numberOfItems)")
                print ("A")
                switch column {
                case 0:
                    column = 2
                case 2:
                    column = 0
                case 1:
                    column = 2
                default:
                    return
                }
            } else  {
                print ("B")
                column = column < (numberOfColumns - 1) ? (column + 1) : 0
            }
        }

    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()

        for attribute in cache {
            if attribute.frame.intersects(rect) {
                visibleLayoutAttributes.append(attribute)
            }
        }

        return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
