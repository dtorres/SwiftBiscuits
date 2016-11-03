private struct RelativeIterator<BaseElement>: IteratorProtocol {
    
    typealias RelativeTuple = (prev: BaseElement?, current: BaseElement, next: BaseElement?)
    var previous: BaseElement? = nil
    var nextElement: BaseElement?
    let nextClosure: () -> BaseElement?
    init<IteratorType: IteratorProtocol>(iterator: IteratorType) where IteratorType.Element == BaseElement {
        var iterator = iterator
        nextClosure = {
            return iterator.next()
        }
        nextElement = iterator.next()
        
    }
    
    mutating func next() -> RelativeTuple? {
        guard let current = nextElement else { return nil }
        let next = nextClosure()
        let tuple: RelativeTuple = (previous, current, next)
        
        previous = current
        nextElement = next
        
        return tuple
    }
}

extension Sequence {
    typealias RelativeTuple = (prev: Iterator.Element?, current: Iterator.Element, next: Iterator.Element?)
    
    func relativeIterator() -> AnyIterator<RelativeTuple> {
        let iterator = RelativeIterator(iterator: self.makeIterator())
        let typeErasedIterator = AnyIterator(iterator)
        return typeErasedIterator
    }
}

extension Sequence {
    
    /**
     Calls the given closure for each element with the previous and next elements for relative context
     
     - Parameters:
        - closure: A closure called for every item in the sequence
        - previous: The previous element
        - current: The current element
        - next: The next element
     - complexity: O(n)
    */
    func relativeEach( _ closure: (_ previous: Iterator.Element?, _ current: Iterator.Element, _ next: Iterator.Element?) -> Void) {
        var iterator = self.makeIterator()
        var previous: Iterator.Element? = nil
        var nextElement: Iterator.Element? = iterator.next()
        
        while let current = nextElement {
            let next = iterator.next()
            
            closure(previous, current, next)
            
            previous = current
            nextElement = next
        }
    }
}
