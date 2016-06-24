//
//  PlanetCollectionViewController.swift
//  Planned
//
//  Created by Quinn McHenry on 12/2/15.
//  Copyright (c) 2015 Small Planet Digital. All rights reserved.
//


public protocol PlanetCollectionViewTemplate {
    var reuseId: String { get }
    var size: TemplateSize { get }
    func decorate(cell: UICollectionViewCell)
}

public struct TemplateSize: OptionSetType {
    public let rawValue: Int
    
    public static let FullHeight = TemplateSize(rawValue: 1 << 0)
    public static let FullWidth = TemplateSize(rawValue: 1 << 1)
    public static let HalfWidth = TemplateSize(rawValue: 1 << 2)
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}


public protocol PlanetCollectionViewCell: class {
    var bundlePath: String { get }
    var xmlView: View? { get set }
    func loadView()
}

public extension PlanetCollectionViewCell where Self: UICollectionViewCell {
    
    func loadView() {
        guard xmlView == nil else { return }
        
        xmlView = PlanetUI.readFromFile(String(bundlePath: bundlePath)) as? View
        guard let xmlView = xmlView else {
            // failed to create xml view from bundlePath \(bundlePath)
            return
        }
        contentView.addSubview(xmlView.view)
        xmlView.visit() { $0.gaxbDidPrepare() }
        
        addConstraint(NSLayoutConstraint(item: xmlView.view, toItem: contentView, equalAttribute: .Width))
        addConstraint(NSLayoutConstraint(item: xmlView.view, toItem: contentView, equalAttribute: .Height))
        addConstraint(NSLayoutConstraint(item: xmlView.view, toItem: contentView, equalAttribute: .Left))
        addConstraint(NSLayoutConstraint(item: xmlView.view, toItem: contentView, equalAttribute: .Top))
        xmlView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
}


public class PlanetCollectionViewController: PlanetViewController {
    
    @IBOutlet weak public var collectionView: UICollectionView!
    public var cellReferences = [String: PlanetCollectionViewCell]()
    public var cellMapping: [String: PlanetCollectionViewCell.Type] { return [:] }
    public var cellSizes: [[CGSize]] = []
    public var objects: [[PlanetCollectionViewTemplate]] = [] {
        didSet {
            cellSizes.removeAll(keepCapacity: false)
            for subarray in objects {
                cellSizes.append([CGSize](count:subarray.count, repeatedValue: CGSizeZero))
            }
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        collectionView.contentOffset = CGPointZero
    }
    
    public func configureCollectionView() {
        for (cellId, cellClass) in cellMapping {
            collectionView?.registerClass(cellClass, forCellWithReuseIdentifier: cellId)
        }
        collectionView?.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: false)
    }
    
    // MARK: - Collection View Cell Handling
    
    public func configure(cell: PlanetCollectionViewCell?, atIndexPath indexPath: NSIndexPath) {
        cell?.loadView()
        guard let xmlView = cell?.xmlView,
            template = cellObject(indexPath),
            cell = cell as? UICollectionViewCell
            else { return }
        if template.size.contains(.FullWidth) {
            let insets = collectionView(collectionView, layout: collectionView.collectionViewLayout, insetForSectionAtIndex: indexPath.section)
            let constraint = NSLayoutConstraint(item: xmlView.view, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: collectionView.frame.size.width - insets.left - insets.right)
            xmlView.view.addConstraint(constraint)
        }
        if template.size.contains(.HalfWidth) {
            let insets = collectionView(collectionView, layout: collectionView.collectionViewLayout, insetForSectionAtIndex: indexPath.section)
            let constant = (collectionView.frame.size.width - insets.left - insets.right - max(insets.right, insets.left)) / 2
            let constraint = NSLayoutConstraint(item: xmlView.view, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1, constant: floor(constant))
            xmlView.view.addConstraint(constraint)
        }
        if template.size.contains(.FullHeight) {
            let insets = collectionView(collectionView, layout: collectionView.collectionViewLayout, insetForSectionAtIndex: indexPath.section)
            let constraint = NSLayoutConstraint(item: xmlView.view, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: collectionView.frame.size.height - insets.top - insets.bottom)
            xmlView.view.addConstraint(constraint)
        }
        cell.contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func cellMapping(reuseId: String) -> PlanetCollectionViewCell.Type? {
        return cellMapping[reuseId]
    }
    
    public func reuseIdentifier(indexPath:NSIndexPath) -> String {
        guard let reuseId = cellObject(indexPath)?.reuseId else {
            // cell template not found
            return ""
        }
        return reuseId
    }
    
    public func cellObject(indexPath: NSIndexPath) -> PlanetCollectionViewTemplate? {
        return objects[indexPath.section][indexPath.row]
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    public func cellSize(indexPath: NSIndexPath) -> CGSize? {
        return cellSizes[indexPath.section][indexPath.row]
    }
    
    public func setCellSize(size: CGSize, forIndexPath indexPath:NSIndexPath) {
        cellSizes[indexPath.section][indexPath.row] = size
    }
    
    public func cellHeight(indexPath: NSIndexPath) -> CGFloat? {
        return (cellSize(indexPath) ?? CGSizeZero).height
    }
    
    public func setCellHeight(height: CGFloat, forIndexPath indexPath: NSIndexPath) {
        if let size = cellSize(indexPath) {
            setCellSize(CGSizeMake(size.width, height), forIndexPath:indexPath)
        }
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var size = cellSize(indexPath) ?? CGSizeZero
        if let template = cellObject(indexPath) where size == CGSizeZero {
            let reuseId = reuseIdentifier(indexPath)
            
            var cellReference: PlanetCollectionViewCell? = cellReferences[reuseId]
            if cellReference == nil {
                if let cellReferenceType = cellMapping(reuseId) as? UICollectionViewCell.Type {
                    cellReference = cellReferenceType.init() as? PlanetCollectionViewCell
                }
                configure(cellReference!, atIndexPath: indexPath)
                cellReferences[reuseId] = cellReference
            }
            configure(cellReference!, atIndexPath: indexPath)
            template.decorate(cellReference as! UICollectionViewCell)
            
            let xmlView = cellReference?.xmlView
            size = xmlView?.view.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize) ?? CGSizeZero
            setCellSize(size, forIndexPath: indexPath)
        }
        return size
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: section == 0 ? 64 : 0, left: 0, bottom: 0, right: 0)
    }
    
}

extension PlanetCollectionViewController: UICollectionViewDataSource {
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return objects.count
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects[section].count
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier(indexPath), forIndexPath: indexPath)
        configure(cell as? PlanetCollectionViewCell, atIndexPath: indexPath)
        cellObject(indexPath)?.decorate(cell)
        return cell
    }
    
}

extension PlanetCollectionViewController: UICollectionViewDelegate {
    
    public func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.cellForItemAtIndexPath(indexPath)?.highlighted = true
    }
    
    public func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.cellForItemAtIndexPath(indexPath)?.highlighted = false
    }
    
}
