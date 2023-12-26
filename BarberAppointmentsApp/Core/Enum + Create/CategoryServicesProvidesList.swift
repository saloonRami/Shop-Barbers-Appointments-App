
//
//  ServicesProvidesList.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/11/2023.
//

import Foundation

struct CategoryServiceModel: Identifiable{

    var id = UUID()
    var name:String
}

enum CategoryServicesProvidesList:Int,CaseIterable,CodingKey{

    case barber = 0
    case Makeup
    case barbering
    case hairExtenison
    case Removal
    case tattoo
    case Injectable
    case facials
    case nail
    case eyebrow
    case body
    case Counselling
    case fitness
    case message
    case medical

    var CategoryServicesNameAll: [CategoryServiceModel]{
        var all: [CategoryServiceModel] = []

        for model in CategoryServicesProvidesList.allCases {

            all +=  [CategoryServiceModel(name: model.CategoryServicesName.description)]
        }
        return all
    }

    var  CategoryServicesName: String{

        switch self{

        case .barber:
            return "Haircut & styling"
        case .Makeup:
            return "Makeup"
        case .barbering:
            return "Barbering"
        case .hairExtenison:
            return  "Hair extensions"
        case .Removal:
            return "Hair removal"
        case .Injectable:
            return "Injectables & fillers || skincare"
        case .facials:
            return "Facials & skincare"
        case .nail:
            return "Nail sevice"
        case .eyebrow:
            return "Eyebrow & eyelashes"
        case .body:
            return "Body"
        case .Counselling:
            return "Counselling & holistic"
        case .fitness:
            return "Fitness"
        case .message:
            return "Massage"
        case .medical:
            return "Medical & dental"
        case .tattoo:
            return "Tattoo & piercing"
        }
    }

    var IconImage: String{

        switch self{

        case .barber:
            return ""
        case .Makeup:
            return ""
        case .barbering:
            return ""
        case .hairExtenison:
            return ""
        case .Removal:
            return ""
        case .tattoo:
            return ""
        case .Injectable:
            return ""
        case .facials:
            return ""
        case .nail:
            return ""
        case .eyebrow:
            return ""
        case .body:
            return ""
        case .Counselling:
            return ""
        case .fitness:
            return ""
        default:
            return ""
        }
    }
}
extension CategoryServicesProvidesList{

    func ServicesWithCategory() -> [String] {

        switch self{

        case .barber:
            return ["Afro Hair","Asian Haircut","Balayage","Blow Dry","Bridal Hair","Children's Haircut","Curly Haircut","Hair Braiding","Hair Colouring","Hair Consultation","Hair Loss Treatment","Hair Makeup","Hair Styling","Hair Treatment","Hair Twists","Hair Weaves","Head Shave","Highlights","Keratin Treatment","Locs","Perm","Permanent Hair Straightening","Updo","Wig Installation","Women's Haircut"]
        case .Makeup:
            return ["Bridal Makeup","Makeup Service","Permanent Makeup"]
        case .barbering:
            return ["Beard Trimming","Men's Haircut","Men's Shaving"]
        case .hairExtenison:
            return ["Hair Extensions"]
        case .Removal:
            return ["Arm Waxing","Back Waxing","Bikini Waxing","Brazilian Waxing","Electrolysis","Eyebrow Threading","Eyebrow Waxing","faceWaxing","Face Waxing","Full Body Waxing","Hollywood Waxing","IPL Hair Removal","Laser Hair Removal","Leg Waxing","Men's Waxing","Sugaring","Threading","Underarm Waxing"]
        case .Injectable:
            return ["Anti-Wrinkle Injections","Dermal Fillers","Fat Dissolving Injections","Lip Fillers","Non-Surgical Facelift"]
        case .facials:
            return ["Acne Facial","Acne Scar Treatment","Chemical Peel","Dermabrasion","Dermabrasion","Facial","Facial Extractions","Facial Massage","IPL Treatment","Laser Resurfacing","LED Liaht Therapy","Men's Facial","Mesotherapy","Microblading","Microcurrent Facial","Microdermabrasion","Microneedling","Oxygen Facial","Skin Consultation","Skin Lightening Treatment","Spa Facial","Thread Lift","Vampire Facial"]
        case .nail:
            return ["Acrylic Nails","Dip Powder Nails","Fish Manicure","Fish Pedicure","Foot Spa","French Nails","Gel Nail Extensions","Gel Nails","Hybrid Nails","Manicure","Manicure and Pedicure","Men's Manicure","Men's Pedicure","Nail Art","Nail Extensions","Nail Polish","Ombre Nails","Paraffin Wax Treatment","Pedicure","Russian Manicure","Spa Manicure","Spa Pedicure"]
        case .eyebrow:
            return ["Brow Lamination","Eyebrow Shaping","Eyebrow Tinting","Eyelash Extensions","Eyelash Tinting","Henna Brows","Lash Lift","Lash Lift and Tint","Powder Brows"]
        case .body:
            return ["Acupuncture","Airbrush Tanning","Back Facial","Body Scrub","Body Sculpting","Body Wrap","Cellulite Treatment","Fat Freezing","Hyperhidrosis Treatment","Infrared Sauna","Laser Lipo","Mole Removal","Moroccan Bath","Mud Bath","Onsen","Salt Therapy","Sauna","Scalp Micropigmentation","Scar Removal","Skin Tag Removal","Spa Package","Spray Tanning","Steam Bath","Stretch Mark Removal","Tanning Bed","Turkish Bath","Ultrasonic Cavitation","Vajacial"]
        case .Counselling:
            return ["Ayurveda","Chinese Medicine","Counselling","Cupping Therapy","Energy Healing","Hypnotherapy","Life Coaching","Mindfulness","Naturopathy","Nutrition Counselling","Psychic Reading","Psychotherapy","Sensory Deprivation Tank"]
        case .fitness:
            return ["Fitness Classes","Personal Training"]
        case .message:
            return ["Balinese Massage","Chair Massage","Chinese Massage","Couples Massage","Deep Tissue Massage","Foot Massage","Full Body Massage","Hand Massage","Head Massage","Hot Stone Massane","Korean Massage","Lomi Lomi Massage","Lymphatic Drainage Massage","Medical Massage","Oil Massage","Prenatal Massage","Reflexology","Relaxing Massage","Remedial Massage","Shiatsu Massage","Spa Massage","Sports Massage","Swedish Massage","Thai Massage","Therapeutic Massage","Trigger Point Massage","Wood Therapy"]
        case .medical:
            return ["Bariatric Surgery","Bodywork","Chiropractic","Cosmetic Dentistry","Cryotherapy","Dermatology","Dry Needling","General Dentistry","Hair Transplants","Hydrotherapy","IV Drip","Medical Care","Occupational Therapy","Optometry","Orthodontics","Osteopathy","Physiotherapy","Plastic Surgery","Podiatry", "Sclerotherapy","Speech Therapy","Teeth Whitening","Weight Loss Program"]
        case .tattoo:
            return ["Body Piercing","Ear Piercing","Henna Tattoos","Lip Blushing","Nose Piercing","Tattooing","Tattoo Removal"]
        }
    }
}
