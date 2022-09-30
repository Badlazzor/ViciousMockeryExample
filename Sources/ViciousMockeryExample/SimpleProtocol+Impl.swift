protocol Simple {
    var thingsHappened: Bool { get set }
    func doThings(with thingy: Thingy, when condition: Int) throws -> Bool
}

struct Thingy: Equatable {
    let partA: String
    let partB: Int
    let partC: Bool
}

final class SimpleImpl: Simple {
    var thingsHappened: Bool = false

    func doThings(with thingy: Thingy, when condition: Int) throws -> Bool {
        true
    }
}

final class SimpleUser {
    let simple: Simple

    init(simple: Simple) {
        self.simple = simple
    }

    func checkIfThingsHappened() -> Bool {
        simple.thingsHappened
    }

    func makeThingsHappen(with input: Thingy) throws -> Bool {
        try simple.doThings(with: input, when: 0)
    }
}
