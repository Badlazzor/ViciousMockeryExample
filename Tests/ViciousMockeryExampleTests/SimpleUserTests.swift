import Nimble
import Quick
import Prestidigitation
import ViciousMockery

@testable import ViciousMockeryExample

final class SimpleUserSpec: QuickSpec {
    override func spec() {
        describe("SimpleUser") {
            var sut: SimpleUser!
            var simple: Mock.Simple!

            beforeEach {
                simple = .init()
                sut = .init(simple: simple)
            }

            describe("checkIfThingsHappened") {
                beforeEach {
                    simple.thingsHappenedGetterStub = .init { true }
                }

                it("checks it's simple dependency to tell if things happened") {
                    expect(sut.checkIfThingsHappened()).to(beTruthy())
                    expect(simple.thingsHappenedGetterStub.callCount).to(equal(1))
                }
            }

            describe("makeThingsHappen") {
                enum TestError: Error {
                    case theOneAndOnly
                }
                var thingy: Thingy!

                beforeEach {
                    thingy = MockDataBuilder.Thingy()
                        .with(\.partA, "Kitty")
                        .with(\.partB, 10)
                        .with(\.partC, true)
                        .build()

                    simple.doThingsStub = .init { _ in true }
                }

                it("returns what the simple dependency gives from doThigns for 0 as a condition") {
                    expect(try sut.makeThingsHappen(with: thingy)).to(beTruthy())
                    expect(simple.doThingsStub.inputs == [(thingy, 0)]).to(beTruthy())
                }

                context("when doThings throws") {
                    beforeEach {
                        simple.doThingsStub = .init { _ in throw TestError.theOneAndOnly }
                    }

                    it("rethrows the received error") {
                        expect(try sut.makeThingsHappen(with: thingy)).to(throwError(TestError.theOneAndOnly))
                        expect(simple.doThingsStub.inputs == [(thingy, 0)]).to(beTruthy())
                    }
                }

                context("showcasing stub and builder power") {
                    beforeEach {
                        simple.doThingsStub = .init { thingy, condition in
                            switch (thingy.partB, condition, thingy.partC) {
                            case (_, _, false):
                                throw TestError.theOneAndOnly

                            case (let a, let b, _):
                                return a == b
                            }
                        }
                    }

                    it("shines") {
                        expect(
                            try sut.makeThingsHappen(
                                with: MockDataBuilder.Thingy()
                                    .with(\.partB, 0)
                                    .with(\.partC, true)
                                    .build()
                            )
                        ).to(beTruthy())


                        expect(
                            try sut.makeThingsHappen(
                                with: MockDataBuilder.Thingy()
                                    .with(\.partB, 1)
                                    .with(\.partC, true)
                                    .build()
                            )
                        ).to(beFalsy())

                        expect(
                            try sut.makeThingsHappen(
                                with: MockDataBuilder.Thingy()
                                    .with(\.partB, 0)
                                    .with(\.partC, false)
                                    .build()
                            )
                        ).to(throwError(TestError.theOneAndOnly))
                    }
                }
            }
        }
    }
}
