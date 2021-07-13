//
//  PostImageView.swift
//  TemiShare
//
//  Created by TemiTope Kayode on 10/07/2021.
//

import SwiftUI

struct PostImageView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var captonText: String = ""
    @State var restrictCountry = false
    @State var restrictUser = false
    @State var username = ""
    @Binding var imageSelected: UIImage
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                },
                       label: {
                    Image(systemName: "xmark")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .padding()
                   }).accentColor(.primary)
                
                Spacer()
            }
            
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
                Image(uiImage: imageSelected)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(12)
                    .clipped()
                
                TextField("Add your capton here", text: $captonText)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                    .padding(.horizontal)
                    .autocapitalization(.sentences)
//                    .background(Color.MyTheme.lightGreenColor)
                    .border(Color.MyTheme.darkGreenColor, width: 1)
                
                Toggle("Restrict by Country", isOn: $restrictCountry)
//                    .toggleStyle(SwitchToggleStyle(tint: Color.MyTheme.darkGreenColor))
                
                Toggle("Restrict by User", isOn: $restrictUser)
                
                if restrictUser{
                    TextField("Username", text: $captonText)
                        .padding()
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .font(.headline)
                        .padding(.horizontal)
                        .autocapitalization(.sentences)
    //                    .background(Color.MyTheme.lightGreenColor)
                        .border(Color.MyTheme.darkGreenColor, width: 1)
                }
                    
                
                Button(action: {
                    
                }, label: {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color.white)
                
                        Text("Upload")
                            .font(.title)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color.white)
                    }.padding(12)
                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.MyTheme.darkGreenColor)
                .cornerRadius(30)
                
            })
        }).padding(.horizontal)
    }
    
    //MARK: FUNCTIONS
    func postFile(){
        print("UPLOAD FILE")
    }
}

struct PostImageView_Previews: PreviewProvider {
    
    @State static var image = UIImage(named: "dog1")!
    
    static var previews: some View {
        PostImageView(imageSelected: $image)
    }
}
