//
//  XGTrainerModels.swift
//  XG Tool
//
//  Created by The Steez on 31/05/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

let kNumberOfTrainerModels = 0x44

enum XGTrainerModels : Int {
	
	case None	= 0x00
	
	case Wes
	case Ruby
	case Sapphire
	case CipherPeonF
	case CipherPeonM1
	case Verde
	case Rosso
	case Bluno
	case Skrub
	case Green
	case Red
	case FunOldLady
	case Dakim
	case Gonzap
	case MirorB
	case Venus
	case Nascour
	case NewsCaster
	case StPerformer
	case Eagun
	case Vander
	case SuperTrainerM2
	case Arth
	case SuperTrainerF1
	case Ferma
	case Reath
	case HunterM
	case Folly
	case LadyInSuit
	case GlassesMan
	case FunOldMan
	case BodyBuilderF
	case BodyBuilderM
	case RichBoy1
	case Guy
	case Lady1
	case RiderF
	case Willie
	case RiderM
	case Teacher
	case Evice
	case Snagem1
	case AthleteF
	case AthleteM
	case Ein
	case ChaserF1
	case ChaserM1
	case RollerBoy
	case Worker
	case Rui
	case RichBoy2
	case Lady2
	case CoolTrainerM
	case CoolTrainerF
	case Justy
	case BandanaGuy
	case Researcher
	case HunterF
	case Battlus
	case BodyBuilderM2
	case DeepKing
	case chaserM2
	case Eagun2
	case Eagun3
	case SuperTrainerF2
	case Fein
	case Snagem2
	case Snagem3
	case MirakleB
	case SuperTrainerM1
	case Trinch
	case Athey
	case Trudly
	case Cail
	case ChaserF2
	
	
	
	var image : UIImage {
		
		return XGFiles.TrainerFace(self.rawValue).image
		
	}
	
}
















