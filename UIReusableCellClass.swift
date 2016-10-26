import UIKit

protocol reuseIdentifierClass: class {
    static var reuseIdentifier: String { get }
}

extension UICollectionView {
    func registerClass<T: UICollectionViewCell where T: reuseIdentifierClass>(aClass: T.Type) {
        registerClass(aClass, forCellWithReuseIdentifier: aClass.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell where T: reuseIdentifierClass>(with aClass: T.Type, forIndexPath indexPath: NSIndexPath) -> T {
        return dequeueReusableCellWithReuseIdentifier(aClass.reuseIdentifier, forIndexPath: indexPath) as! T
    }
}

extension UITableView {
    func registerClass<T: UITableViewCell where T: reuseIdentifierClass>(aClass: T.Type) {
        registerClass(aClass, forCellReuseIdentifier: aClass.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell where T: reuseIdentifierClass>(with aClass: T.Type, forIndexPath indexPath: NSIndexPath) -> T {
        return dequeueReusableCellWithIdentifier(aClass.reuseIdentifier, forIndexPath: indexPath) as! T
    }
}
