package br.senai.informatica.sp.resolution.tools;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;

import javax.servlet.ServletContext;

import org.springframework.web.multipart.MultipartFile;

public class UploadFoto {

	private static byte[] bytes;

	public static byte[] salvarBytes(MultipartFile fileImg) {
		try {
			if (fileImg != null && !fileImg.isEmpty()) {
				bytes = fileImg.getBytes();
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return bytes;
	}
}
