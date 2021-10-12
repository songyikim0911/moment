<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header.jsp"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="page-wrapper">
  <div class="page-breadcrumb">
    <div class="row">
      <div class="col-12 d-flex no-block align-items-center">
        <h4 class="page-title">Q/A</h4>
        <div class="ml-auto text-right">
          <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="/qna/list">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">Q/A</li>
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
            <div class="card-header">
              <h3 class="card-title">Q/A 작성</h3>
            </div>
            <!-- /.card-header -->
            <!-- form start -->
            <form id="form1" action="/qna/write" method="post">
              <div class="card-body">
                <div class="form-group">
                  <label for="exampleInputEmail1">제목</label>
                  <input type="text" name="qnaTitle" class="form-control" id="exampleInputEmail1" placeholder="제목 입력">
                </div>
                <div class="form-group">
                  <label for="exampleInputEmail2">작성자</label>
                  <input type="text" name="qnaWriter" class="form-control" id="exampleInputEmail2" placeholder="Enter Writer" readonly value="email0@naver.com">
                </div>
                <div class="row">
                  <div class="col-sm-12">
                    <!-- textarea -->
                    <div class="form-group">
                      <label>내용</label>
                      <textarea name="qnaContent" class="form-control" rows="3" placeholder="내용 입력"></textarea>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label for="exampleInputEmail0">답변 이메일</label>
                  <input type="text" name="qnaAnswerEmail" class="form-control" id="exampleInputEmail0" value="<c:out value="${qnaDTO.qnaWriter}"></c:out>">
                                                                                                                      <%--이메일 자동입력 변경 필요 --%>
                </div>
              </div>

              <!-- /.card-body -->

              <div class="temp"></div>

              <div class="card-footer" style="background-color: #141619">
                <button type="submit" id="submitBtn" class="btn btn-primary py-1 px-2">등록</button>
              </div>
            </form>

          </div>
          <!-- /.card -->
        </div>
      </div>
    </div>
  </section>
</div>
<!-- /.content-wrapper -->

<%@include file="../includes/footer.jsp"%>

<%--axios스크립트--%>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>

  document.querySelector("#submitBtn").addEventListener("click", (e) => {
    e.stopPropagation()
    e.preventDefault()

    const form1 = document.querySelector("#form1")

    let str ="";

    document.querySelector(".temp").innerHTML = str
    form1.submit()

  },false)

  document.addEventListener('keydown', function(event) {
    if (event.keyCode === 13) {
      event.preventDefault();
    };
  }, true);

</script>

</body>
</html>