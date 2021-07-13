//
//  DashboardView.swift
//  TemiShare
//
//  Created by TemiTope Kayode on 09/07/2021.
//

import SwiftUI

struct DashboardView: View {
    @State var files: [FileModel] = []
    @State var isLoading: Bool = true
    
    var body: some View {
        
    ZStack {
        if(isLoading == false){
        VStack{
            HStack{
                Image(systemName: "icloud.and.arrow.up")
                    .font(.largeTitle)
                    .foregroundColor(Color.MyTheme.darkGreenColor)
                Text(String(files.count))
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.MyTheme.lightGreenColor)
                    .padding(.vertical)
            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: .infinity, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color.white)
            .cornerRadius(5)
            .shadow(radius: 20)
            
            
            ScrollView(.vertical, showsIndicators: false, content: {
                LazyVStack{
                ForEach(files) { file in
                    FileSubView(file: file)
                    Divider()
                    }
                }
            }).navigationBarTitle("My Dashboard")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, 10)
            
            }.padding()
            
    } else {
            ProgressView()
        }
            
        }.onAppear(perform: {
            FileApi().getFiles { (files) in
                self.files = files.reversed()
            }
            isLoading = false
    })
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DashboardView()
        }
    }
}
