package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator{ // 인증수행을 도와주는 클래스를 상속받음.

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("siregy1222", "gjdrn113367!"); // 사용자에게 메일을 보낼 관리자 메일 주소
	}
	
}
