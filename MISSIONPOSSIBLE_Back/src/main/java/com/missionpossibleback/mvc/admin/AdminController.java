package com.missionpossibleback.mvc.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.missionpossibleback.mvc.board.model.service.BoardService;
import com.missionpossibleback.mvc.challenge.model.service.ChallengeService;
import com.missionpossibleback.mvc.member.model.service.MemberService;
import com.missionpossibleback.mvc.review.model.service.ReviewService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AdminController {

	 @Autowired
	 private ReviewService R_service; 
	 @Autowired
	 private  MemberService M_service;
	 @Autowired
	 private ChallengeService C_Service;
	 @Autowired
	 private BoardService B_service;
	
	//헤더 테스트(관리자) 
	@GetMapping("/admin/headerTest")
	public void headerTest() {
		log.info("헤더 테스트");
	}
	
	//회원관리 (관리자) 
	@GetMapping("/admin/viewUser")
	public void viewUser() {
		log.info("회원관리 페이지 요청");
	}
	
	//챌린지관리 (관리자)
	@GetMapping("/admin/viewChallenge")
	public void viewChallenge() {
		log.info("챌린지리스트 페이지 요청");
	}
	
	//신고접수 (관리자)
	@GetMapping("/admin/viewRecruit")
	public void viewRecruit() {
		log.info("후기게시판 페이지 요청");
	}
	
	//고객센터 (관리자)
	@GetMapping("/admin/viewBoard")
	public void viewBoard() {
		log.info("고객센터 페이지 요청");
	}
	
	//후기 게시판 
	@GetMapping("/admin/viewReview")
	public void viewReview() {
		log.info("후기게시판 페이지 요청");
	}
	

}
