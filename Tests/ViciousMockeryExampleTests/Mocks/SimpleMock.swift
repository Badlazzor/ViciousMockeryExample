import ViciousMockery
@testable import ViciousMockeryExample

extension Mock {
    public final class Simple: ViciousMockeryExample.Simple {
        // Make separate getter and setter stub for variables
        public var thingsHappenedGetterStub: Stub<Void, Bool> = .init()
        public var thingsHappenedSetterStub: Stub<Bool, Void> = .init()
        public var thingsHappened: Bool {
            get { thingsHappenedGetterStub.invoke() }
            set { thingsHappenedSetterStub.invoke(with: newValue) }
        }

        // Use `tryInvoke` when stubbing a throwing function, so oyu can test the thrown errors as well
        public var doThingsStub: Stub<(Thingy, Int), Bool> = .init()
        public func doThings(with thingy: Thingy, when condition: Int) throws -> Bool {
            try doThingsStub.tryInvoke(with: (thingy, condition))
        }
    }
}
