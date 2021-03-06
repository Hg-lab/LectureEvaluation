package evaluation;

public class EvaluationDTO {
	
	int evaluationID;
	String userID;
	String lectureName;
	String professorName;
	int lectureYear;
	String semesterDivide;
	String lecturDivide;
	String evaluationTitle;
	String evaluationContent;
	String totalEvaluation;
	String myGrade;
	String lectureScore;
	String rateGrade;
	int likeCount;
	public int getEvaluationID() {
		return evaluationID;
	}
	public void setEvaluationID(int evaluationID) {
		this.evaluationID = evaluationID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getLectureName() {
		return lectureName;
	}
	public void setLectureName(String lectureName) {
		this.lectureName = lectureName;
	}
	public String getProfessorName() {
		return professorName;
	}
	public void setProfessorName(String professorName) {
		this.professorName = professorName;
	}
	public int getLectureYear() {
		return lectureYear;
	}
	public void setLectureYear(int lectureYear) {
		this.lectureYear = lectureYear;
	}
	public String getSemesterDivide() {
		return semesterDivide;
	}
	public void setSemesterDivide(String semesterDivide) {
		this.semesterDivide = semesterDivide;
	}
	public String getLecturDivide() {
		return lecturDivide;
	}
	public void setLecturDivide(String lecturDivide) {
		this.lecturDivide = lecturDivide;
	}
	public String getEvaluationTitle() {
		return evaluationTitle;
	}
	public void setEvaluationTitle(String evaluationTitle) {
		this.evaluationTitle = evaluationTitle;
	}
	public String getEvaluationContent() {
		return evaluationContent;
	}
	public void setEvaluationContent(String evaluationContent) {
		this.evaluationContent = evaluationContent;
	}
	public String getTotalEvaluation() {
		return totalEvaluation;
	}
	public void setTotalEvaluation(String totalEvaluation) {
		this.totalEvaluation = totalEvaluation;
	}
	public String getMyGrade() {
		return myGrade;
	}
	public void setMyGrade(String myGrade) {
		this.myGrade = myGrade;
	}
	public String getLectureScore() {
		return lectureScore;
	}
	public void setLectureScore(String lectureScore) {
		this.lectureScore = lectureScore;
	}
	public String getRateGrade() {
		return rateGrade;
	}
	public void setRateGrade(String rateGrade) {
		this.rateGrade = rateGrade;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
	public EvaluationDTO() {
		
	}
	
	public EvaluationDTO(int evaluationID, String userID, String lectureName, String professorName, int lectureYear,
			String semesterDivide, String lecturDivide, String evaluationTitle, String evaluationContent,
			String totalEvaluation, String myGrade, String lectureScore, String rateGrade, int likeCount) {
		this.evaluationID = evaluationID;
		this.userID = userID;
		this.lectureName = lectureName;
		this.professorName = professorName;
		this.lectureYear = lectureYear;
		this.semesterDivide = semesterDivide;
		this.lecturDivide = lecturDivide;
		this.evaluationTitle = evaluationTitle;
		this.evaluationContent = evaluationContent;
		this.totalEvaluation = totalEvaluation;
		this.myGrade = myGrade;
		this.lectureScore = lectureScore;
		this.rateGrade = rateGrade;
		this.likeCount = likeCount;
	}
	
	
	
	
}
