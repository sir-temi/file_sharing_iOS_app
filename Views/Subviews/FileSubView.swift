//
//  FileSubView.swift
//  TemiShare
//
//  Created by TemiTope Kayode on 11/07/2021.
//

import SwiftUI

extension String {
    func load() -> UIImage{
        
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

struct FileSubView: View {
    @State var file: FileModel
    @State var fileDate: Date = Date()
    var body: some View {
        NavigationLink(
            destination: FileDetailView(file: file),
            label: {
        HStack{
            Image(uiImage: "http://127.0.0.1:8000\(file.thumbnail)".load())
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.trailing, 8)
            
            VStack(spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                
                HStack {
                    Text(file.title)
                        .font(.headline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.MyTheme.darkGreenColor)
                    Spacer()
                    
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                        Image(systemName: "arrow.down.to.line.alt")
                            .font(.subheadline)
                            .foregroundColor(Color.MyTheme.darkGreenColor)
                            .padding(.all, 0)
                        Text(String(file.downloaded))
                            .font(.subheadline)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.gray)
                            .padding(.all, 0)
                    }).frame(width: 50, alignment: .leading)
                    
                }.padding(.bottom, 5)
                HStack(alignment: .bottom, spacing: nil, content: {
                    Text(file.mime_type.components(separatedBy: "/")[0].uppercased())
                        .font(.footnote)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
//
                
                    Text(file.size_mb)
                        .font(.footnote)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.gray)
                        .frame(width: 70, alignment: .leading)
                    
                    
                    Text(fileDate, style: .date)
                        .font(.footnote)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.gray)
                        .frame(width: 100, alignment: .leading)
                   
                }).padding(.top, 5)
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            })
        }
            }).onAppear(perform: {
                self.fileDate = convertDate(date: file.uploaded_date)
        })
    }
    func convertDate(date: String) -> Date{
        let day = date.components(separatedBy: "T")[0]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        return dateFormatter.date(from: day)!
    }
}

struct FileSubView_Previews: PreviewProvider {
    static var file: FileModel = FileModel(identifier: "iriri", downloaded: 8, mime_type: "image/audio", size_mb: "5 MB", thumbnail: "images/video.png", title: "A good book", uploaded_date: "Jul 11, 2021", authorised_user: "", description: "A very nice video", owner: ["username":"engryankey"], location: "London", restricted_by_user: false, restricted_by_country: true)

    
    static var previews: some View {
        FileSubView(file: file)
//            .previewLayout(.sizeThatFits)
    }
}
