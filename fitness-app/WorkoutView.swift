import SwiftUI

/// The view for each workout, which comprises of the exercises and sets which took place in it.
///
/// - Properties:
///     - workout: A binding to a Workout object, which reflects changes in parent views when each individual Workout object changes.
struct WorkoutView: View {
    @Binding var workout: Workout
    
    var body: some View {
        List {
            ForEach($workout.exercises.indices, id: \.self) {i in
                ExerciseView(workout: $workout, exercise: $workout.exercises[i], exercisePosition: i) // Exercise position used to help delete them
            }
            Button("New Exercise") {
                workout.exercises.append(Workout.Exercise(name: "New Exercise", sets: []))
            }
        }
        .navigationTitle(workout.name)
    }
}

/// Preview WorkoutView in XCode.
struct WorkoutView_Preview: PreviewProvider {
    static var previews: some View {
        WorkoutView(workout: .constant(Workout.sampleWorkouts[0]))
    }
}
