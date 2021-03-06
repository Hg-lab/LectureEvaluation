package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class EvaluationDAO {

	public int write(EvaluationDTO evaluationDTO) {
		String SQL= "INSERT INTO EVALUATION VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; //sql이후 결과값에 대해 처리하는 클래스
		
		try {
			conn = DatabaseUtil.getConnection(); //연결되었음 , 외부 유틸로 접근하여 모듈화 함
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, evaluationDTO.getUserID());				//1
			pstmt.setString(2, evaluationDTO.getLectureName());			//2
			pstmt.setString(3, evaluationDTO.getProfessorName());		//3
			pstmt.setInt(4, evaluationDTO.getLectureYear());			//4
			pstmt.setString(5, evaluationDTO.getSemesterDivide());		//5
			pstmt.setString(6, evaluationDTO.getLecturDivide());		//6
			pstmt.setString(7, evaluationDTO.getEvaluationTitle());		//7
			pstmt.setString(8, evaluationDTO.getEvaluationContent());	//8
			pstmt.setString(9, evaluationDTO.getTotalEvaluation());		//9
			pstmt.setString(10, evaluationDTO.getMyGrade());			//10
			pstmt.setString(11, evaluationDTO.getLectureScore());		//11
			pstmt.setString(12, evaluationDTO.getRateGrade());			//12
			return pstmt.executeUpdate(); // INSERT 실행결과 반환, 정상실행 1반환

		} catch (Exception e) {
			e.printStackTrace();
		} finally { // 자원 반환
			try{ if(conn != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
			try{ if(pstmt != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
			try{ if(rs != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
			}
		return -1; // 데이터베이스 오류
	}
}
