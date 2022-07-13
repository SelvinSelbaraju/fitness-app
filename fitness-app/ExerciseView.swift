import SwiftUI

/// View for a specific Exercise, which is part of a workout.
///
/// - Properties:
///     - isPresentingChangeView: A state variable for whether to display the view for editing the set of an exercise.
///     - isPresentingChangeExerciseView: A state variable for whether the textfield for renaming an exercise is displayed.
///     - set: A state variable for selecting a ExerciseSet object for an Exercise object and modifying it.
///     - position: A state variable for the position of the ExerciseSet to modify within the Exercise object. Used for updates in the Sets array.
///     - workout: A binding to the Workout object we want changes to be reflected in.
///     - exercise: A binding to the Exercise object we want changes to be reflected in.
///     - exercisePosition: A variable for which position the current Exercise object is within the Exercises array for a Workout object.
struct ExerciseView: View {
    @State var isPresentingChangeView: Bool = false
    @State var isPresentingChangeExerciseView: Bool = false
    @State private var set: Workout.ExerciseSet = Workout.ExerciseSet.defaultSet
    @State private var position: Int = 0
    
    @Binding var workout: Workout
    @Binding var exercise: Workout.Exercise
    
    var exercisePosition: Int
    
    var body: some View {
        Section(header: Text(exercise.name)) {
            Button(action: {
                workout.exercises.remove(at: exercisePosition)
            }) {
                HStack {
                    Spacer()
                    Text("Delete Exercise")
                    Image(systemName: "trash")
                }
            }
            .buttonStyle(.borderless)
            ForEach($exercise.sets.indices, id: \.self) {i in
                VStack {
                    HStack {
                        Text("Set \(i+1)")
                        Spacer()
                        Text("Rest: \(exercise.sets[i].restTimeInSeconds) Seconds")
                    }
                    HStack {
                        Text("Weight: \(Int(exercise.sets[i].weightInKG)) KG")
                        Spacer()
                        Text("Reps: \(exercise.sets[i].noReps)")
                    }
                    HStack {
                        Button(action: {
                            isPresentingChangeView = true
                            position = i
                            set = exercise.sets[position]
                            
                        }) {
                            HStack {
                                Text("Edit Set")
                                Image(systemName: "pencil")
                            }
                        }
                        .buttonStyle(.borderless)
                        Spacer()
                        Button(action: {
                            exercise.sets.remove(at: i)
                        }) {
                            HStack {
                                Text("Delete Set")
                                Image(systemName: "trash")
                            }
                        }
                        .buttonStyle(.borderless)
                    }
                }
                .sheet(isPresented: $isPresentingChangeView) {
                    NavigationView {
                        ChangeSetView(isPresentingChangeView: $isPresentingChangeView, set: $set)
                            .navigationTitle("Change Set")
                            .navigationBarItems(leading: Button("Cancel") {
                                isPresentingChangeView = false
                            }, trailing: Button("Save") {
                                isPresentingChangeView = false
                                exercise.sets[position].update(from: set)
                            })
                    }
                }
            }
            HStack {
                Button(action: {
                    exercise.sets.append(exercise.sets.last ?? Workout.ExerciseSet.defaultSet)
                }) {
                    Text("Add Set")
                }
                .buttonStyle(.borderless)
                Spacer()
                Button("Rename Exercise") {
                   isPresentingChangeExerciseView = true
                }
                .buttonStyle(.borderless)
            }
            if isPresentingChangeExerciseView {
                HStack {
                    TextField("Rename Exercise", text: $exercise.name)
                    Spacer()
                    Button("Done") {
                        isPresentingChangeExerciseView = false
                    }
                }
            }
        }
    }
}

/// Preview ExerciseView in XCode.
struct ExerciseView_Preview: PreviewProvider {
    static var previews: some View {
        ExerciseView(workout: .constant(Workout.sampleWorkouts[0]),exercise: .constant(Workout.sampleWorkouts[0].exercises[0]), exercisePosition: 0)
    }
}
