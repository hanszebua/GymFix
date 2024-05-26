//
//  Counter.swift
//  GymFix Watch App
//
//  Created by Hans Zebua on 21/05/24.
//

import SwiftUI
import CoreMotion
import CoreML
import WatchKit

struct ModelConstants {
    static let predictionWindowSize = 50
    static let sensorsUpdateInterval = 1.0 / 50.0
    static let stateInLength = 400
}


struct RepCounter: View {
    
    @State private var showModal = false
    
    @State private var reps = 0
    @State private var targetReps: Int

        init(targetReps: Int) {
            self._targetReps = State(initialValue: targetReps)
        }
    
    //calling the model
    let activityClassificationModel = GymFix___Full()
    @State private var currentIndexInPredictionWindow = 0

    //all the features in the model
    @State private var acc_x = try! MLMultiArray(shape: [ModelConstants.predictionWindowSize] as [NSNumber], dataType: MLMultiArrayDataType.double)
    @State private var acc_y = try! MLMultiArray(shape: [ModelConstants.predictionWindowSize] as [NSNumber], dataType: MLMultiArrayDataType.double)
    @State private var acc_z = try! MLMultiArray(shape: [ModelConstants.predictionWindowSize] as [NSNumber], dataType: MLMultiArrayDataType.double)

    @State private var gyr_x = try! MLMultiArray(shape: [ModelConstants.predictionWindowSize] as [NSNumber], dataType: MLMultiArrayDataType.double)
    @State private var gyr_y = try! MLMultiArray(shape: [ModelConstants.predictionWindowSize] as [NSNumber], dataType: MLMultiArrayDataType.double)
    @State private var gyr_z = try! MLMultiArray(shape: [ModelConstants.predictionWindowSize] as [NSNumber], dataType: MLMultiArrayDataType.double)

    @State private var stateOutput = try! MLMultiArray(shape:[ModelConstants.stateInLength as NSNumber], dataType: MLMultiArrayDataType.double)
    
    // calling the CM manager
    let motionManager = CMMotionManager()

    
    var body: some View {
        NavigationStack {
            Text("\(reps)")
                .font(.largeTitle)
                .foregroundColor(.green)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: {
                                Summary()
                            }, label: {
                                Text("Skip")
                            })
                        }
                    }
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
                        guard motionManager.isAccelerometerAvailable, motionManager.isGyroAvailable else { return }

                        motionManager.accelerometerUpdateInterval = ModelConstants.sensorsUpdateInterval
                        motionManager.gyroUpdateInterval = ModelConstants.sensorsUpdateInterval

                        motionManager.startDeviceMotionUpdates(to: .main) { deviceMotion, error in
                            guard let deviceMotiondata = deviceMotion else { return }

                            self.addMotionSampleToDataArray(motionSample: deviceMotiondata)

                            if self.reps >= self.targetReps {
                                self.motionManager.stopDeviceMotionUpdates()
                                self.showModal = true
                            }
                        }
                    })
        .sheet(isPresented: $showModal) {
                        Summary()
                    }
    }
    
    func addMotionSampleToDataArray (motionSample: CMDeviceMotion) {
        // Add the current motion reading to the data array
        acc_x[[currentIndexInPredictionWindow] as [NSNumber]] = motionSample.userAcceleration.x as NSNumber
        acc_y[[currentIndexInPredictionWindow] as [NSNumber]] = motionSample.userAcceleration.y as NSNumber
        acc_z[[currentIndexInPredictionWindow] as [NSNumber]] = motionSample.userAcceleration.z as NSNumber
        gyr_x[[currentIndexInPredictionWindow] as [NSNumber]] = motionSample.rotationRate.x as NSNumber
        gyr_y[[currentIndexInPredictionWindow] as [NSNumber]] = motionSample.rotationRate.y as NSNumber
        gyr_z[[currentIndexInPredictionWindow] as [NSNumber]] = motionSample.rotationRate.z as NSNumber
        
        // Update the index in the prediction window data array
        currentIndexInPredictionWindow += 1
        
        // If the data array is full, call the prediction method to get a new model prediction.
        // We assume here for simplicity that the Gyro data was added to the data arrays as well.
        if (currentIndexInPredictionWindow == ModelConstants.predictionWindowSize) {
            if performModelPrediction() == "Bicep Curl"{
            
                // Increment the value by 1
                reps += 1

                    // Trigger a watch haptic
                WKInterfaceDevice.current().play(.success)
                
                if motionSample.userAcceleration.x >= 3 && motionSample.userAcceleration.y >= 3 && motionSample.userAcceleration.z >= 3 {
                    print ("cihuy")
                }
                
                currentIndexInPredictionWindow = 0
            }
        }
    }
    
    func performModelPrediction () -> String? {
        // Perform model prediction
        let modelPrediction = try! activityClassificationModel.prediction(rotationRate_x: gyr_x, rotationRate_y: gyr_y, rotationRate_z: gyr_z, userAcceleration_x: acc_x, userAcceleration_y: acc_y, userAcceleration_z: acc_z, stateIn: stateOutput)
        
        // Update the state vector
        stateOutput = modelPrediction.stateOut
        
        // Return the predicted activity - the activity with the highest probability
        return modelPrediction.label
    }
    
}

#Preview {
    RepCounter(targetReps: 10)
}
