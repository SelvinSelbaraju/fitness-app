import SwiftUI

/// View for displaying workout details for each object in the Workout array.
///
/// - Properties:
///     - isPresentingChangeWorkoutView: A state variable for whether to display the view for changing the workout detaills.
///     - newWorkout: A state variable for the Workout object which is used to update the Workout array whenever a workout is changed. Needs to be done seperate from the binding otherwise if the user edits the workout and cancels it, the changes to the workout are still made.
///     - workout: A binding to the Workout object being displayed on the card, so that any edits are reflected in the Workouts array.
///     - workouts: A binding to the Workout array so that the Workout objects can be sorted by date after workout date changes.
struct WorkoutCardView: View {
    @State var isPresentingChangeWorkoutView: Bool = false
    @State var newWorkout: Workout = Workout.sampleWorkouts[0]
    
    @Binding var workout: Workout
    @Binding var workouts: [Workout] // here for sorting by date
    
    var body: some View {
        VStack {
            HStack {
                Text(workout.name).font(Font.headline.weight(.bold))
                Button(action: {
                    newWorkout = workout
                    isPresentingChangeWorkoutView = true
                }) {
                    Image(systemName: "pencil")
                }
                .buttonStyle(.borderless)
                Spacer()
            }
                HStack {
                Image(systemName: "calendar")
                Text(workout.date, style: .date)
                Spacer()
            }
            HStack {
                Image(systemName: "clock")
                Text("Duration: \(workout.lengthInMinutes) minutes")
                Spacer()
            }
        }
        .sheet(isPresented: $isPresentingChangeWorkoutView) {
            NavigationView {
                ChangeWorkoutView(workout: $newWorkout)
                .navigationBarItems(leading: Button("Cancel") {
                    isPresentingChangeWorkoutView = false
                }, trailing: Button("Save") {
                    workout.update(from: newWorkout)
                    workouts = workouts.sorted(by: { $0.date > $1.date })
                    isPresentingChangeWorkoutView = false
                })
            }
        }
    }
}

/// Preview WorkoutCardView in XCode.
struct WorkoutCardView_Preview: PreviewProvider {
    static var previews: some View {
        WorkoutCardView(workout: .constant(Workout.sampleWorkouts[0]),workouts: .constant(Workout.sampleWorkouts))
    }
}
