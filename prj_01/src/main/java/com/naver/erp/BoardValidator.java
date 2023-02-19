package com.naver.erp;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;

//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
//BoardDTO 객체에 저장된 데이터의 유효성 체크할 BoardValidator 클래스 선언하기
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
public class BoardValidator implements Validator {

	private String upRegMode;
	
	public BoardValidator( String upRegMode ) {
		this.upRegMode = upRegMode;
	}
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	//  유효성 체크할 데이터가 저장된 DTO 객체의 클래스 타입 정보 얻어 리턴하기
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	@Override
	public boolean supports(Class<?> arg0) {
		return BoardDTO.class.isAssignableFrom(arg0);  // 검증할 객체의 클래스 타입 정보
	}
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	//  유효성 체크할 메소드 선언하기
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	@Override
	public void validate(
		Object obj          // DTO 객체 저장 매개변수
		, Errors errors     // 유효성 검사 시 발생하는 에러를 관리하는 Errors 객체 저장 매개변수
	){
		try {
			//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
			// 유효성 체크할 DTO 객체 얻기
			//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
			BoardDTO dto = (BoardDTO)obj;

			
			

			//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
			//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
			// ValidationUtils 클래스의 rejectIfEmptyOrWhitespace 메소드 호출하여
			//		BoardDTO 객체의 속성변수명 subject 이 비거나 공백으로 구성되어 있으면
			//		경고 메시지를 Errors 객체에 저장하기
			//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
			ValidationUtils.rejectIfEmptyOrWhitespace(
					errors                       // Errors 객체
					, "subject"                   // BoardDTO 객체의 속성변수명
					, "제목을 입력해주세요"        // BoardDTO 객체의 속성변수명이 비거나 공백으로 구성되어 있을때 경고 문구
			);

			//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
			// BoardDTO 객체의 속성변수명 subject 저장된 데이터가 1~15자 인데
			// 이것을 위반하면
			// Errors 객체에 속성변수명 "subject" 와  경고 메시지 저장하기
			// 이때 문자열의 패턴 검사는 Pattern 클래스의 matches 메소드를 이용한다.
			//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
			String  subject = dto.getSubject();
			if( subject==null  ) { subject = ""; }
			if( Pattern.matches(  "^.{1,15}$", subject  )==false ) {
				errors.rejectValue("subject", "제목은  1~30자 입니다. 재입력 요망");
			}
			//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
			// BoardDTO 객체의 속성변수명 subject 저장된 데이터에 "<script>" 또는 "<SCRIPT>"가 들어 있으면
			// Errors 객체에 속성변수명 "subject" 와  경고 메시지 저장하기
			// 이때 문자열의 패턴 검사는 Pattern 클래스의 matches 메소드를 이용한다.
			//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
			if( Pattern.matches(  "<script>", subject  ) || Pattern.matches(  "<SCRIPT>", subject  ) ) {
				errors.rejectValue("subject", "제목에는 <script> 단어가 가 들어갈수 없습니다.");
			}
				
			
			
			
			
			//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
			//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
			// ValidationUtils 클래스의 rejectIfEmptyOrWhitespace 메소드 호출하여
			//		BoardDTO 객체의 속성변수명 content 이 비거나 공백으로 구성되어 있으면
			//		경고 메시지를 Errors 객체에 저장하기
			//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
			ValidationUtils.rejectIfEmptyOrWhitespace(
					errors                       // Errors 객체
					, "content"                   // BoardDTO 객체의 속성변수명
					, "내용을 입력해주세요"        // BoardDTO 객체의 속성변수명이 비거나 공백으로 구성되어 있을때 경고 문구
			);

			//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
			// BoardDTO 객체의 속성변수명 subject 저장된 데이터가 1~15자 인데
			// 이것을 위반하면
			// Errors 객체에 속성변수명 "subject" 와  경고 메시지 저장하기
			// 이때 문자열의 패턴 검사는 Pattern 클래스의 matches 메소드를 이용한다.
			//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
			String  content = dto.getContent();
			if( content==null  ) { content = ""; }
			if( Pattern.matches(  "^.{1,500}$", content  )==false ) {
				errors.rejectValue("content", "내용은  1~500자 입니다. 재입력 요망");
			}
			//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
			// BoardDTO 객체의 속성변수명 content 저장된 데이터에 "<script>" 또는 "<SCRIPT>"가 들어 있으면
			// Errors 객체에 속성변수명 "content" 와  경고 메시지 저장하기
			// 이때 문자열의 패턴 검사는 Pattern 클래스의 matches 메소드를 이용한다.
			//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
			if( Pattern.matches(  "<script>", content  ) || Pattern.matches(  "<SCRIPT>", content  ) ) {
				errors.rejectValue("content", "내용에는 <script> 단어가 가 들어갈수 없습니다.");
			}
			
			
		}catch(Exception ex) {
			System.out.println( "BoardValidator.validate 메소드 실행 시 예외발생!" );
		}
		
	}
}
