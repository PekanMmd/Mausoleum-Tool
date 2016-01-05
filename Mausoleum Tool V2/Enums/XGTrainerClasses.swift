//
//  XGTrainerClasses.swift
//  XG Tool
//
//  Created by The Steez on 31/05/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import Foundation

let kFirstTrainerClassStringID = 0x1B59

enum XGTrainerClasses : Int {
	
	
	case None1			= 0x00
	case None2			
	case None3
	case None4
	case CipherAdmin	
	case Cipher			
	case CipherHead		
	case MythTrainer	
	case MtBtlMaster	
	case RichBoy		
	case Lady			
	case GlassesMan
	case LadyInSuit
	case Guy
	case Teacher
	case FunOldMan
	case FunOldLady
	case Athlete
	case CoolTrainer
	case PreGymLeader
	case AreaLeader
	case SuperTrainer
	case Worker
	case SnagemHead
	case MirorBPeon
	case Hunter
	case Rider
	case RollerBoy
	case StPerformer
	case BandanaGuy
	case Chaser
	case Researcher
	case BodyBuilder
	case DeepKing
	case NewsCaster
	case TeamSnagem
	case CipherPeon
	case MysteryTroop
	case VRTrainer
	case ShadyGuy
	case Rogue
	case None5
	case None6
	
	var nameID : Int {
		get {
			return XGTrainerClass(tClass: self).nameID
		}
	}
	
	var name : XGString {
		get {
			return XGTrainerClass(tClass: self).name
		}
	}
	
	var payout : Int {
		get {
			return XGTrainerClass(tClass: self).payout
		}
	}
	
}
















