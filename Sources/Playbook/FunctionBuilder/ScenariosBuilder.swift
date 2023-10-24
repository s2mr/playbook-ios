/// The custom parameter attribute that constructs scenarios from multi-statement closures.
@resultBuilder
public struct ScenariosBuilder: ScenariosBuildable {
    public var _buildScenarios: () -> [Scenario]

    /// Creates a new builder with given closure.
    ///
    /// - Parameters:
    ///   - buildScenarios: A closure that to build an array of scenarios.
    public init(_ buildScenarios: @escaping () -> [Scenario]) {
        self._buildScenarios = buildScenarios
    }

    /// Builds an array of scenarios.
    public func buildScenarios() -> [Scenario] {
        _buildScenarios()
    }

    /// Returns a builder instance to build a given scenarios.
    /// - Parameters:
    ///   - scenarios: A set of scenarios to be constructed.
    public static func buildBlock(_ scenarios: ScenariosBuildable...) -> ScenariosBuilder {
        buildArray(scenarios)
    }

    public static func buildArray(_ scenarios: [ScenariosBuildable]) -> ScenariosBuilder {
        ScenariosBuilder {
            scenarios.flatMap { $0.buildScenarios() }
        }
    }
}
