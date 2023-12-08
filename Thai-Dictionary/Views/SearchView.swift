//
//  SearchView.swift
//  Thai-Dictionary
//
//  Created by Bandit Silachai on 8/12/23.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var vm = AllWordsViewModel()
    @State var isDetailViewActive = false
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                VStack {
                    Text("พจนานุกรม")
                        .font(.system(size: 46).bold())
                    Text("ฉบับราชบัณฑิตยสถาน พ.ศ.๒๕๕๔")
                        .font(.subheadline)
                }
                
                TextField("ค้นหา", text: $searchText)
                    .font(.title3)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray.opacity(0.1)))
                    .keyboardType(.default)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .onSubmit {
                        isDetailViewActive.toggle()
                    }
                NavigationLink(
                                    destination: DetailView(vocab: searchText),
                                    isActive: $isDetailViewActive
                                ) {
                                    EmptyView()
                                }
                                .hidden()

                Text("คำค้นยอดฮิต")
                    .font(.title.bold())
                VStack(alignment: .leading, content: {
                    ForEach(vm.popularLists, id: \.self) { item in
                        NavigationLink {
                            DetailView(vocab: item)
                        } label: {
                            Text(item)
                                .font(.headline)
                                .fontWeight(.light)
                                .buttonStyle(.plain)
                        }
                    }
                })
                .font(.title3)
                .opacity(0.7)
                
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    SearchView()
}
