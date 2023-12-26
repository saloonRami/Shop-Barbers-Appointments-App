//
//  ProgressRing.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 09/11/2023.
//

import SwiftUI

struct ProgressRing: View {
    @EnvironmentObject var approveTimerManager : ApproveTimerManager
//    @State var progress = 0.0

    let timer = Timer
        .publish(every: 1,on: .main,in: .common)
        .autoconnect()

    var body: some View {
        ZStack{

        // Mark: Placeholder Ring
            Circle()
                .stroke(lineWidth: 20.0)
                .foregroundColor(.gray)
                .opacity(0.1)

        // Mark: Colored Ring
            Circle()
                .trim(from: 0.0, to: min(approveTimerManager.progress, 1.0) )
                .stroke(AngularGradient(gradient: Gradient(colors: [Color(.blue), Color(.purple),Color(.blue), Color(.gray)]), center: .center),style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .miter))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.easeInOut(duration: 1.0), value: approveTimerManager.progress)

            if approveTimerManager.fastingState == .notStarted{
                // MARK: Upcoming fast
                VStack(spacing: 5) {
                    Text ("Upcoming fast")
                        .opacity (0.7)
                    Text ("\(approveTimerManager.fastingPlan.fastingPeriod.formatted()) Hours")
                        .font (.title)
                        .fontWeight (.bold)
                }
            } else {
                VStack(spacing:30){
                    //MARK: Elapsed Time
                    VStack(spacing: 5) {
                        Text("Elapsed time (\(approveTimerManager.progress.formatted(.percent)))")
                            .opacity (0.7)
                        Text(approveTimerManager.startTime, style: .timer)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding(.top)

                    // MARK: Remaining Time
                    VStack(spacing: 5) {
                        VStack(spacing:5) {
                            if !approveTimerManager.elapsed{
                                Text ("Remaining time(\((approveTimerManager.progress).formatted(.percent)))")
                                    .opacity (0.7)
                            }else{
                                Text ("Extra time")
                                    .opacity (0.7)
                            }
                            Text(approveTimerManager.endTime, style: .timer)
                                .font(.title2)
                                .fontWeight (.bold)
                        }
                    }
                }
            }
        }
        .frame(width: 250.0,height: 250.0)
        .padding()
        .onReceive(timer) { _ in
            approveTimerManager.track()
        }
        //        .onAppear(){
        //            self.progress = 1
        //        }
    }
}

#Preview {
    ProgressRing()
        .environmentObject(ApproveTimerManager())
}
