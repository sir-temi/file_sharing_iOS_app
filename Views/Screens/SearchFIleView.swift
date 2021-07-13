//
//  SearchFIleView.swift
//  TemiShare
//
//  Created by TemiTope Kayode on 13/07/2021.
//

import SwiftUI

struct SearchFIleView: View {
    @State var fileNumber: String = ""
    @State var showAlert: Bool = false
    @State var isLoading: Bool = false
    @State var navigatenow: Bool = false
    @State var file: FileModel = FileModel(identifier: "iriri", downloaded: 8, mime_type: "image/audio", size_mb: "5 MB", thumbnail: "images/video.png", title: "A good book", uploaded_date: "Jul 11, 2021", authorised_user: "", description: "A very nice video", owner: ["username":"engryankey"], location: "London", restricted_by_user: false, restricted_by_country: true)
    
    var body: some View {
        VStack{
            NavigationLink(destination: FileDetailView(file: file), isActive: $navigatenow) { EmptyView() }
            if(isLoading == false){
            TextField("File number", text: $fileNumber)
                .padding()
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .font(.headline)
                .padding(.horizontal)
                .autocapitalization(.sentences)
                .border(Color.MyTheme.darkGreenColor, width: 1)
                .autocapitalization(.words)
            
            
            Button(action: {
                searchFile()
            }, label: {
                HStack{
                    
                    Text("SEARCH")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(Color.white)
                    
                }.padding(10)
            }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color.MyTheme.darkGreenColor)
            .cornerRadius(30)
            .padding(.vertical, 6)
            
            Spacer()
            } else {
                ProgressView()
            }
        }.navigationBarTitle("Search File")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .padding(.top, 10)
        .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Invalid File Number"), message: Text("The file number you searched is invalid."), dismissButton: .default(Text("Try Again")))
    })
            
        
    }
    
    func searchFile(){
        isLoading =  true
        FileApi().getFileDetail(identifier: fileNumber) { file in
            if(file.identifier.count < 1){
                isLoading =  false
                showAlert = true
            } else {
                self.file = file
                isLoading = false
                navigatenow = true
            }
        }
    }
}

struct SearchFIleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SearchFIleView()
        }
    }
}
