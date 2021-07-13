//
//  ProfileView.swift
//  TemiShare
//
//  Created by TemiTope Kayode on 10/07/2021.
//

import SwiftUI

struct ProfileView: View {
    @State var username: String = ""
    var body: some View {
        VStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                Image("dp")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(15)
            })
            
            Text(self.username.uppercased())
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.MyTheme.darkGreenColor)
            
            Button(action: {
//                AuthApi().logOut()
            }, label: {
                HStack{
                    Image(systemName: "power")
                        .font(.largeTitle)
                    Text("Log Out")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }.padding()
            })
            
            Spacer()
        }).padding()
        .navigationBarTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            AuthApi().isLoggedIn { (username) in
                self.username = username!
            }
    })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        ProfileView()
        }
    }
}
