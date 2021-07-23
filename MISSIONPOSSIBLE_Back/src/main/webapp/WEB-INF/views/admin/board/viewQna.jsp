<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%> 

<c:set var="path" value="${ pageContext.request.contextPath }" />
<link rel="stylesheet" href="${ path }/resources/css/review.css">
<link rel="stylesheet" href="${ path }/resources/css/admin.css">


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 게시판</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<link rel="stylesheet" href="/resources/demos/style.css">
<style>
   #box{ background-color:none; width:100%; height:auto; /*높이는 각 세부페이지 컨텐츠 보고 알아서 적~당히 설정하기*/
         margin-top:50px; margin-bottom:100px; margin-left:-10px; padding:10px;}
   #conbox{ width:1600px; /* 넓이도 각 세부 페이지 컨텐츠에 맞춰서 설정*/ position:relative; top:20px; margin:auto;}

	/* 페이지 타이틀 이미지 작업 */
	h2{
		color:black;
	}
	.pageTitle{
		margin-left : 265px;
	}
	/* ---------------------- */

</style>
</head>
<script>
$(function () {
   // 상단 고객센터 게시판 관리 메뉴 클릭시 black으로 바꾸기
   $(".boardA").css({ "background" : "var(--black)", "color" : "var(--white)"});

   // 검색
   $("#searchTxt").keyup(function(){
        var text = $(this).val();
        $(".cateListTb tr:not(#titleTd)").hide();
        
        var temp = $(".cateListTb td:contains('"+text+"')");
        $(temp).parent().show();
    });
});
</script>
<div id="box">
   <section id="section">
      <div id="conbox">
      <!-- title 이미지 삽입 -->
		<a><img class="pageTitle"
			src="${path}/resources/images/pageTitle/고객센터관리.png" />
		</a>

         <div id="wrap">
            <div id="container">
               <div class="inner">
                  <!-- 탭 -->
                  <div class="tabs">
                     <ul class="tabs">
                        <li class="tab-link current">
                           <a href="${ path }/admin/board/viewQna">게시된 고객센터글</a>
                        </li>
                        <li class="tab-link">
                           <a href="${ path }/admin/board/viewDeleteQna">삭제된 고객센터글</a>
                        </li>
                     </ul>
                  </div>
                  
            <div class="cateList">
               <div class="head">
                  <h2 style="color:white;">_</h2>
               </div>
                  <div class="btnArea">
                     <span>
                     	<button class="enroll-bt1" id="notice" onclick="location.href='${path}/board/boardWrite'">공지글쓰기</button>
                        <button class="enroll-bt1" id="allRemoveBtn" style="float:right;">삭제</button>
                        <input type="text" id="searchTxt" name="searchTxt" placeholder="검색" style="float:right; margin-right:6px !important; margin-top:3px;">   
                     </span>

                     
                  </div>
                  <!-- 게시글 리스트 테이블 ------------------------>
                  <div class="tbArea">
                     <table class="cateListTb memListTb">
                        <tr id="titleTd">
                           <th><input type="checkbox" id="allChecked"></th>
                           <th>글번호</th>
                           <th>분류</th>
                           <th>제목</th>
                           <th>작성자</th>
                           <th>작성일</th>
                           <th>조회수</th>
                           <th>처리</th>
                        </tr>
                        <c:if test="${ list.isEmpty() }">
                           <tr>
                              <td colspan="8">조회된 게시글이 없습니다.</td>
                           </tr>
                        </c:if>
                        <c:if test="${ !list.isEmpty() }">
                           <c:forEach var="board" items="${ list }">
                              <tr>
                                 <td><input type="checkbox" class="tdCheck"></td>
                                 <td class="noTd">${ board.qna_no }</td>
                                 <c:if test="${board.sort == 1 }">
                                    <td><c:out value="공지" /></td>
                                 </c:if>
                                 <c:if test="${board.sort == 0 }">
                                    <td><c:out value="질문" /></td>
                                 </c:if>
                                 <td class="view-click td-3" style="width:35%; text-align:left; padding-left:60px;"><a class="getURL" style="color:#666;" href="${ path }/board/boardDetail?qna_no=${ board.qna_no }" target="viewF">
                                 	<%-- 답글 && 비밀글X 이면 --%>
                                    <c:if test="${ board.groupord > 0 && board.pass == null }">
                                        <img src="${path}/resources/images/reicon.png" name="re" id="profile" alt="My Image" style="margin:0 4px 0 0; padding-left:${board.dept * 20 }px;"/><c:out value="${ board.title }"/>
                                    </c:if>
                                    <%-- 원글 && 질문글 && 비밀글X 이면 --%>
                                    <c:if test="${ board.groupord == 0 && board.sort == 0 && board.pass == null}">
                                           <c:out value="${ board.title }"/>
                                    </c:if>
                                    <%-- 원글 && 공지글 && 비밀글X 이면 --%>
                                    <c:if test="${ board.groupord == 0 && board.sort == 1 && board.pass == null}">
                                        <b><c:out value="${ board.title }"/></b>
                                    </c:if>
                                    <%-- 답글 && 비밀글 이면 --%>
                                    <c:if test="${ board.groupord > 0 && board.pass != null }">
                                         <img src="${path}/resources/images/reicon.png" name="re" id="profile" alt="My Image" style="margin:0 4px 0 0; padding-left:${board.dept * 20 }px;"/><c:out value="${ board.title }"/><img src="${path}/resources/images/lock.gif" name="lock" alt="비밀글" style="margin:0 5px;"/>
                                    </c:if>
                                    <%-- 원글 && 비밀글 이면 --%>
                                    <c:if test="${ board.groupord == 0 && board.pass != null}">
                                        <c:out value="${ board.title }"/><img src="${path}/resources/images/lock.gif" name="lock" alt="비밀글" style="margin:0 5px;"/>
                                    </c:if>
                    			 </a>
                                 </td>
                                 <td><c:out value="${ board.writer }" /></td>
                                 <td><fmt:formatDate type="date" value="${ board.createDate }" /></td>
                                 <td><c:out value="${ board.readCount }" /></td>
                                 <td>
                                    <button type="button" id="selectRemoveBtn" class="stat-bt1 removeBtn">삭제</button>
                                 </td>
                              </tr>
                           </c:forEach>
                        </c:if>
                  </table>
                  <!-- 게시글 리스트 테이블 끝 ------------------------>   
                  <!-- 셀렉트 박스 전체 선택 -->   
                  <script>
                  $(function(){
                     // 전체선택 해제
                     $("#allChecked").click(function(){
                               $("input:checkbox").each(function(){
                                   if($(this).is(":checked")){
                                       $(this).prop("checked",false);
                                       $("#allChecked").prop("checked",false);
                                   } else {
                                       $(this).prop("checked",true);
                                       $("#allChecked").prop("checked",true);
                                   }
                               });
                           });
                  });               
               </script>
               <!-- 고객센터 게시글 삭제 모달 -->
               <!-- 게시글 한개씩 삭제 -->
               <div class="cateUpdArea" id="cateDelArea">
                  <div class="newWrapper">
                     <div class="titleArea">
                        <h2>고객센터 게시글 삭제</h2>
                     </div>
                     <div class="contentArea">
                        <div class="div-inf" id="individual">
                        </div>
                        <form id="delForm" action="${ path }/admin/board/oneDelete" method="POST">
                           <input type="hidden" name="qna_no" id="qna_no">
                           <div class="infSendArea">
                              <input type="submit" class="inf-bt2" value="확인">
                              <button type="button" class="inf-bt1 closeDelBtn">취소</button>
                           </div>
                        </form>
                     </div>
                  </div>
               </div>
               <!-- 고객센터 게시글 삭제 모달 기능 -->
               <script>
                  $(function(){
                     // 게시글 삭제
                     $('button.removeBtn').click(function(){
                        $("div#cateDelArea").css("display", "block");
                        $('div.div-wrapper, nav, header, footer').css("pointer-events", "none");
                        
                        // 게시글 제목 알려주기
                        var title = $(this).parent('td').siblings('.td-3').html();
                        $('div#individual').html("<h2>' "+title+" ' 게시글을<br>정말로 삭제하겠습니까?</h2>");
                        
                        // 게시글 번호 폼으로 가져오기
                        var updno = $(this).parent('td').siblings('.noTd').html();
                        $("input#qna_no").val(updno);
                     });
                     $('button.closeDelBtn').click(function(){
                        $('div.cateUpdArea').css("display", "none");
                        $('div.div-wrapper, nav, header, footer').css("pointer-events", "all");
                     });
                  });
               </script>
               <!-- 고객센터 게시글 선택 삭제 모달 -->   
               <div class="cateUpdArea" id="selectRemoveArea">
               <div class="newWrapper">
                  <div class="titleArea">
                     <h2>고객센터 게시글 삭제</h2>
                  </div>
                  <div class="contentArea">
                     <div class="div-inf">
                        <h2>정말로 삭제하시겠습니까?</h2>
                     </div>
                     <form id="selDelForm" action="${ path }/admin/board/selectDelete" method="POST">
                        <input type="hidden" name="cateSelDelNo" id="cateSelDelNo">
                        <div class="infSendArea">
                           <input type="submit" class="inf-bt2" value="확인">
                           <button type="button" class="inf-bt1 closeDelBtn">취소</button>
                        </div>
                     </form>
                  </div>
               </div>
               </div>
               <!-- 고객센터 게시글 선택 삭제 모달 기능 -->
               <script>
                  $(function(){
                     // 게시글 삭제
                     $('#allRemoveBtn').click(function(){
                        // 모달 창 띄우기
                        $("#selectRemoveArea").css("display", "block");
                        $('div.div-wrapper, nav, header, footer').css("pointer-events", "none");
                        
                        // 체크된 번호 배열로 묶어서 전달
                        var arrNo = [];
                        var $objects = $('.tdCheck');
                        
                        $.each($objects,function(index,item){
                           if($(item).prop('checked')){
                              // 선택된 값 삭제 창에 전달
                              var selno = $(item).parent('td').siblings('.noTd').html();
                              arrNo.push(selno);
                              $("#cateSelDelNo").val(arrNo);
                           }
                        });
                     });
                     $('button.closeDelBtn').click(function(){
                        $('div.cateUpdArea').css("display", "none");
                        $('div.div-wrapper, nav, header, footer').css("pointer-events", "all");
                     });
                  });
               </script>
               </div>
            </div>
         </div>
      </div>
      </div>
      </div>
   </section>
</div>
</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp"%> 