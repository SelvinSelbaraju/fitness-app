import SwiftUI

/// Used to edit the name, date and duration in minutes of a workout.
///
/// - Properties:
///     - workout: A binding for the workout which is being changed.
struct ChangeWorkoutView: View {
    @Binding var workout: Workout
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Workout Name:")
                    TextField("Workout Name", text: $workout.name)
                }
                DatePicker("Workout Date:", selection: $workout.date)
                HStack {
                    Text("Workout Length:")
                    Picker("Workout Length:", selection: $workout.lengthInMinutes) {
                        ForEach(1 ..< 182) {
                            Text("\($0-1) Minutes") // The argument here is the position in the range 1 to 181. When the argument is 0, the text is 1 minutes. Therefore, need to minus one.
                        }
                    }
                }
            }
        }
    }
}

/// Previews ChangeWorkoutView in XCode.
struct ChangeWorkoutView_Preview: PreviewProvider {
    static var previews: some View {
        ChangeWorkoutView(workout: .constant(Workout.sampleWorkouts[0]))
    }
}
