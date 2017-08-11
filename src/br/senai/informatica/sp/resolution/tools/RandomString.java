package br.senai.informatica.sp.resolution.tools;

import org.apache.commons.lang3.RandomStringUtils;

public class RandomString {

	public static String GerarString() {
		int length = 5;
		boolean useLetters = false;
		boolean useNumbers = true;
		String generatedString = RandomStringUtils.random(length, useLetters, useNumbers);
		return generatedString;
	}

}
