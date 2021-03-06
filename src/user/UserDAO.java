package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class UserDAO {

	public int login(String userID, String userPassword) { //아이디 비번 받아서 로그인 시도, 정수형반환
		String SQL= "SELECT userPassword FROM USER WHERE userID=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; //sql이후 결과값에 대해 처리하는 클래스
		
		try {
			conn = DatabaseUtil.getConnection(); //연결되었음 , 외부 유틸로 접근하여 모듈화 함
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery(); // DB에서 조회할때 Query
			if(rs.next()) {
				if(rs.getString(1).contentEquals(userPassword)) {
					return 1; //로그인 성공
				}
				else {
					return 0; // 비밀번호 틀림
				}
			}
			return -1; // 아이디 없음
		} catch (Exception e) {
			e.printStackTrace();
		} finally { // 자원 반환
			try{ if(conn != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
			try{ if(pstmt != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
			try{ if(rs != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
			
			}
		
		return -2; // 데이터베이스 오류
	}
	
	public int join(UserDTO user) {
		String SQL= "INSERT INTO USER VALUES (?, ?, ?, ?, false)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; //sql이후 결과값에 대해 처리하는 클래스
		
		try {
				conn = DatabaseUtil.getConnection(); //연결되었음 , 외부 유틸로 접근하여 모듈화 함
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, user.getUserID()); //물음표에 담음
				pstmt.setString(2, user.getUserPassword());
				pstmt.setString(3, user.getUserEmail());
				pstmt.setString(4, user.getUserEmailHash());			
				return pstmt.executeUpdate(); // SQL INSERT 사용하기 위해, 1이 반환되면 성공한 것.
		} catch (Exception e) {
			e.printStackTrace();
		} finally { // 자원 반환
			try{ if(conn != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
			try{ if(pstmt != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
			try{ if(rs != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
			}
		return -1; // 회원가입 실패
	}
	
	public String getUserEmail(String userID) { //ID를 받아서 이메일을 알아내는 함수
		String SQL= "SELECT userEmail FROM USER WHERE userID=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		try {
				conn = DatabaseUtil.getConnection(); //연결되었음 , 외부 유틸로 접근하여 모듈화 함
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);			
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getString(1);
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally { // 자원 반환
			try{ if(conn != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
			try{ if(pstmt != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
			try{ if(rs != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
			
			}
		
		return null; // 데이터베이스 오류
	}
	
	public boolean getUserEmailChecked(String userID) {
		String SQL= "SELECT userEmailChecked FROM USER WHERE userID=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; //sql이후 결과값에 대해 처리하는 클래스
		
		try {
				conn = DatabaseUtil.getConnection(); //연결되었음 , 외부 유틸로 접근하여 모듈화 함
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);			
				rs = pstmt.executeQuery(); // SQL INSERT 사용하기 위해, 1이 반환되면 성공한 것.
				if(rs.next()) {
					return rs.getBoolean(1);
				}
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally { // 자원 반환
			try{ if(conn != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
			try{ if(pstmt != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
			try{ if(rs != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
			
			}
		
		return false; // 데이터베이스 오류
	}
	
	public boolean setUserEmailChecked(String userID) { //이메일 인증
		String SQL= "UPDATE USER SET userEmailChecked = True WHERE userID=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		try {
				conn = DatabaseUtil.getConnection(); //연결되었음 , 외부 유틸로 접근하여 모듈화 함
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);			
				pstmt.executeUpdate(); // SQL INSERT 사용하기 위해, 1이 반환되면 성공한 것.
				return true;
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally { // 자원 반환
			try{ if(conn != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
			try{ if(pstmt != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
			try{ if(rs != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
			
			}
		
		return false; // 데이터베이스 오류
	}
	

}
