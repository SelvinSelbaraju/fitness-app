import SwiftUI

/// Used to edit the weight in kilograms, number of reps and rest time in seconds of an exercise set.
/// 
/// - Properties:
///     - isPresentingChangeView: A binding used to tell the exercise view to stop presenting this view.
///     - set: A binding for the set which is being changed.
struct ChangeSetView: View {
    @Binding var isPresentingChangeView: Bool
    @Binding var set: Workout.ExerciseSet
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Weight in KG")
                TextField("Weight in KG", value: $set.weightInKG, format: .number)
                Text("Number of Reps")
                TextField("Number of Reps", value: $set.noReps, format: .number)
                Text("Rest Time in Seconds")
                TextField("Rest Time in Seconds", value: $set.restTimeInSeconds, format: .number)
            }
        }
    }
}

/// Previews ChangeSetView in XCode.
struct ChangeSetView_Preview: PreviewProvider {
    static var exampleSet: Workout.ExerciseSet = Workout.sampleWorkouts[0].exercises[0].sets[0]
    static var previews: some View {
        ChangeSetView(isPresentingChangeView: .constant(true), set: .constant(Workout.sampleWorkouts[0].exercises[0].sets[0]))
    }
}
