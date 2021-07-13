//
//  FileDetailView.swift
//  TemiShare
//
//  Created by TemiTope Kayode on 10/07/2021.
//

import SwiftUI
import Foundation


extension String {
    func loadDetail() -> UIImage{
        
        do {
            guard let url = URL(string: self) else {
                return UIImage()
            }
            
            let data: Data = try Data(contentsOf: url)
            
            return UIImage(data: data) ?? UIImage()
        } catch {
            
        }
        
        return UIImage()
    }
}

struct FileDetailView: View {
    @State var showAlert: Bool = false
    @State var file: FileModel
    @State var isLoading: Bool = true
    @State var fileDate: Date = Date()
    var body: some View {
        ZStack {
            if (isLoading == false){
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack{
                    ZStack{
                        Image(uiImage: "http://127.0.0.1:8000\(file.thumbnail)".load())
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        if (AuthApi().getUserName() == file.owner["username"]){
                            VStack {
                                HStack{
                                    Spacer()
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                        Image(systemName: "paperplane.fill")
                                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(Color.MyTheme.darkGreenColor)
                                            .padding()
                                    })
                                }
                                
                                HStack{
                                    Spacer()
                                    Button(action: {showAlert = true}, label: {
                                        Image(systemName: "info.circle")
                                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(Color.MyTheme.darkGreenColor)
                                            .padding()
                                    }).alert(isPresented: $showAlert, content: {
                                        Alert(title: Text("File Number").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/), message: Text(file.identifier), dismissButton: .default(Text("Copy")
                                                )
                                            )
                                        })
                                    }
                                
                                HStack{
                                    Spacer()
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                        Image(systemName: "trash")
                                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(Color.MyTheme.darkGreenColor)
                                            .padding()
                                            })
                                        }
                                Spacer()
                            }
                        }
                        
                    }
                    Text(file.title)
                        .font(.largeTitle)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.MyTheme.darkGreenColor)
                    
                    Text(file.description)
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.bottom)
                    
                    VStack{
                        HStack{
                            HStack{
                                Image(systemName: "arrow.down.to.line.alt")
                                    .font(.title2)
                                    .foregroundColor(Color.MyTheme.darkGreenColor)
                                
                                Text(String(file.downloaded))
                                    .font(.title2)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            }.padding(.leading, 20)
                            
                            Spacer()
                            
                            HStack{
                                Image(systemName: "square.grid.2x2")
                                    .font(.title2)
                                    .foregroundColor(Color.MyTheme.darkGreenColor)
                                
                                Text(file.mime_type.components(separatedBy: "/")[0].uppercased())
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }.padding(.trailing, 20)
                        }.padding(.vertical)
                        
                        HStack{
                            HStack{
                                Image(systemName: "bag.fill")
                                    .font(.title2)
                                    .foregroundColor(Color.MyTheme.darkGreenColor)
                                
                                Text(String(file.size_mb))
                                    .font(.title2)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            }.padding(.leading, 20)
                            
                            Spacer()
                            
                            HStack{
                                Image(systemName: "person.fill")
                                    .font(.title2)
                                    .foregroundColor(Color.MyTheme.darkGreenColor)
                                
                                Text(file.owner["username"]!)
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }.padding(.trailing, 20)
                        }.padding(.vertical)
                        
                        HStack{
                            Spacer()
                            
                            Image(systemName: "calendar")
                                .font(.title2)
                                .foregroundColor(Color.MyTheme.darkGreenColor)
                            
                            Text(fileDate, style: .date)
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                        
                        if (AuthApi().getUserName() == file.owner["username"]){
                            VStack{
                                Toggle("Restricted by Country", isOn: $file.restricted_by_country)
                                        .font(.title2)
                                    .padding(.vertical)
                                    .padding(.horizontal, 20)
                                
                                Toggle("Restricted by user", isOn: $file.restricted_by_user)
                                        .font(.title2)
                                    .padding(.horizontal, 20)
                                    .padding(.bottom)
                            }
                        }else{
                            HStack{
                                Spacer()
                                
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    Image(systemName: "arrow.down.circle.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(Color.MyTheme.darkGreenColor)
                                })
                                
                                Spacer()
                            }.padding()
                        }
                        
                        
                        
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: .infinity, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(radius: 20)
                    .padding(.horizontal, 6)
//                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                   
                    
                }
            })
            .padding(.all, 20)
            
            } else {
                
            ProgressView()
            
            }
            
        }
        .onAppear(perform: {
            self.fileDate = convertDate(date: file.uploaded_date)
            isLoading = false
            })
    }
    func convertDate(date: String) -> Date{
        let day = date.components(separatedBy: "T")[0]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        return dateFormatter.date(from: day)!
    }
}

struct FileDetailView_Previews: PreviewProvider {
    
    @State static var file: FileModel = FileModel(identifier: "iriri", downloaded: 8, mime_type: "image/audio", size_mb: "5 MB", thumbnail: "images/video.png", title: "A good book", uploaded_date: "Jul 11, 2021", authorised_user: "", description: "A very nice video", owner: ["username":"engryankey"], location: "London", restricted_by_user: false, restricted_by_country: true)
    
    static var previews: some View {
        FileDetailView(file: file)
    }
}
