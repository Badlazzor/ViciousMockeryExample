import ViciousMockery
import Prestidigitation

@testable import ViciousMockeryExample

extension MockDataBuilder {
    public final class Thingy: Builder<ViciousMockeryExample.Thingy>, MockDataBuilding {
        public func build() -> ViciousMockeryExample.Thingy {
            Built.init(
                partA: value(of: \.partA, defaultValue: ""),
                partB: value(of: \.partB, defaultValue: 0),
                partC: value(of: \.partC, defaultValue: false)
            )
        }
    }
}
