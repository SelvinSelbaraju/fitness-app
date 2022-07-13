import Foundation
import SwiftUI

/// The app's central point of reference for all Workout data.
///
/// - Protocols:
///     - ObservableObject: Necessary so instances of the class can be binded to the view lifecycle.
///
/// - Properties:
///     - workouts: The workout data used throughout the app.
class WorkoutStore: ObservableObject {
    @Published var workouts: [Workout] = []
    
    /// Fetches the filepath used to save / load workout data.
    /// Throws an error if the directory can't be found or the app does not have permission to it.
    ///
    /// - Parameters: Does not have any.
    /// - Returns: The filepath for the user's app specific documents directory with "workouts.data" appended to the end of it.
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                    appropriateFor: nil, create: false).appendingPathComponent("workouts.data")
    }
    
    /// Loads and decodes the JSON workout data using the background thread from the device's storage and gives errors if unsuccessful.
    /// If the filepath can be fetched but no data exists there, an empty array is passed to the completion closure for the successful case.
    /// If the filepath can be fetched and data does exist, this data is passed to the completion closure for the successful case.
    /// If the filepath can't be fetched, the error is passed to the completion closure for the failure case.
    ///
    /// - Parameters: A closure which handles behaviour when the data is / isn't successfuly loaded.
    /// - Returns: Does not return anything.
    static func load(completion: @escaping (Result<[Workout], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let workoutList = try JSONDecoder().decode([Workout].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(workoutList))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    /// Saves the workout data encoded as JSON using the background thread and gives errors if unsucessful.
    /// If the filepath can be fetched, the encoded data is written to it and the number of workouts passed to the completion closure for the successful case.
    /// If the workout data can't be encoded or the filepath can't be fetched, the error is passed to the completion closure for the failure case.
    ///
    /// - Parameters: A closure which handles behaviour when the data is / isn't successfully saved.
    /// - Returns: Does not return anything.
    static func save(workouts: [Workout], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let workoutData = try JSONEncoder().encode(workouts)
                let outfile = try fileURL()
                try workoutData.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(workouts.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
