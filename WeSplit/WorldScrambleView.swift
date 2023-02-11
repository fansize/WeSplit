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
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var scores = 0
    
    
    var body: some View {
        NavigationStack {
            List {
                
                Section("Your score is") {
                    Text("\(scores)")
                }
                
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
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                Button("Restart") {
                    startGame()
                }
            }
        }
    }
    
    /// 输入word
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isTooShort(word: answer) else {
            wordError(title: "Word is too short", message: "Try more")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
        scores += 1
    }
    
    /// 加载start.txt的初始word
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                usedWords = []
                scores = 0
                newWord = ""
                return
            }
        }
        fatalError("Could not load start.txt from bundle")
    }
    
    /// 检查单词是否已用过
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word) && word != rootWord
    }
    
    /// 检查单词是否在rootword的字母里
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    /// 检查word是否拼写错误
    func isReal(word: String) -> Bool {
        let check = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspellRange = check.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspellRange.location == NSNotFound
    }
    
    /// 检查word是否小于两个字母
    func isTooShort(word: String) -> Bool {
        word.count > 2
    }
    
    // 显示报错
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
        scores -= 1
    }
}

struct WorldScrambleView_Previews: PreviewProvider {
    static var previews: some View {
        WorldScrambleView()
    }
}
