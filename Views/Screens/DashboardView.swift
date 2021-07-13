//
//  DashboardView.swift
//  TemiShare
//
//  Created by TemiTope Kayode on 09/07/2021.
//

import SwiftUI

struct DashboardView: View {
    @State var files: [[String:Any]] = []
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
                    
                    ForEach(files.indices, id:\.self) { i in
                        FileSubView(file: FileModel(identifier: files[i]["identifier"] as! String, downloaded: files[i]["downloaded"] as! Int, mime_type: files[i]["mime_type"] as! String, size_mb: files[i]["size_mb"] as! String, thumbnail: files[i]["thumbnail"] as! String, title: files[i]["title"] as! String, uploaded_date: files[i]["uploaded_date"] as! String, authorised_user:  files[i]["authorised_user"] as? String, description: files[i]["description"] as! String, owner: files[i]["owner"] as! Dictionary<String, String>, location: files[i]["location"] as! String, restricted_by_user: files[i]["restricted_by_user"] as! Bool, restricted_by_country: files[i]["restricted_by_country"] as! Bool))
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
