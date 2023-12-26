//
//  AprroveTimerView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 09/11/2023.
//

import SwiftUI

struct AprroveTimerView: View {

    @StateObject var approveTimerManager = ApproveTimerManager()

    var title: String{
        switch approveTimerManager.fastingState {
        case .notStarted:
            return "Let's get started!"
        case .fasting:
            return "You are now Fasting"
        case .feeding:
            return "You are now Feeding"
        }
    }

    var body: some View {
        ZStack{
            // Mark: Background
            Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1.0))
                .ignoresSafeArea()
            content
        }
    }
    var content: some View{
        ZStack {
            VStack(spacing:40.0){

                // MARK: Title
                Text (title)
                    .font(.headline)
                    .foregroundColor(Color(#colorLiteral(red:0.3843137255, green:0.5176470588,blue: 1, alpha: 1)))

                // MARK: Fasting Plan
                Text(approveTimerManager.fastingPlan.rawValue)
                    .fontWeight(.semibold)
                    .padding(.horizontal,24)
                    .padding(.vertical,8)
                    .background(.thinMaterial)
                    .cornerRadius(20.0)
                Spacer()
            }
            VStack(spacing: 40.0){
                //Mark: Progress Ring
                ProgressRing()
                    .environmentObject(approveTimerManager)

                HStack(spacing: 60) {

                    // MARK: Start Time

                    VStack(spacing: 5) {
                        Text((approveTimerManager.fastingState == .notStarted ? "Start" : "Started"))
                            .opacity(0.7)

                        Text(approveTimerManager.startTime,format:.dateTime.weekday().hour().minute().second())
                            .fontWeight (.bold)
                    }
                    // MARK: End Time
                    VStack(spacing: 5) {
                        Text((approveTimerManager.fastingState == .notStarted ? "End" : "Ends"))
                            .opacity(0.7)
                        Text(approveTimerManager.endTime, format:
                                .dateTime.weekday().hour().minute().second())
                        .fontWeight(.bold)
                    }
                }
                // MARK: Button
                Button {
                    approveTimerManager.toggleFastingState()

                } label: {
                    Text (approveTimerManager.fastingState == .fasting ? "End fast":"Start fasting")
                        .font(. title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(.thinMaterial)
                        .cornerRadius (20)
                }
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

#Preview {
    AprroveTimerView()
        .environmentObject(ApproveTimerManager())
}
