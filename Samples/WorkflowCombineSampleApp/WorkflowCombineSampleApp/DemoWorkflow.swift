//
//  DemoWorkflow.swift
//  WorkflowCombineSampleApp
//
//  Created by Soo Rin Park on 10/28/21.
//

import Workflow
import WorkflowUI

// MARK: Input and Output

let dateFormatter = DateFormatter()

struct DemoWorkflow: Workflow {
    typealias Output = Never
}

// MARK: State and Initialization

extension DemoWorkflow {
    struct State {
        var date: Date
    }

    func makeInitialState() -> DemoWorkflow.State { State(date: Date()) }

    func workflowDidChange(from previousWorkflow: DemoWorkflow, state: inout State) {}
}

// MARK: Actions

extension DemoWorkflow {
    struct Action: WorkflowAction {
        typealias WorkflowType = DemoWorkflow

        let publishedDate: Date

        func apply(toState state: inout DemoWorkflow.State) -> DemoWorkflow.Output? {
            state.date = publishedDate
            return nil
        }
    }
}

// MARK: Rendering

extension DemoWorkflow {
    // TODO: Change this to your actual rendering type
    typealias Rendering = DemoScreen

    func render(state: DemoWorkflow.State, context: RenderContext<DemoWorkflow>) -> Rendering {
        DemoWorker()
            .rendered(in: context)

        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        let formattedDate = dateFormatter.string(from: state.date)
        let rendering = Rendering(date: formattedDate)

        return rendering
    }
}

struct DemoScreen: Screen {
    let date: String

    func viewControllerDescription(environment: ViewEnvironment) -> ViewControllerDescription {
        DemoViewController.description(for: self, environment: environment)
    }
}
