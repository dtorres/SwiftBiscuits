extension Sequence {
    typealias Element = Iterator.Element
    
    /**
     Calls the given closure for each element with the previous and next elements for relative context
     
     - Parameters:
        - closure: A closure called for every item in the sequence
        - previous: The previous element
        - current: The current element
        - next: The next element
     - complexity: O(n)
    */
    func relativeEach( _ closure: (_ previous: Element?, _ current: Element, _ next: Element?) -> Void) {
        var iterator = self.makeIterator()
        var previous: Element? = nil
        var nextElement: Element? = iterator.next()
        
        while let current = nextElement {
            let next = iterator.next()
            
            closure(previous, current, next)
            
            previous = current
            nextElement = next
        }
    }
}
