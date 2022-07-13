import Foundation

/// Contains all of the necessary information for a workout.
///
/// - Protocols:
///     - Identifiable: Needs to conform to this protocol so an array of Workout objects can be used in iterables (eg. ForEach view).
///     - Codable: Needs to conform to this protocol so the object can be encoded / decoded into/from JSON.
///
/// - Properties:
///     - id: Used to uniquely identify each instance of the structure within a iterable.
///     - name: The name of the workout, (eg. Push Day). Defaults to "New Workout".
///     - date: The date of the workout. Defaults to the current date and time.
///     - lengthInMinutes: Duration of the workout in minutes. Defaults to 60 minutes.
///     - exercises: Array of exercises which occurred in the workout. Defaults to an empty array.
struct Workout: Identifiable, Codable {
    let id: UUID
    var name: String
    var date: Date
    var lengthInMinutes: Int
    var exercises: [Exercise]
    
    init(id: UUID = UUID(), name: String = "New Workout", date: Date = Date(), lengthInMinutes: Int = 60, exercises: [Exercise] = []) {
        self.id = id
        self.name = name
        self.date = date
        self.lengthInMinutes = lengthInMinutes
        self.exercises = exercises
    }
    
    /// Updates a workout instance using the information passed to it.
    ///
    ///- Parameters:
    ///     - workout: The workout data to use to update the Workout instance calling this function.
    /// - Returns: Does not return anything.
    mutating func update(from workout: Workout) {
        name = workout.name
        date = workout.date
        lengthInMinutes = workout.lengthInMinutes
    }
    
    /// Contains all of the necessary information for an exercise.
    /// - Protocols:
    ///     - Identifiable: Needs to conform to this protocol so an array of Workout objects can be used in iterables (eg. ForEach view).
    ///     - Codable: Needs to conform to this protocol so the object can be encoded / decoded into/from JSON.
    ///
    /// - Properties:
    ///     - id: Used to uniquely identify each instance of the structure within a iterable.
    ///     - name: Name of the exercise.
    ///     - sets: Array of sets of the exercise.
    struct Exercise: Identifiable, Codable {
        let id: UUID
        var name: String
        var sets: [ExerciseSet]
        
        init(id: UUID = UUID(), name: String, sets: [ExerciseSet]) {
            self.id = id
            self.name = name
            self.sets = sets
        }
    }
    
    /// Contains all of the necessary information for an exercise set.
    /// - Protocols:
    ///     - Identifiable: Needs to conform to this protocol so an array of Workout objects can be used in iterables (eg. ForEach view).
    ///     - Codable: Needs to conform to this protocol so the object can be encoded / decoded into/from JSON.
    ///
    /// - Properties:
    ///     - id: Used to uniquely identify each instance of the structure within a iterable.
    ///     - weightInKG: How much was lifted in kilograms.
    ///     - noReps: Number of repetitions performed during the set.
    ///     - restTimeInSeconds: How long the user rested after the set.
    struct ExerciseSet: Identifiable, Codable {
        let id: UUID
        var weightInKG: Float
        var noReps: Int
        var restTimeInSeconds: Int
        
        init(id: UUID = UUID(), weightInKG: Float, noReps: Int, restTimeInSeconds: Int) {
            self.id = id
            self.weightInKG = weightInKG
            self.noReps = noReps
            self.restTimeInSeconds = restTimeInSeconds
        }
        
        /// Updates an exercise set instance using the information passed to it.
        ///
        ///- Parameters:
        ///     - set: The exercise set data to use to update the exerciseSet instance calling this function.
        /// - Returns: Does not return anything.
        mutating func update(from set: ExerciseSet) {
            weightInKG = set.weightInKG
            noReps = set.noReps
            restTimeInSeconds = set.restTimeInSeconds
        }
    }
}

/// Include an array of sample workouts for previews.
extension Workout {
    static let sampleWorkouts: [Workout] = [
        Workout(name: "Chest Day", lengthInMinutes: 60, exercises: [
            Exercise(name: "Bench Press", sets: [
                ExerciseSet(weightInKG: 70, noReps: 8, restTimeInSeconds: 120),
                ExerciseSet(weightInKG: 70, noReps: 8, restTimeInSeconds: 120)
            ])
        ]),
        Workout(name: "Leg Day", lengthInMinutes: 60, exercises: [
            Exercise(name: "Squat", sets: [
                ExerciseSet(weightInKG: 100, noReps: 8, restTimeInSeconds: 120),
                ExerciseSet(weightInKG: 100, noReps: 8, restTimeInSeconds: 120)
            ])
        ])
    ]
}

/// Include the placeholder details shown when a user creates a new exercise set.
extension Workout.ExerciseSet {
    static let defaultSet: Workout.ExerciseSet = Workout.ExerciseSet(weightInKG: 60, noReps: 8, restTimeInSeconds: 120)
}
