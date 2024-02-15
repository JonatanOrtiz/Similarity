//
//  Profile.swift
//  CoreInterface
//
//  Created by Jonatan Ortiz on 08/02/24.
//

public struct AppProfile: Codable {
    public let uid: String
    public let email: String
    public var base: Base
    public var details: Details
    public var attributes: Attributes
    public var imageUrls: [String]

    public init(
        uid: String,
        email: String,
        base: Base,
        details: Details,
        attributes: Attributes,
        imageUrls: [String]
    ) {
        self.uid = uid
        self.email = email
        self.base = base
        self.details = details
        self.attributes = attributes
        self.imageUrls = imageUrls
    }

    public struct Base: Codable {
        public let name: String
        public let age: String
        public let bornGender: String

        public init(name: String, age: String, bornGender: String) {
            self.name = name
            self.age = age
            self.bornGender = bornGender
        }
    }

    public struct Details: Codable {
        public let aboutMe: String
        public let job: String
        public let graduation: String
        public let city: String
        public let sign: String
        public let kids: String
        public let drinks: String
        public let smokes: String
        public let height: String
        public let languages: [String]

        public init(
            aboutMe: String,
            job: String,
            graduation: String,
            city: String,
            sign: String,
            kids: String,
            drinks: String,
            smokes: String,
            height: String,
            languages: [String]
        ) {
            self.aboutMe = aboutMe
            self.job = job
            self.graduation = graduation
            self.city = city
            self.sign = sign
            self.kids = kids
            self.drinks = drinks
            self.smokes = smokes
            self.height = height
            self.languages = languages
        }
    }

    public struct Attributes: Codable {
        public let musicGenres: [String]
        public let watchingReading: [String]
        public let gameGenres: [String]
        public let firstDate: String
        public let breadwinnerHomemaker: String
        public let cleaningRoutines: String
        public let hobbiesInterests: [String]
        public let whenIGoOutILikeTo: [String]
        public let foodCuisinePreferences: [String]
        public let travel: [String]
        public let philosophyOfLife: String
        public let petPreferences: [String]
        public let urbanRural: [String]
        public let socialMedia: String
        public let lifestyle: String
        public let religion: String
        public let socialPreferences: [String]
        public let familyValues: [String]
        public let sexualOrientation: [String]
        public let genderIdentity: String
        public let politicalPositioning: String
        public let bodyType: [String]
        public let skinColor: String
        public let mentalHealthDisorder: [String]
        public let healthProblems: [String]
        public let clothingStyle: [String]
        public let communicationStyle: [String]
        public let financialManagement: [String]
        public let lifeGoals: [String]
        public let environmentalConcerns: [String]
        public let humorStyle: [String]
        public let socializingPreferences: [String]
        public let futureFamilyPlans: String
        public let personalityTraits: [String]
        public let conflictResolutionStyle: [String]
        public let privacyIndependence: [String]

        public init(musicGenres: [String], watchingReading: [String], gameGenres: [String], firstDate: String, breadwinnerHomemaker: String, cleaningRoutines: String, hobbiesInterests: [String], whenIGoOutILikeTo: [String], foodCuisinePreferences: [String], travel: [String], philosophyOfLife: String, petPreferences: [String], urbanRural: [String], socialMedia: String, lifestyle: String, religion: String, socialPreferences: [String], familyValues: [String], sexualOrientation: [String], genderIdentity: String, politicalPositioning: String, bodyType: [String], skinColor: String, mentalHealthDisorder: [String], healthProblems: [String], clothingStyle: [String], communicationStyle: [String], financialManagement: [String], lifeGoals: [String], environmentalConcerns: [String], humorStyle: [String], socializingPreferences: [String], futureFamilyPlans: String, personalityTraits: [String], conflictResolutionStyle: [String], privacyIndependence: [String]) {
            self.musicGenres = musicGenres
            self.watchingReading = watchingReading
            self.gameGenres = gameGenres
            self.firstDate = firstDate
            self.breadwinnerHomemaker = breadwinnerHomemaker
            self.cleaningRoutines = cleaningRoutines
            self.hobbiesInterests = hobbiesInterests
            self.whenIGoOutILikeTo = whenIGoOutILikeTo
            self.foodCuisinePreferences = foodCuisinePreferences
            self.travel = travel
            self.philosophyOfLife = philosophyOfLife
            self.petPreferences = petPreferences
            self.urbanRural = urbanRural
            self.socialMedia = socialMedia
            self.lifestyle = lifestyle
            self.religion = religion
            self.socialPreferences = socialPreferences
            self.familyValues = familyValues
            self.sexualOrientation = sexualOrientation
            self.genderIdentity = genderIdentity
            self.politicalPositioning = politicalPositioning
            self.bodyType = bodyType
            self.skinColor = skinColor
            self.mentalHealthDisorder = mentalHealthDisorder
            self.healthProblems = healthProblems
            self.clothingStyle = clothingStyle
            self.communicationStyle = communicationStyle
            self.financialManagement = financialManagement
            self.lifeGoals = lifeGoals
            self.environmentalConcerns = environmentalConcerns
            self.humorStyle = humorStyle
            self.socializingPreferences = socializingPreferences
            self.futureFamilyPlans = futureFamilyPlans
            self.personalityTraits = personalityTraits
            self.conflictResolutionStyle = conflictResolutionStyle
            self.privacyIndependence = privacyIndependence
        }
    }
}
