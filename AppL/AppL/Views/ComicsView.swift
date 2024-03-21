//
//  ContentView.swift
//  AppL
//
//  Created by Víctor Varillas Ledesma on 20/3/24.
//

import SwiftUI

struct ComicsView: View {  
    @StateObject private var viewModel = Resolver.shared.resolve(ComicsViewModel.self)
    @State var select: String? = ""

    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach((0..<viewModel.comics.count), id: \.self)
                        {index in
                            NavigationLink(destination: SecondView(comic: $viewModel.comics[index]), tag: viewModel.comics[index].title ?? "Unnamed", selection: $select)
                            {
                                Text(viewModel.comics[index].title ?? "Unnamed")
                                    .padding(.vertical, 2.0)
                            }
                        }
                        Spacer()
                    }
                    .frame(width:160)
                    .listStyle(SidebarListStyle())
                }
                .navigationTitle("Comics")
                .navigationViewStyle(DoubleColumnNavigationViewStyle())
        }
    }
}

struct SecondView: View {
    @Binding var comic: Comic

    var body: some View {
        AsyncImage(url: comic.thumbnailURL) { image in
            image
                .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 120)
                    .clipped()
        } placeholder: {
        }
        
        Text(comic.title ?? "Unnamed")
            .frame(height: 20)
        
        Text(comic.description ?? "No description")
            .frame(height: 20)
    }
}

#Preview {
    ComicsView()
}
