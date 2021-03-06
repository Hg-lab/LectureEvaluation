package util;

import java.security.MessageDigest;

public class SHA256 { //해시값 적용해서 인증코드로 링크다고 들어오게끔 하는 것

	public static String getSHA256(String input) {
		StringBuffer result = new StringBuffer();
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] salt = "Hello! This is Salt.".getBytes();// 해킹 당하지 않게 단순 SHA-256이 아닌 Salt 값 넣어줌
			digest.reset();
			digest.update(salt);
			byte[] chars = digest.digest(input.getBytes("UTF-8")); //해시 적용한 것 chars 배열에 담아줌
			for(int i = 0; i < chars.length; i++) {
				String hex = Integer.toHexString(0xff & chars[i]); //16진수로
				if(hex.length() == 1) result.append("0");
				result.append(hex);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result.toString();
	}
	
}
