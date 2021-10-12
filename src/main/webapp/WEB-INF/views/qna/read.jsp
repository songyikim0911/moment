<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header.jsp"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<style>
  .container
</style>


<div class="page-wrapper">
  <div class="page-breadcrumb">
    <div class="row">
      <div class="col-12 d-flex no-block align-items-center">
        <h4 class="page-title">Q/A게시판</h4>
        <div class="ml-auto text-right">
          <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="/qna/list">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">Q/A게시판</li>
            </ol>
          </nav>
        </div>
      </div>
    </div>
  </div>

<br>  <!-- Main content -->
  <section class="content">
    <div class="container bg-light">
      <div class="row">
        <!-- left column -->
        <div class="col-lg-12 mb-4">
          <!-- general form elements -->
          <div class="card card-primary">
            <div class="card-header">
              <h3 class="card-title">문의내용</h3>
            </div>
            <!-- /.card-header -->
            <!-- form start -->
          <form id="form1">
              <input type="hidden" name="qnaId" value="${qnaDTO.qnaId}">
              <input type="hidden" name="originId" value="${qnaDTO.originId}">
              <input type="hidden" name="page" value="${pageRequestDTO.page}">
              <input type="hidden" name="size" value="${pageRequestDTO.size}">
            <div class="card-body">
              <div class="form-group">
                <label for="exampleInputEmail1">제목</label>
                <input type="text" name="qnaTitle" class="form-control" id="exampleInputEmail1" value="<c:out value="${qnaDTO.qnaTitle}"></c:out>" readonly>
              </div>
              <div class="form-group">
                <label for="exampleInputEmail2">작성자</label>
                <input type="text" name="qnaWriter" class="form-control" id="exampleInputEmail2" value="<c:out value="${qnaDTO.qnaWriter}"></c:out>" readonly>
              </div>
              <div class="row">
                <div class="col-sm-12">
                  <!-- textarea -->
                  <div class="form-group">
                    <label>내용</label>
                    <textarea name="qnaContent" class="form-control" rows="3" disabled><c:out value="${qnaDTO.qnaContent}"></c:out></textarea>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label for="exampleInputEmail0">답변 이메일</label>
                <input type="text" name="qnaAnswerEmail" class="form-control" id="exampleInputEmail0" value="<c:out value="${qnaDTO.qnaAnswerEmail}"></c:out>" readonly>
              </div>
            </div>
            <!-- /.card-body -->
            <div class="card-footer" style="background-color: #141619">
              <button type="button" class="btn btn-default btnList">목록</button>
              <button type="button" class="btn btn-danger btnDel">삭제</button>
              <button type="button" class="btn btn-secondary btnAnswer" onclick="Answer_spread('hiddenAnswer');">답변 등록</button>
            </div>
          </form>
              <div id="hiddenAnswer" style="display: none"><%@include file="../qna/writeAnswer.jsp"%></div>
          </div>
          <!-- /.card -->
        </div>
      </div>
    </div>
  </section>
</div>
<!-- /.content-wrapper -->

<form id="actionForm" action="/qna/list" method="get">
    <input type="hidden" name="page" value="${pageRequestDTO.page}">
    <input type="hidden" name="size" value="${pageRequestDTO.size}">

  <c:if test="${pageRequestDTO.type != null}">
    <input type="hidden" name="type" value="${pageRequestDTO.type}">
    <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
  </c:if>
</form>

<%@include file="../includes/footer.jsp"%>

<script>
  const form = document.querySelector("#form1")
  const actionFrom = document.querySelector("#actionForm")

  document.querySelector(".btnList").addEventListener("click",()=> {actionFrom.submit()}, false)

  document.querySelector(".btnDel").addEventListener("click", e => {
    e.preventDefault();
    e.stopPropagation();

    form.setAttribute("action","/qna/remove")
    form.setAttribute("method","post")
    form.submit()
  }, false)

</script>


<script>

  function Answer_spread(id){
    const getID = document.getElementById(id);
    getID.style.display=(getID.style.display=='block') ? 'none' : 'block';
  }

  function after(result) {
    console.log("after............")
    console.log(result)
  }

</script>

<script>
  const answerform = document.querySelector("#answerform")

  document.querySelector("#submitBtn").addEventListener("click", (e) => {
    e.stopPropagation()
    e.preventDefault()

    answerform.submit()
  },false)

  document.addEventListener('keydown', function(event) {
    if (event.keyCode === 13) {
      event.preventDefault();
    };
  }, true);

</script>


</body>
</html>