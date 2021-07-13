//
//  UploadView.swift
//  TemiShare
//
//  Created by TemiTope Kayode on 10/07/2021.
//

import SwiftUI
import UIKit

struct UploadView: View {
    
    @State var showImagePicker: Bool = false
    @State var imageSelected: UIImage = UIImage(named: "dog1")!
    @State var sourceType: UIImagePickerController.SourceType = .camera
    
    @State var showSelectedImageView: Bool = false
    var body: some View {
        VStack{
            Button(action: {
                sourceType = UIImagePickerController.SourceType.camera
                showImagePicker.toggle()
            }, label: {
                HStack {
                    Image(systemName: "camera.fill")
                        .font(.title2)
                        .foregroundColor(Color.white)
                    Text("Take Photo".uppercased())
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.white)
                }.padding(12)
            }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color.MyTheme.darkGreenColor)
            .cornerRadius(30)
            
            
            Button(action: {
                sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
                showImagePicker.toggle()
            }, label: {
                HStack {
                    Image(systemName: "video.fill")
                        .font(.title2)
                        .foregroundColor(Color.white)
                    Text("Take video".uppercased())
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.white)
                    
                }.padding(12)
            }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color.MyTheme.darkGreenColor)
            .cornerRadius(30)
            
            
            Button(action: {
                sourceType = UIImagePickerController.SourceType.photoLibrary
                showImagePicker.toggle()
            }, label: {
                HStack {
                    Image(systemName: "folder.fill.badge.plus")
                        .font(.title2)
                        .foregroundColor(Color.white)
            
                    Text("From library".uppercased())
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.white)
                }.padding(12)
            }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color.MyTheme.darkGreenColor)
            .cornerRadius(30)
        }.padding(.horizontal)
        .sheet(isPresented: $showImagePicker, onDismiss: toSelectedImageView, content: {
            ImagePicker(imageSelected: $imageSelected, sourceType: $sourceType)
        })
        .fullScreenCover(isPresented: $showSelectedImageView, content: {
            PostImageView(imageSelected: $imageSelected)
        })
//        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .navigationBarTitle("Upload File")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {
            
        }, label: {
            Image(systemName: "line.horizontal.3")
        }))
    }
    
    //MARK: FUNCTIONS
    func toSelectedImageView(){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
            showSelectedImageView.toggle()
        }
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            UploadView()
        }
    }
}
