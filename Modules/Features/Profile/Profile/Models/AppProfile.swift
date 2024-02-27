//
//  AppProfile.swift
//  Profile
//
//  Created by Jonatan Ortiz on 19/02/24.
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
        public var aboutMe: String
        public var city: String
        public let sign: String
        public var kids: String
        public var drinks: String
        public var smokes: String
        public let height: String
        public var languages: [String]
        public var job: String?
        public var graduation: String?

        public init(
            aboutMe: String,
            city: String,
            sign: String,
            kids: String,
            drinks: String,
            smokes: String,
            height: String,
            languages: [String],
            job: String? = nil,
            graduation: String? = nil
        ) {
            self.aboutMe = aboutMe
            self.city = city
            self.sign = sign
            self.kids = kids
            self.drinks = drinks
            self.smokes = smokes
            self.height = height
            self.languages = languages
            self.job = job
            self.graduation = graduation
        }
    }

    public struct Attributes: Codable {
        public var musicGenres: [String]
        public var watchingReading: [String]
        public var gameGenres: [String]
        public var firstDate: String
        public var breadwinnerHomemaker: String
        public var cleaningRoutines: String
        public var hobbiesInterests: [String]
        public var whenIGoOutILikeTo: [String]
        public var foodCuisinePreferences: [String]
        public var travel: [String]
        public var philosophyOfLife: String
        public var petPreferences: [String]
        public var urbanRural: [String]
        public var socialMedia: String
        public var lifestyle: String
        public var religion: String
        public var socialPreferences: [String]
        public var familyValues: [String]
        public var sexualOrientation: [String]
        public var genderIdentity: String
        public var politicalPositioning: String
        public var bodyType: [String]
        public var skinColor: String
        public var mentalHealthDisorder: [String]
        public var healthProblems: [String]
        public var clothingStyle: [String]
        public var communicationStyle: [String]
        public var financialManagement: [String]
        public var lifeGoals: [String]
        public var environmentalConcerns: [String]
        public var humorStyle: [String]
        public var socializingPreferences: [String]
        public var futureFamilyPlans: String
        public var personalityTraits: [String]
        public var conflictResolutionStyle: [String]
        public var privacyIndependence: [String]

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

public extension AppProfile {
    static func fixture() -> Self {
        AppProfile(
            uid: "hgFDA4A2YMRoFHNuSZvX1VtRgO43",
            email: "jonataneduard@gmail.com",
            base: AppProfile.Base(
                name: "John Doe",
                age: "29",
                bornGender: "Male"
            ),
            details: AppProfile.Details(
                aboutMe: "I do some modeling jobs.\nIf I don't answer here, follow me on the other network and send me a message and I'll always answer.\n@andr_essa_novais \u{2764}",
                city: "San Francisco",
                sign: "Aquarius",
                kids: "Don't Want",
                drinks: "Socially",
                smokes: "Never",
                height: "165 cm",
                languages: ["English", "Spanish"],
                job: "Psychologist",
                graduation: "Psychology"
            ),
            attributes: AppProfile.Attributes(
                musicGenres: ["Rock", "Classical", "Jazz"],
                watchingReading: ["Sci-Fi", "Fantasy", "Non-fiction"],
                gameGenres: ["Strategy", "Puzzle", "Adventure"],
                firstDate: "Coffee shop",
                breadwinnerHomemaker: "Equal partnership",
                cleaningRoutines: "Weekly",
                hobbiesInterests: ["Hiking", "Coding", "Traveling"],
                whenIGoOutILikeTo: ["Explore new restaurants", "Visit museums", "Go to concerts"],
                foodCuisinePreferences: ["Italian", "Mexican", "Japanese"],
                travel: ["Beach", "City", "Countryside"],
                philosophyOfLife: "Live and let live",
                petPreferences: ["Dogs", "Cats"],
                urbanRural: ["Urban"],
                socialMedia: "Minimal use",
                lifestyle: "Active",
                religion: "Agnostic",
                socialPreferences: ["Small gatherings", "One-on-one"],
                familyValues: ["Close-knit"],
                sexualOrientation: ["Straight"],
                genderIdentity: "Cisgender",
                politicalPositioning: "Moderate",
                bodyType: ["Athletic"],
                skinColor: "Medium",
                mentalHealthDisorder: ["Anxiety disorders"],
                healthProblems: ["I have no health problems"],
                clothingStyle: ["Casual", "Smart casual"],
                communicationStyle: ["Open", "Honest"],
                financialManagement: ["Saver", "Investor"],
                lifeGoals: ["Career success", "Travel"],
                environmentalConcerns: ["Recycling", "Conservation"],
                humorStyle: ["Sarcastic", "Dry"],
                socializingPreferences: ["Bars", "Home gatherings"],
                futureFamilyPlans: "Open to possibilities",
                personalityTraits: ["Thoughtful", "Analytical"],
                conflictResolutionStyle: ["Discussion", "Compromise"],
                privacyIndependence: ["Valued", "Respected"]
            ),
            imageUrls: [
                "https://i.pinimg.com/736x/5e/50/a5/5e50a55755f443649181f76a90ee4aa7.jpg",
                "https://i.pinimg.com/736x/18/85/2c/18852c7db70d38a00a9a5534eab2c869.jpg",
                "https://i.pinimg.com/736x/4d/bf/71/4dbf71b50ab6ad7bff3a1c7232533a5e.jpg",
                "https://i.pinimg.com/736x/78/9f/53/789f53dafa9752275504d0f3c3067073.jpg",
                "https://i.pinimg.com/originals/24/81/40/248140144a26042c0e4fa9b413e96090.jpg",
                "https://i.pinimg.com/474x/4e/d3/e3/4ed3e327d5c81bb1ca07d8f86216df2d.jpg"
            ]
        )
    }
}
