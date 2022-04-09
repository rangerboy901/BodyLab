//
//  ContentView.swift
//  BodyLab
//
//  Created by Joseph DeWeese on 4/7/22.
//

import SwiftUI
import CoreData

struct WorkoutsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Workout.name, ascending: true)],
        animation: .default)
    private var workouts: FetchedResults<Workout>

    var body: some View {
        NavigationView {
            List {
                ForEach(workouts) { workout in
                    NavigationLink {
                        Text("Workout at \(workout.name!)")
                    } label: {
                        Text(workout.name!)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addWorkout) {
                        Label("Add Workout", systemImage: "plus")
                    }
                }
            }
          
        }
    }

    private func addWorkout() {
        withAnimation {
            let newWorkout = Workout(context: viewContext)
            newWorkout.name = "Murphy"
            newWorkout.workoutDesc = "Complete 100 Pushups, 100 situps, 100 pullups and 1 mile run for time."
            newWorkout.priority = "Strength"
            
            

            do {
                try viewContext.save()
            } catch {
                
                print("Couldn't save to coreData \(error.localizedDescription)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { workouts[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
               
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
       WorkoutsView()
    }
}
