//
//  UserProfileView.swift
//  LetsConnect
//
//  Created by HD-045 on 28/04/23.
//

import SwiftUI

struct UserProfileView: View {
    @ObservedObject var userViewModel: UserProfileViewModel
    @EnvironmentObject var authViewModel: AuthServiceViewModel
    @Environment (\.dismiss) var dismiss
    var body: some View {
        VStack{
            ProfileViewPrimarySection(userViewModel: userViewModel)
            ProfileDetailView(socialMediaProfile: userViewModel.dbDataSocialProfiles)
            Spacer()
            Button{
                authViewModel.setLoggedOutStatus()
                
            }label: {
                HStack{
                    Text("LOG OUT")
                        .fontWeight(.heavy)
                        .font(.title)
                }
                .padding(.horizontal)
                
            }
            .buttonStyle(.bordered)
            .foregroundColor(Color("Secondary"))
            .buttonBorderShape(.roundedRectangle)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("Secondary"), lineWidth: 2)
            )
        }
        .background(.black)
    }
}
        
        struct UserProfileView_Previews: PreviewProvider {
            static var previews: some View {
                UserProfileView(userViewModel: UserProfileViewModel())
                    .environmentObject(AuthServiceViewModel() )
            }
        }
        
        
        struct ProfileViewPrimarySection: View {
            @State private var activeProfileIndex: Int? = 0
            @ObservedObject var userViewModel: UserProfileViewModel
            @EnvironmentObject var authViewModel: AuthServiceViewModel
            var body: some View {
                HStack {
                    Spacer()
                    VStack{
                        ZStack {
                            
                            Circle()
                                .stroke(Color("Secondary"), lineWidth: 2)
                                .frame(width: 112, height: 112)
                            authViewModel.loggedUserDetails?.showImage()
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                                .frame(width: 110,height: 110)
                        }
                        //FIXME: get user data from auth firebase
                        Text(authViewModel.loggedUserDetails?.fullName ?? "Unknown")
                            .foregroundColor(Color("Secondary"))
                            .fontWeight(.bold)
                        NavigationLink(destination: EditProfileDetails(userViewModel: userViewModel), label: {
                            HStack{
                                Text("Edit Profile")
                                    .fontWeight(.medium)
                                    .font(.footnote)
                                
                            }
                            
                            .padding(.horizontal)
                        })
                        .buttonStyle(.bordered)
                        .background(Color("Primary"))
                        .foregroundColor(Color("Secondary"))
                        .buttonBorderShape(.roundedRectangle)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("Secondary"), lineWidth: 2)
                        )
                        
                    }
                    
                    .padding()
                    
                    Spacer()
                }
                .background(Color("Primary"))
                
                
            }
        }
        
        struct ProfileDetailView: View {
            var socialMediaProfile : [SocialProfiles]
            var body: some View {
                VStack{
                    HStack{
                        Spacer()
                        Text("Email id")
                            .foregroundColor(Color("Secondary"))
                        Spacer()
                    }
                    .frame(height: 50)
                    .background(Color("Primary"))
                    .cornerRadius(10)
                    .padding()
                    HStack{
                        Spacer()
                        Text("Phone Number")
                            .foregroundColor(Color("Secondary"))
                        Spacer()
                    }
                    .frame(height: 50)
                    .background(Color("Primary"))
                    .cornerRadius(10)
                    .padding()
                    
                    List {
                        Section(header: Text("Social Profiles Available")) {
                            ForEach(socialMediaProfile) { profile in
                                HStack {
                                    Image(systemName: "circle.fill")
                                        .font(Font.system(size: 5))
                                    Text(profile.platform ?? "Unknown")
                                        .font(.body)
                                }
                                .listRowBackground(Color.clear)
                            }
                            
                        }
                    }
                    .foregroundColor(Color("Secondary"))
                    .listStyle(.plain)
                    
                    
                    
                }
            }
        }
        
