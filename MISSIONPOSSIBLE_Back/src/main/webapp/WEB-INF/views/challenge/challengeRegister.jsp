<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>    
<%@ include file="../common/header.jsp"%> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>챌린지 등록</title>
	<script src="${ path }/resources/js/jquery-3.6.0.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet"> 
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	<script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
	
	<script src="${path}/resources/summernote/summernote-lite.js"></script>
	<script src="${path}/resources/summernote/lang/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="${path}/resources/summernote/summernote-lite.css">
	
	<style>
	/* 전체 영역--------------------------------------------------------------------------*/
				
			/*---------------제일 바깥 영역 설정-----------------*/
			#box{ 
			   background-color:none;
			   width:100%;
			   height:1000px; /*높이는 각 세부페이지 컨텐츠 보고 알아서 적~당히 설정하기*/
			   margin-top:330px;
			   margin-bottom:100px;
			   margin-left:-10px;
			   padding:10px;
			}
			/*-------------------컨텐츠 영역---------------------*/
			#conbox{
				width:800px; /* 넓이도 각 세부 페이지 컨텐츠에 맞춰서 설정*/
				position:relative; 
				top:20px;
				margin:auto;
			}
			
			    
		/*-----------------------------------------------------------------------------------*/
			
	
	#registerArea{
		clear: both;
		border: 1px solid rgb(224, 239, 132);	
	}
	
	#tb{
	clear: both;
	align:center;
	}
	
	/* 인원수 제한 여부 스위치 */
	.switch-button { position: relative; display: inline-block; width: 40px; height: 20px; } .switch-button input { opacity: 0; width: 0; height: 0; } .onoff-switch { position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0; border-radius:20px; background-color: #ccc; box-shadow: inset 1px 5px 1px #999; -webkit-transition: .4s; transition: .4s; } .onoff-switch:before { position: absolute; content: ""; height: 20px; width: 20px; left: 0px; bottom: 0px; background-color: #fff; -webkit-transition: .5s; transition: .4s; border-radius:20px; } .switch-button input:checked + .onoff-switch { background-color: #1afc1a; box-shadow: inset 1px 5px 1px #1af01a; } .switch-button input:checked + .onoff-switch:before { -webkit-transform: translateX(26px); -ms-transform: translateX(26px); transform: translateX(26px); }

	</style>
</head>
	
<body>
	<div id="box">
	<section id="section">
	<div id="conbox">
		<h1>챌린지 등록</h1>
		<hr>	
			<div id="registerArea">
				<!-- 
						열린 form 태그 추가  
						열린 form 태그 추가
						열린 form 태그 추가
						열린 form 태그 추가
						열린 form 태그 추가
				-->
				<form action="${path}/challenge/challengeRegister" method="POST" enctype="multipart/form-data">
				<table id="tb">
					<tr><!-- &nbsp; : 스페이스 / &ensp; : 스페이스 / &emsp; : 큰스페이스 -->
						<th>챌린지 제목</th>
						<td>
							<input type="text" name="title" style="width:300px" placeholder="사용하실 챌린지명을 적어주세요." required />
						</td>
					</tr>
					<tr>
						<th>챌린지 등록자</th>
						<td><input type="text" name="id" value="${loginMember.id}" readonly></td>
					</tr>
					<tr>
						<th>챌린지 유형</th>
						<td>
			            	<select name="attendStatus" id="attendStatus">
								<option value="" selected>챌린지 유형 선택</option>
								<option value="PUBLIC">타인 참여가능(단체)</option>
								<option value="PRIVATE">타인 참여불가능(개인)</option>
							</select>	
						</td>
					</tr>
					<tr>
						<th>카테고리</th>
						<td>
							<select id="category" name="categoryNo">
								<option value="default" selected>카테고리 선택</option>
							    <option value="EXERCISE">운동</option>
							    <option value="STUDY">공부</option>
							    <option value="HOBBY">취미</option>
							    <option value="HABIT">습관만들기</option>
							    <option value="ETC">직접작성(기타)</option>&nbsp;
							</select>
							<input type="text" id="categoryName" name="categoryName" placeholder="직접 입력시 작성해주세요."/>
							<!-- 
								AJAX 이용해서 카테고리 클릭시 option태그의 text()값을 categoryName값에 저장하게끔 구현해보자
							 -->
							<script>
								$(function(){
									$("#category").on("change", () => {
										
										let catName = $("#category option:selected").text();
										
										console.log("AJAX 들어가기 전 : " + catName);
										
										$.ajax({
											type : "GET",
											url : "categoryNameSet.do",
											data : {
												catName : catName
											},
											success : function(result){
												console.log("AJAX 통신 성공 : " + result);
												$("#categoryName").val(result);
											},
											error : function(e){
												console.log(e);
											},
											complete: function() {
												console.log("complete");
											}
										});
									});
								});
							</script>
						</td>
					</tr>
					<tr>
						<th>모집인원</th>
						<td>
							<input type="number" name="maxCount" id="maxCount" min="1" max="9999"/>
							<label>인원수 제한 없음</label>
							<label class="switch-button">
								<input type="checkbox" id="unlimitedCount"/>
								<span class="onoff-switch"></span>
							</label>
							<script>
							$(()=>{
								$("#attendStatus").on("change", ()=>{
									if($("#attendStatus").val() == "PRIVATE"){
										let input = 1;
										
										$.ajax({	
											type : "GET",
											url : "unlimited.do",
											data : {
												input : input
											},
											success : function(result){
												console.log("AJAX GET 통신 성공 : " + result);
												
												$("#maxCount").val(result).prop("readonly","readonly");
												$("#unlimitedCount").prop("disabled", "disabled");
											},
											error : function(e){
												console.log(e);
											},
											complete: function() {
												console.log("complete");
											}
										});
									} else {
										let input = 2;
										
										$.ajax({	
											type : "GET",
											url : "unlimited.do",
											data : {
												input : input
											},
											success : function(result){
												console.log("AJAX GET 통신 성공 : " + result);
												
												$("#maxCount").val(result).removeAttr("readonly");
												$("#unlimitedCount").removeAttr("disabled");
											},
											error : function(e){
												console.log(e);
											},
											complete: function() {
												console.log("complete");
											}
										});
									}
								});
								
								$("#unlimitedCount").on("change", ()=>{
									if($("#unlimitedCount").is(":checked")){
										let input = 9999;
										
										$.ajax({	
											type : "GET",
											url : "unlimited.do",
											data : {
												input : input
											},
											success : function(result){
												console.log("AJAX GET 통신 성공 : " + result);
												
												$("#maxCount").val(result).prop("readonly");
												$("#unlimitedCount").removeAttr("disabled");
											},
											error : function(e){
												console.log(e);
											},
											complete: function() {
												console.log("complete");
											}
										});
									} else {
										let input = 2;
										
										$.ajax({	
											type : "GET",
											url : "unlimited.do",
											data : {
												input : input
											},
											success : function(result){
												console.log("AJAX GET 통신 성공 : " + result);
												
												$("#maxCount").val(result).removeAttr("readonly");
												$("#unlimitedCount").removeAttr("disabled");
											},
											error : function(e){
												console.log(e);
											},
											complete: function() {
												console.log("complete");
											}
										});
									}
								});
							});
							</script>
						</td>
					</tr>
					<tr>
						<th>등록일</th>
						<td>
							<c:set var="today" value="<%= new java.util.Date() %>"/>
							<c:set var="date">
								<fmt:formatDate value="${ today }" pattern="yyyy-MM-dd"/>
							</c:set>
								
							<input type="hidden" name="enrollDate" value="${ date }"/>
							
							<c:out value="${ date }"/>
						</td>
					</tr>
					<tr>
						<th>모집기간</th>
						<td>
							<input type="date" name="recruitStart" value="${ date }"/> ~ <input type="date" name="recruitEnd" id="recruitEnd"/> 까지 모집함 (선택 날짜에 챌린지 자동 진행)
						</td>
					</tr>
					<!-- 
						recruitEnd의 값이 설정되자마자 startDate로 넘어오게끔 구현해보고 싶음
						AJAX이용하면 될 듯? -> 성공 ~ ^오^b
					 -->
					<script>
						$(function (){
							$("#recruitEnd").on("change", () => {
								
								let inputDate = $("#recruitEnd").val();
								
								console.log("AJAX 들어가기 전 : "+inputDate);
								
								
								
								$.ajax({	
									type : "GET",
									url : "dateChange.do",
									data : {
										inputDate : inputDate
									},
									success : function(result){
										console.log("AJAX GET 통신 성공 : " + result);
										
										$("#startDate").val(result);
									},
									error : function(e){
										console.log(e);
									},
									complete: function() {
										console.log("complete");
									}
								});
								
							});
						});
					</script>
					<tr>
						<th>진행기간</th>
						<td>
							<input type="date" name="startDate" id="startDate"/> ~ <input type="date" name="deadline"/> 까지 챌린지 진행
						</td>
					</tr>
					<tr>
						<th>참여시 차감 포인트</th>
						<td>
							<select name="minusPoint">
								<option value="" selected>참여시 차감될 포인트 양</option>
								<option value="100">100 포인트</option>
								<option value="500">500 포인트</option>
								<option value="1000">1000 포인트</option>
								<option value="3000">3000 포인트</option>
								<option value="5000">5000 포인트</option>
							</select>	
						</td>
					</tr>
					<tr>
						<th>(선택) 오픈 카톡 링크</th>
						<td>
							<input type="text" name="opentalkLink" style="width:300px" placeholder="오픈 카톡방이 있다면 링크를 함께 적어주세요."/>
						</td>
					</tr>
					<tr>
						<th>(선택) 챌린지 썸네일 이미지 첨부</th>
						<td>
							<input type="file" id="upfile" name="upfile">
							<input type="button" id="editfile" name="editfile" value="수정">
							<input type="button" id="deletefile" name="deletefile" value="삭제">
						</td>
					</tr>
					<tr>
						<th>이미지 미리보기</th>
						<td>
							<div id="preview" style="width:200px;height:200px;border:1px solid gray;position:relative;"></div>
						</td>
					</tr>
					<script>
					function handleFileSelect(event) {
					    var input = this;
					    console.log(input.files)
					    if (input.files && input.files.length) {
					        var reader = new FileReader();
					        this.enabled = false
					        reader.onload = (function (e) {
					        console.log(e)
					            $("#preview").html(['<img style="width:200px;height:200px;" class="thumb" src="', e.target.result, '" title="', escape(e.name), '"/>'].join(''))
					        });
					        reader.readAsDataURL(input.files[0]);
					    }
					}
					$('#upfile').change(handleFileSelect);
					$('#deletefile').on('click', ()=> {
					    $("#preview").empty()
					    $("#upfile").val("");
					});
					$('#editfile').click( function() {
					  $("#upfile").click();
					} );
					</script>
					<tr>
						<th>챌린지에 대한 부가설명</th>
						<td>
							<textarea id="summernote" name="content" style="width:700" required
							placeholder=" 챌린지에 대한 상세한 설명을 작성해주세요.&#13;&#10;&#13;&#10;  
											&#13;&#10 작성시 아래와 같은 사항을 주의해 주세요!
											&#13;&#10; 1. 작성 에티켓 문화를 실천해주세요.
											&#13;&#10; 2. 남을 비방하는 내용이나 저속한 표현은 예고없이 삭제됩니다.
											&#13;&#10; 3. 광고성, 상업성 내용이 포함되면 예고 없이 삭제됩니다.
											&#13;&#10; 4. 궁금한 사항은 '고객센터'를 이용해 주시기 바랍니다. "></textarea><br>
						</td>
						<script>
						$(document).ready(function() {
							$('#summernote').summernote({
								  height: 300,                 	// 에디터 높이
								  minHeight: null,             	// 최소 높이
								  maxHeight: 400,             	// 최대 높이
								  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
								  lang: "ko-KR",				// 한글 설정
								  placeholder: '',				//placeholder 설정
							      onImageUpload : function(files, editor, welEditable) {
							    	  for (var i = files.length - 1; i >= 0; i--) {
							    		  sendFile(files[i], this);
							    	  }
							      },
								  toolbar: [
									    // [groupName, [list of button]]
									    ['fontname', ['fontname']],
									    ['fontsize', ['fontsize']],
									    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
									    ['color', ['forecolor','color']],
									    ['table', ['table']],
									    ['para', ['ul', 'ol', 'paragraph']],
									    ['height', ['height']],
									    ['insert',['picture','link','video']],
									    ['view', ['fullscreen', 'help']]
									  ],
									fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
									fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
							});
						});

						function sendFile(file, el) {
						    var form_data = new FormData();
						    form_data.append('file', file);
						    $.ajax({
						    	data: form_data,
						        type: "POST",
						        url: '/image',
						        cache : false,
						        enctype: 'multipart/form-data',
						        contentType : false,
						        processData : false,
						        success: function(url) {
						            $(el).summernote('editor.insertImage', url);
						            $('#imageBoard > ul').append('<li><img src="'+url+'" width="480" height="auto"/></li>');
						          }
						    });
						}
						</script>
					</tr>
					<tr>
						<th colspan="2">
							<input type="submit" value="등록" /> 
							<input type="reset"  value="취소" />
						</th>
					</tr>
				</table>
				<!-- 
						닫힌 form 태그 추가  
						닫힌 form 태그 추가  
						닫힌 form 태그 추가  
						닫힌 form 태그 추가  
						닫힌 form 태그 추가  
				-->
				</form>
			</div>
	</div>
	</section>
	</div>
</body>
</html>

<%@ include file="../common/footer.jsp"%>