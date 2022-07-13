import SwiftUI

/// List of all workouts the user has input, with data being loaded and saved using the WorkoutStore object.
///
/// - Properties:
///     - workouts: A binding for the array of workouts, passed from the WorkoutStore object.
///     - scenePhase: An environment variable declaring the current state of the scene.
///     - saveAction: A closure with no inputs or return values. This is the WorkoutStore's save function.
struct WorkoutListView: View {
    @Binding var workouts: [Workout]
    @Environment(\.scenePhase) private var scenePhase
    
    let saveAction: ()->Void
    var body: some View {
        List {
            ForEach($workouts) {$workout in
                NavigationLink(destination: WorkoutView(workout: $workout)) {
                    WorkoutCardView(workout: $workout, workouts: $workouts) // All the workouts are passed to sort them by date after a workout is edited
                }
            }
            .onDelete(perform: deleteWorkout)
        }
        .navigationTitle("Your Workouts")
        .navigationBarItems(leading: EditButton()
                            ,trailing:
                                Button(action: {
            workouts.append(Workout())
            workouts = workouts.sorted(by: {$0.date > $1.date}) // Sort the workouts by date whenever a new one is added with today's date
        }) {
            Image(systemName: "plus")
        }
        )
        .onChange(of: scenePhase) {phase in
            if phase == .inactive { saveAction() } // Save the workout data whenever the app scene becomes inactive
        }
    }
    
    /// Delete a workout from the array (delete inplace) of workouts using swipe to delete.
    ///
    /// - Parameters:
    ///     - atOffsets: The positions within the workout array to delete at.
    /// - Returns: Does not return anything
    func deleteWorkout(at offsets: IndexSet) {
        workouts.remove(atOffsets: offsets)
    }
}

/// Preview WorkoutListView in XCode.
struct WorkoutListView_Preview: PreviewProvider {
    static var previews: some View {
        WorkoutListView(workouts: .constant(Workout.sampleWorkouts), saveAction: {})
    }
}
