//
//  WorldScrambleView.swift
//  WeSplit
//
//  Created by 唐浪 on 2023/2/9.
//

import SwiftUI

struct WorldScrambleView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit {
                addNewWord()
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
}

struct WorldScrambleView_Previews: PreviewProvider {
    static var previews: some View {
        WorldScrambleView()
    }
}
