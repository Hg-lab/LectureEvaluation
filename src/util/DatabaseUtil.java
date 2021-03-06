package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {

	public static Connection getConnection() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/LectureEvaluation?serverTimezone=UTC"; //데이터베이스 root계정으로 접근하기 위한 db이름
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
				e.printStackTrace();
			}
		return null;
		}
		// 데이터베이스와의 연동 관리할 수 있는 클래스
	}
	
