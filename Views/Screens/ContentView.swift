//
//  ContentView.swift
//  TemiShare
//
//  Created by TemiTope Kayode on 09/07/2021.
//

import SwiftUI

class AppView: ObservableObject{
    
    let auth = AuthApi()
    
    var isSignedIn: Bool {
        var loggedin: Bool = false
        auth.isLoggedIn { (userName) in
            if(userName != nil){
                loggedin = true
            }else{
                loggedin = false
            }
        }
        return loggedin
    }
    
//    func signIn(username: String, password: String){
//        auth.
//    }
}

struct ContentView: View {
    @State var isRegister: Bool = false
    @State var username: String = ""
    @State var password: String = ""
    @State var regUsername: String = ""
    @State var regPassword: String = ""
    @State var regPassword2: String = ""
    @State var fullName: String = ""
    @State var email: String = ""
    @State private var showAlert = false
    @State var token: String = ""
    @State var isLoading: Bool = false
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        
        ZStack {
            ZStack{
                if (isLoggedIn){
                TabView{
                    NavigationView{
                        DashboardView()
                    }.tabItem {
                        Image(systemName: "list.dash")
                            .font(.largeTitle)
                        Text("Dashboard")
                    }
                    
                    NavigationView{
                        SearchFIleView()
                    }.tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search File")
                    }
                    
                    NavigationView{
                        UploadView()
                    }.tabItem {
                        Image(systemName: "square.and.arrow.up")
                        Text("Upload")
                    }
                    
                    NavigationView{
                        ProfileView()
                    }.tabItem {
                        Image(systemName: "person.crop.circle")
                            .font(.largeTitle)
                        Text("Profile")
                    }
                    
                }
                .accentColor(Color.MyTheme.darkGreenColor)
            } else {
                ZStack {
                    ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content:  {
                        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                            Image("JesseShare")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .padding()
                            
                            HStack{
                                if isRegister{
                                    Button(action: {
                                        isRegister.toggle()
                                    }, label: {
                                        Text("SIGN IN")
                                            .font(.title2)
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(Color.MyTheme.darkGreenColor)
                                            .padding(8)
                                    }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .cornerRadius(7)
                                    
                                    Button(action: {
                                        isRegister.toggle()
                                    }, label: {
                                        Text("REGISTER")
                                            .font(.title2)
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(.white)
                                            .padding(8)
                                    }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .background(Color.MyTheme.darkGreenColor)
                                        .cornerRadius(7)
                                    
                                } else {
                                    
                                    Button(action: {
                                        isRegister.toggle()
                                    }, label: {
                                        Text("SIGN IN")
                                            .font(.title2)
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(.white)
                                            .padding(8)
                                    }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .background(Color.MyTheme.darkGreenColor)
                                        .cornerRadius(7)
                                    
                                    Button(action: {
                                        isRegister.toggle()
                                    }, label: {
                                        Text("REGISTER")
                                            .font(.title2)
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(Color.MyTheme.darkGreenColor)
                                            .padding(8)
                                    }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .cornerRadius(7)
                                }
                            }.padding(.bottom, 6)
                            
                            if isRegister{
                                VStack {
                                TextField("Full Name", text: $regUsername)
                                    .padding()
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .font(.headline)
                                    .padding(.horizontal)
                                    .autocapitalization(.sentences)
                                    .border(Color.MyTheme.darkGreenColor, width: 1)
                                    .autocapitalization(.words)
                                
                                
                                TextField("Username", text: $regUsername)
                                    .padding()
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .font(.headline)
                                    .padding(.horizontal)
                                    .autocapitalization(.sentences)
                                    .border(Color.MyTheme.darkGreenColor, width: 1)
                                
                                
                                TextField("Email", text: $regUsername)
                                    .padding()
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .font(.headline)
                                    .padding(.horizontal)
                                    .autocapitalization(.sentences)
                                    .border(Color.MyTheme.darkGreenColor, width: 1)
                                
                                
                                SecureField("Password", text: $regPassword)
                                    .padding()
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .font(.headline)
                                    .padding(.horizontal)
                                    .border(Color.MyTheme.darkGreenColor, width: 1)
                                
                                SecureField("Confirm password", text: $regPassword2)
                                    .padding()
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .font(.headline)
                                    .padding(.horizontal)
                                    .border(Color.MyTheme.darkGreenColor, width: 1)
                                }
                                
                            } else {
                                VStack {
                                TextField("Username", text: $username)
                                    .padding()
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .font(.headline)
                                    .padding(.horizontal)
                                    .autocapitalization(.sentences)
                                    .border(Color.MyTheme.darkGreenColor, width: 1)
                                
                                SecureField("Password", text: $password)
                                    .padding()
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .font(.headline)
                                    .padding(.horizontal)
                                    .border(Color.MyTheme.darkGreenColor, width: 1)
                                }
                            }
                            
                            
                            
                            Button(action: {
                                authenticate()
                            }, label: {
                                Text(isRegister ?"REGISTER" :"SIGN IN".uppercased())
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)
                                        .padding(10)
                            }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color.MyTheme.darkGreenColor)
                            .cornerRadius(30)
                            .padding(.vertical, 6)
                            
                            Spacer()
                        }).padding()
                    }).alert(isPresented: $showAlert, content: {
                            Alert(title: Text("Incorrect login"), message: Text("The username and password combination you entered is incorrect."), dismissButton: .default(Text("Try Again")))
                        
                    })
                }
            }
        }.opacity(isLoading ?0 :1)
            
            
        ProgressView()
            .opacity(isLoading ?1 :0)
        }
    }
    
    func authenticate(){
        isLoading = true
        AuthApi().authenticate(username: username, password: password) { AuthModel in
            if(AuthModel.username != ""){
                isLoggedIn = true
                isLoading = false
            }else{
                isLoading = false
                showAlert = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
