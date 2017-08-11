package br.senai.informatica.sp.resolution.tools;

import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.ServletContext;

import net.glxn.qrgen.QRCode;
import net.glxn.qrgen.image.ImageType;

public class QRCodeGenerator {

	private static String caminho;

	public static byte[] gerarQRCode(String text) throws IOException {
		ByteArrayOutputStream out = QRCode.from(text).to(ImageType.PNG).stream();
		return out.toByteArray();
	}

}
