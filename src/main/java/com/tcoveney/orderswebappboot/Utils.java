package com.tcoveney.orderswebappboot;

import java.util.Map;
import java.util.Collections;
import java.util.LinkedHashMap;

public class Utils {
	private static final Map<String,String> stateListFinal;
	
	static {
		Map<String,String> stateList = new LinkedHashMap<String,String>();
		stateList.put("Alabama", "Alabama");
		stateList.put("Alaska", "Alaska");
		stateList.put("Arizona", "Arizona");
		stateList.put("Arkansas", "Arkansas");
		stateList.put("California", "California");
		stateList.put("Colorado", "Colorado");
		stateList.put("Connecticut", "Connecticut");
		stateList.put("Delaware", "Delaware");
		stateList.put("Florida", "Florida");
		stateList.put("Georgia", "Georgia");
		stateList.put("Hawaii", "Hawaii");
		stateList.put("Idaho", "Idaho");
		stateList.put("Illinois", "Illinois");
		stateList.put("Indiana", "Indiana");
		stateList.put("Iowa", "Iowa");
		stateList.put("Kansas", "Kansas");
		stateList.put("Kentucky", "Kentucky");
		stateList.put("Louisiana", "Louisiana");
		stateList.put("Maine", "Maine");
		stateList.put("Maryland", "Maryland");
		stateList.put("Massachusetts", "Massachusetts");
		stateList.put("Michigan", "Michigan");
		stateList.put("Minnesota", "Minnesota");
		stateList.put("Mississippi", "Mississippi");
		stateList.put("Missouri", "Missouri");
		stateList.put("Montana", "Montana");
		stateList.put("Nebraska", "Nebraska");
		stateList.put("Nevada", "Nevada");
		stateList.put("New Hampshire", "New Hampshire");
		stateList.put("New Jersey", "New Jersey");
		stateList.put("New Mexico", "New Mexico");
		stateList.put("New York", "New York");
		stateList.put("North Carolina", "North Carolina");
		stateList.put("North Dakota", "North Dakota");
		stateList.put("Ohio", "Ohio");
		stateList.put("Oklahoma", "Oklahoma");
		stateList.put("Oregon", "Oregon");
		stateList.put("Pennsylvania", "Pennsylvania");
		stateList.put("Rhode Island", "Rhode Island");
		stateList.put("South Carolina", "South Carolina");
		stateList.put("South Dakota", "South Dakota");
		stateList.put("Tennessee", "Tennessee");
		stateList.put("Texas", "Texas");
		stateList.put("Utah", "Utah");
		stateList.put("Vermont", "Vermont");
		stateList.put("Virginia", "Virginia");
		stateList.put("Washington", "Washington");
		stateList.put("West Virginia", "West Virginia");
		stateList.put("Wisconsin", "Wisconsin");
		stateList.put("Wyoming", "Wyoming");
		
		stateListFinal = Collections.unmodifiableMap(stateList);
	}
	
	public static Map<String,String> getStateList() {
		return stateListFinal;
	}

}