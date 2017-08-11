package br.senai.informatica.sp.resolution.tools;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;

public class EnviarEmail {
	
	static HtmlEmail htmlEmail;
	
	
	public static void enviarEmail(String email, String mensagem) throws EmailException{
		htmlEmail = new HtmlEmail();
		

		htmlEmail.setHostName("smtp.office365.com");  
		htmlEmail.setSmtpPort(587); 
		htmlEmail.setAuthentication("renan.carpinelli@hotmail.com","cruzeiro123");  
		htmlEmail.setTLS(true);
		
		htmlEmail.setFrom("renan.carpinelli@hotmail.com");
		htmlEmail.setSubject("Enviando email"); 
		htmlEmail.setDebug(true);
		htmlEmail.setMsg("Teste de envio de email"); 
		htmlEmail.addTo("renan_carpinelli@hotmail.com"); 
		 //será passado o email que você fará a autenticação 
		 
		 
		htmlEmail.send();  	
	}
	
	
	

}
