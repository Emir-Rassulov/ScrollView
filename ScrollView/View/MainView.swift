//
//  MainView.swift
//  ScrollView
//
//  Created by Emir Rassulov on 22/05/2024.


import SwiftUI

struct MainView: View {
    @StateObject var viewModel = SweaterViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.sweater?.name ?? "")
                .font(.headline)
                .padding(.horizontal, 32)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.sweaters) { sweater in
                        SweaterView(sweater: sweater)
                            .onTapGesture {
                                withAnimation {
                                    viewModel.sweater = sweater
                                }
                            }
                    }
                }
                .scrollTargetLayout()
            }
            .frame(height: 200)
            .safeAreaPadding(.horizontal, 32)
            .scrollClipDisabled()
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $viewModel.sweater)

            HStack {
                Button {
                    withAnimation {
                        guard let sweater = viewModel.sweater,
                              let index = viewModel.sweaters.firstIndex(of: sweater),
                              index > 0 else { return }
                        viewModel.sweater = viewModel.sweaters[index - 1]
                    }
                } label: {
                    Image(systemName: "arrow.left.square.fill")
                        .font(.system(size: 32))
                }
                .disabled(viewModel.sweater == viewModel.sweaters.first)

                Button {
                    withAnimation {
                        guard let sweater = viewModel.sweater,
                              let index = viewModel.sweaters.firstIndex(of: sweater),
                              index < viewModel.sweaters.count - 1 else { return }
                        viewModel.sweater = viewModel.sweaters[index + 1]
                    }
                } label: {
                    Image(systemName: "arrow.right.square.fill")
                        .font(.system(size: 32))
                }
                .disabled(viewModel.sweater == viewModel.sweaters.last)
            }
            .padding(32)

            Spacer()
        }
    }
}

struct SweaterView: View {
    let sweater: Product

    var body: some View {
        Image(sweater.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Rectangle())
            .cornerRadius(15)
            .frame(width: 200, height: 200)
            .shadow(radius: 10, y: 10)
            .scrollTransition(topLeading: .interactive,
                              bottomTrailing: .interactive,
                              axis: .horizontal) { effect, phase in
                effect
                    .scaleEffect(1 - abs(phase.value))
                    .opacity(1 - abs(phase.value))
                    .rotation3DEffect(.degrees(phase.value * 90),
                                      axis: (x: 0, y: -1, z: 0))
            }
    }
}

#Preview {
    MainView()
}
