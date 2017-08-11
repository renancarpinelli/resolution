package br.senai.informatica.sp.resolution.tools;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class ConverterData {

	private static Calendar calendar;
	private static DateFormat sdf;

	public static Calendar converterDataEHora(String string) throws ParseException {
		sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm");
		calendar = Calendar.getInstance();
		calendar.setTime(sdf.parse(string));
		return calendar;
	}
		
	public static Long converterHora(String string) throws ParseException{
		sdf = new SimpleDateFormat("hh:mm");
		calendar = Calendar.getInstance();
		calendar.setTime(sdf.parse(string));
		calendar.add(Calendar.HOUR_OF_DAY, -3);	
		return calendar.getTimeInMillis();
	}
	
	
	public static Calendar somarDataHora(Calendar calendar, long hora){			
		calendar.setTimeInMillis(calendar.getTimeInMillis() + hora);							
		return calendar;					
	}
	
	public static Calendar somarData(){
		calendar = Calendar.getInstance();
		calendar.add(Calendar.DAY_OF_MONTH, +3);
		return calendar;
	}
	
}
