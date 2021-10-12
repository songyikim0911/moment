<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header.jsp"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<style>
  #container { margin: auto; height: 200px; width: 600px}
  .slide_wrap { position: relative; width: 400px; height: 200px; margin: auto; padding-bottom: 30px; }
  .slide_box { width: 100%; margin: auto; overflow-x: hidden; text-align: center; }
  #attachList { display: table; float: left; width: 400px; height: 200px;}
  #attachList > p { display: table-cell; vertical-align: middle; text-align: center; font-size: 100px; font-weight: bold; color: #555; }
  .slide_btn_box > button { position: absolute; top: 50%; margin-top: -45px; width: 60px; height: 60px; font-size: 16px; color: #999; background: none; border: 1px solid #ddd; cursor: pointer; }
  .slide_btn_box > .slide_btn_prev { left: -50px; }
  .slide_btn_box > .slide_btn_next { right: -50px; }
  .slide_pagination { position: absolute; left: 50%; bottom: 0; list-style: none; margin: 0; padding: 0; transform: translateX(-50%); }
  .slide_pagination .dot { display: inline-block; width: 15px; height: 15px; margin: 0 5px; overflow: hidden; background: #ddd; border-radius: 50%; transition: 0.3s; }
  .slide_pagination .dot.dot_active { background: #333; }
  .slide_pagination .dot a { display: block; width: 100%; height: 100%; }
</style>

<div class="page-wrapper">
  <div class="page-breadcrumb">
    <div class="row">
      <div class="col-12 d-flex no-block align-items-center">
        <h4 class="page-title">자유게시판</h4>
        <div class="ml-auto text-right">
          <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">자유게시판</li>
            </ol>
          </nav>
        </div>
      </div>
    </div>
  </div>

  <!-- Main content -->
  <section class="content">
    <div class="container bg-light">
      <div class="row">
        <!-- left column -->
        <div class="col-lg-12 mb-4">
          <!-- general form elements -->
          <div class="card card-primary">
            <!-- /.card-header -->
            <!-- form start -->
            <div class="card-body">
              <div class="form-group">
                <label for="exampleInputEmail1">제목</label>
                <input type="text" name="mbTitle" class="form-control" id="exampleInputEmail1" placeholder="제목 입력" readonly value="<c:out value="${miniDTO.mbTitle}"></c:out>">
              </div>
              <div id="container">
                <div class="slide_wrap">
                  <div class="slide_box">
                    <div class="slide_list clearfix">
                      <c:forEach items="${miniDTO.files}" var="attach">
                      <div id="attachList">
                        <c:if test="${attach.image}">
                          <img  onclick="javascript:showOrigin('${attach.getFileLink()}')" src="/viewFile?file=${attach.getThumbnail()}">
                        </c:if>
                      </div>
                      </c:forEach>
                    </div>
                  </div>
                  <div class="slide_btn_box">
                    <button type="button" class="slide_btn_prev">Prev</button>
                    <button type="button" class="slide_btn_next">Next</button>
                  </div>
                  <ul class="slide_pagination"></ul>
                </div>
              </div>
              <br>
              <div class="col-sm-12">
                <!-- textarea -->
                <div class="form-group">
                  <label>내용</label>
                  <textarea name="mbContent" class="form-control" rows="3" placeholder="내용 입력" disabled><c:out value="${miniDTO.mbContent}"></c:out></textarea>
                </div>
              </div>
              <div class="form-group">
                <label for="exampleInputEmail2">작성자</label>
                <input type="text" name="mbWriter" class="form-control" id="exampleInputEmail2" placeholder="Enter Writer" readonly value="<c:out value="${miniDTO.mbWriter}"></c:out>">
              </div>
                </div>
                <div class="card-footer" style="background-color: #141619">
                  <button type="button" class="btn btn-default btnList">목록</button>
    <%--              <sec:authentication property="principal" var="miniDTO" />--%>

    <%--              <c:if test="${miniDTO.writer  eq  memberDTO.mem_id }">--%>
                  <button type="button" class="btn btn-secondary btnMod">수정</button>
    <%--              </c:if>--%>
                </div>
              </div>
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
          <!-- DIRECT CHAT -->
          <div class="card direct-chat direct-chat-primary">
            <div class="card-header">
              <h3 class="card-title">댓글</h3>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
              <!-- Conversations are loaded here -->
              <div class="direct-chat-messages">
                <!-- Message. Default to the left -->
                <div class="direct-chat-msg">
                  <div class="direct-chat-infos clearfix">
                    <span class="direct-chat-name float-left">Alexander Pierce</span>
                    <span class="direct-chat-timestamp float-right">23 Jan 2:00 pm</span>
                  </div>
                  <div class="direct-chat-text">
                    Is this template really for free? That's unbelievable!
                  </div>
                </div>
                <!-- /.direct-chat-msg -->
              </div>
            </div>
            <%--        댓글 버튼--%>
            <div class="reply-paging">
            </div>
          <div class="card-footer">
              <input type="text" name="mbReWriter" placeholder="작성자" readonly value="email1@naver.com">
              <%--        value="<sec:authentication property="principal.mid"/>"--%>
            <p></p>
              <input type="text" name="mbReContent">
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-primary operBtn">댓글 작성</button>
            </div>
          </div>
      </div>
    </div>
  </section>
</div>
<!-- /.content-wrapper -->

<form id="actionForm" action="/miniboard/list" method="get">
    <input type="hidden" name="page" value="${pageRequestDTO.page}">
    <input type="hidden" name="size" value="${pageRequestDTO.size}">

  <c:if test="${pageRequestDTO.type != null}">
    <input type="hidden" name="type" value="${pageRequestDTO.type}">
    <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
  </c:if>
</form>

<div class="modal fade" id="modal-image">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
          <img id="targetImage">
      </div>
      <div class="modal-footer justify-content-between">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<%@include file="../includes/footer.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="/resources/js/reply.js"></script>

<%--대댓글입력창 히든--%>
<script>
function Answer_spread(id){
const getID = document.getElementById(id);
getID.style.display=(getID.style.display=='block') ? 'none' : 'block';
}

function delReply(mbReNo){

  console.log(mbReNo)
  removeReply(mbReNo).then(result => {
    getList()
  })
}
function modReply(mbReNo) {

  const contentId = "mbReContentMod-"+mbReNo
  const mbReContent = document.getElementById(contentId).value
  console.log(mbReContent)


  const replyObj = {mbReNo, mbReContent}
  modifyReply(replyObj).then(result => {
    getList()
  })
}

function reCommentAdd(mbReNo){

  const mbNo = '${miniDTO.mbNo}'
  const mbReWriter = document.getElementById("mbReCommentWriter-"+mbReNo).value
  const mbReContent = document.getElementById("mbReCommentContent-"+mbReNo).value
  const originReNo = document.getElementById("originReNo-"+mbReNo).value
  const reDepth = document.getElementById("reDepth-"+mbReNo).value

  const replyObj = {mbNo, mbReWriter, mbReContent, originReNo, reDepth}

  addReComment(replyObj).then(result => {
    getList()
  })
}
</script>

<script>
  const actionForm = document.querySelector("#actionForm")

  document.querySelector(".btnList").addEventListener("click", () => {actionForm.submit()}, false)

  document.querySelector(".btnMod").addEventListener("click", () => {

    const mbNo = '${miniDTO.mbNo}'

    actionForm.setAttribute("action", "/miniboard/modify")
    actionForm.innerHTML += `<input type = 'hidden' name = 'mbNo' value = '\${mbNo}'>`
    actionForm.submit()}, false)

</script>

<script>

  const modalImage = new bootstrap.Modal(document.querySelector('#modal-image'))

  function showOrigin(fileLink){

    document.querySelector("#targetImage").src = `/viewFile?file=\${fileLink}`
    modalImage.show()
  }

  function after(result) {
    console.log("after............")
    console.log(result)
  }



  //댓글리스트 반복출력
  function getList() {

    const target = document.querySelector(".direct-chat-messages")
    const mbNo = '${miniDTO.mbNo}'

    function convertTemplate(replyObj) {

      const {mbReNo, mbNo, mbReWriter, mbReContent, mbReRegDate, mbReModDate, originReNo, reDepth} = {...replyObj}

      const template = `
                <div class="direct-chat-msg" data-mbReNo='\${mbReNo}' data-mbReWriter='\${mbReWriter}'>
                  <div class="direct-chat-infos clearfix">
                    <div style="border: 1px solid gray; width: 600px; padding: 5px; margin-top: 5px;
                         margin-left: <c:out value="\${20*reDepth}"/>px; display: inline-block">
                      <span class="direct-chat-name float-left">\${mbReWriter}</span>
                      <span class="direct-chat-timestamp float-right">\${mbReRegDate}</span>
                      <div class="direct-chat-text">
                      <div>
                      <p>\${mbReContent}</p>
                      <input type="hidden" name="reDepth" value="\${reDepth}">
                      </div>
                      </div>
                      <p></p>
                      <div>
                      <button type="button" class="btn btn-danger btnDelReply" onclick="javascript:delReply(\${mbReNo})">삭제</button>

                      <%--수정 스프레드--%>
                      <button type="button" class="btn btn-warn btnModReply" onclick="javascript:Answer_spread(\${mbReNo})">수정</button>
                      <div id=\${mbReNo} style="display: none">
                        <div class="card-footer">
                          <input type="text" name="mbReWriterMod-\${mbReNo}" placeholder="작성자" readonly value="\${mbReWriter}">
                          <input type="text" id="mbReContentMod-\${mbReNo}" name="mbReContentMod-\${mbReNo}" value="\${mbReContent}">
                                <input type="hidden" name="mbReNo" value="\${mbReNo}">
                                <input type="hidden" name="originReNo" value="\${originReNo}">
                                <input type="hidden" name="reDepth" value="\${reDepth}">
                              <div class="modal-footer justify-content-between">
                                <button type="button" class="btn btn-primary" onclick="javascript:modReply(\${mbReNo})"> 수정완료</button>
                              </div>
                        </div>
                      </div>
                      <%--수정 스프레드 end--%>

                      <%--대(대)댓글 등록 스프레드--%>
                       <button type="button" class="btn btn-secondary btnAnswer" onclick="javascript:Answer_spread('reComment-\${mbReNo}')">댓글</button>
                        <div id="reComment-\${mbReNo}" style="display: none">
                          <div class="card-footer">
                            <input type="text" id="mbReCommentWriter-\${mbReNo}" name="mbReComWriter" placeholder="작성자" readonly value="\${mbReWriter}">
                              <%--        value="<sec:authentication property="principal.mid"/>"--%>
                            <p></p>
                              <input type="text" id="mbReCommentContent-\${mbReNo}" name="mbReComContent">
                              <input type="hidden" id="originReNo-\${mbReNo}" name="originReNo" value="\${originReNo}">
                              <input type="hidden" id="reDepth-\${mbReNo}" name="reDepth" value="\${reDepth}">

                            <div class="modal-footer justify-content-between">
                              <button type="button" class="btn btn-primary reComment" onclick="javascript:reCommentAdd(\${mbReNo})">작성</button>
                          </div>
                        </div>
                      <%--대댓글 등록 스프레드 end--%>
                    </div>
                  </div>
                </div>`

        return template;
    }

    //댓글 출력
    getReplyList(mbNo, page).then(data => {

      console.log(data)
      let str = "";

      var {dtoList, count} = data

      dtoList.forEach(reply => {
        str += convertTemplate(reply)
      })
      target.innerHTML = str

      showReplyPage(count)
    })
  }

  //최초 실행
  (function () {
    getList()
  })()

  //댓글 페이징
  var page = 1;
  const replyPaging = $(".reply-paging")

  function showReplyPage(count) {
    var endNum = Math.ceil(page/10.0) * 10
    var startNum = endNum - 9

    var prev = startNum != 1
    var next = false;

    if(endNum * 10 >= count){
      endNum = Math.ceil(count/10.0)
    }
    if(endNum * 10 < count){
      next = true
    }
    var str = "<ul class='pagination'>"

    if(prev){
      str +="<li class='page-item'><a class='page-link' href='"+(startNum - 1)+"'>Prev</a></li>"
    }

    for(var i = startNum; i <= endNum; i++){
      var active = page ==1 ? "active":""

      str += "<li class='page-item"+ active +" '><a class='page-link' href='"+i+"'>"+i+"</a></li>"
    }
    if(next){
      str += "<li class='page-item"+ active +" '><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>"
    }

    str += "</ul></div>"

    replyPaging.html(str)

  }

  replyPaging.on("click", "li a", function (e) {
    e.preventDefault()
    console.log("page click")

    var targetPage = $(this).attr("href")

    console.log("targetPage : " + targetPage)

    page = targetPage

    console.log("page : " + page)

    getList()
  })


  document.querySelector(".operBtn").addEventListener("click", function (){

    const mbNo = '${miniDTO.mbNo}'
    const mbReWriter = document.querySelector("input[name='mbReWriter']").value
    const mbReContent = document.querySelector("input[name='mbReContent']").value
    const originReNo = '${replyDTO.originReNo}'
    const reDepth = '${replyDTO.reDepth}'

      const replyObj = {mbNo, mbReWriter, mbReContent, originReNo, reDepth}
      console.log(replyObj)
      addReply(replyObj).then(result => {
        getList()
        document.querySelector("input[name='mbReContent']").value = ""
      })
  }, false)

</script>

<script>
  (function () {
    const slideList = document.querySelector('.slide_list');  // Slide parent dom
    const slideContents = document.querySelectorAll('#attachList');  // each slide dom
    const slideBtnNext = document.querySelector('.slide_btn_next'); // next button
    const slideBtnPrev = document.querySelector('.slide_btn_prev'); // prev button
    const pagination = document.querySelector('.slide_pagination');
    const slideLen = slideContents.length;  // slide length
    const slideWidth = 400; // slide width
    const slideSpeed = 300; // slide speed
    const startNum = 0; // initial slide index (0 ~ 4)

    slideList.style.width = slideWidth * (slideLen + 2) + "px";

    // Copy first and last slide
    let firstChild = slideList.firstElementChild;
    let lastChild = slideList.lastElementChild;
    let clonedFirst = firstChild.cloneNode(true);
    let clonedLast = lastChild.cloneNode(true);

    // Add copied Slides
    slideList.appendChild(clonedFirst);
    slideList.insertBefore(clonedLast, slideList.firstElementChild);

    // Add pagination dynamically
    let pageChild = '';
    for (var i = 0; i < slideLen; i++) {
      pageChild += '<li class="dot';
      pageChild += (i === startNum) ? ' dot_active' : '';
      pageChild += '" data-index="' + i + '"><a href="#"></a></li>';
    }
    pagination.innerHTML = pageChild;
    const pageDots = document.querySelectorAll('.dot'); // each dot from pagination

    slideList.style.transform = "translate3d(-" + (slideWidth * (startNum + 1)) + "px, 0px, 0px)";

    let curIndex = startNum; // current slide index (except copied slide)
    let curSlide = slideContents[curIndex]; // current slide dom
    curSlide.classList.add('slide_active');

    /** Next Button Event */
    slideBtnNext.addEventListener('click', function() {
      if (curIndex <= slideLen - 1) {
        slideList.style.transition = slideSpeed + "ms";
        slideList.style.transform = "translate3d(-" + (slideWidth * (curIndex + 2)) + "px, 0px, 0px)";
      }
      if (curIndex === slideLen - 1) {
        setTimeout(function() {
          slideList.style.transition = "0ms";
          slideList.style.transform = "translate3d(-" + slideWidth + "px, 0px, 0px)";
        }, slideSpeed);
        curIndex = -1;
      }
      curSlide.classList.remove('slide_active');
      pageDots[(curIndex === -1) ? slideLen - 1 : curIndex].classList.remove('dot_active');
      curSlide = slideContents[++curIndex];
      curSlide.classList.add('slide_active');
      pageDots[curIndex].classList.add('dot_active');
    });

    /** Prev Button Event */
    slideBtnPrev.addEventListener('click', function() {
      if (curIndex >= 0) {
        slideList.style.transition = slideSpeed + "ms";
        slideList.style.transform = "translate3d(-" + (slideWidth * curIndex) + "px, 0px, 0px)";
      }
      if (curIndex === 0) {
        setTimeout(function() {
          slideList.style.transition = "0ms";
          slideList.style.transform = "translate3d(-" + (slideWidth * slideLen) + "px, 0px, 0px)";
        }, slideSpeed);
        curIndex = slideLen;
      }
      curSlide.classList.remove('slide_active');
      pageDots[(curIndex === slideLen) ? 0 : curIndex].classList.remove('dot_active');
      curSlide = slideContents[--curIndex];
      curSlide.classList.add('slide_active');
      pageDots[curIndex].classList.add('dot_active');
    });

    /** Pagination Button Event */
    let curDot;
    Array.prototype.forEach.call(pageDots, function (dot, i) {
      dot.addEventListener('click', function (e) {
        e.preventDefault();
        curDot = document.querySelector('.dot_active');
        curDot.classList.remove('dot_active');

        curDot = this;
        this.classList.add('dot_active');

        curSlide.classList.remove('slide_active');
        curIndex = Number(this.getAttribute('data-index'));
        curSlide = slideContents[curIndex];
        curSlide.classList.add('slide_active');
        slideList.style.transition = slideSpeed + "ms";
        slideList.style.transform = "translate3d(-" + (slideWidth * (curIndex + 1)) + "px, 0px, 0px)";
      });
    });
  })();
</script>


</body>
</html>