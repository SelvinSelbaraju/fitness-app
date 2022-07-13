import SwiftUI

/// Entrypoint for the App denoted by @main. This is root file of the application build.
///
/// - Properties:
///     - store: WorkoutStore object which loads / saves workout data. The WorkoutListView uses the workout data to render the workouts.
@main
struct fitness_appApp: App {
    @StateObject private var store = WorkoutStore()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                WorkoutListView(workouts: $store.workouts) {
                    WorkoutStore.save(workouts: store.workouts) {result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
            }
            .onAppear {
                WorkoutStore.load {result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let workouts):
                        store.workouts = workouts
                    }
                }
            }
        }
    }
}
