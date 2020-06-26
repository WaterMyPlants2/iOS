//
//  mockJSON.swift
//  WMP34
//
//  Created by Ezra Black on 6/25/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import Foundation

//API Documentation

//POST /api/auth/register

let registerRequest = """
{
    "username": "jon",
    "password": "snow",
    "phoneNumber": "123123"
}
""".data(using: .utf8) ?? nil

let registerReturn = """
{
    "newUser": {
        "id": 6,
        "username": "jon",
        "phoneNumber": "123123"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjYsInVzZXJuYW1lIjoiam9uIiwiaWF0IjoxNTkyOTQ4MjY4LCJleHAiOjE1OTMyMDc0Njh9.3vG0YC7Cf0I-w6IPxnjGkVx0u0wx8dxMCx-7TltDVqk"
}
""".data(using: .utf8) ?? nil

//POST /api/auth/login

let loginRequest = """
{
   "username": "jon",
   "password": "snow"
}
""".data(using: .utf8) ?? nil

let loginReturn = """
{
   "welcome": "jon",
   "user_id": 6,
   "phoneNumber": "123123",
   "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjYsInVzZXJuYW1lIjoiam9uIiwiaWF0IjoxNTkyOTQ4NjU4LCJleHAiOjE1OTMyMDc4NTh9.kMLo7IG8kmpBx-K948w3Hw7bONsAUkOlrckTerjcX1o"
}
""".data(using: .utf8) ?? nil

//POST /api/users/:id/plants (REQUIRES TOKEN) -> put a plant to server

let postPlantRequest = """
{
    "nickname": "Green",
    "species": "Mr.Green",
    "h2oFrequency": "300 times a week",
    "image": "https://images.unsplash.com/photo-1558350315-8aa00e8e4590?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80"
}
""".data(using: .utf8) ?? nil

let postPlantReturn = """
{
    "id": 6,
    "nickname": "Green",
    "species": "Mr.Green",
    "h2oFrequency": "300 times a week",
    "image": "https://images.unsplash.com/photo-1558350315-8aa00e8e4590?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80",
    "user_id": 1
}
""".data(using: .utf8) ?? nil

//GET /api/auth/plants

let getPlantsRequest = """
[
    {
        "id": 4,
        "species": "Allium genus",
        "h2oFrequency": "5 times a week",
        "image": "https://images.unsplash.com/photo-1558350315-8aa00e8e4590?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80"
    },
    {
        "id": 6,
        "species": "Mr.Green",
        "h2oFrequency": "300 times a week",
        "image": "https://images.unsplash.com/photo-1558350315-8aa00e8e4590?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80"
    }
]
""".data(using: .utf8) ?? nil
