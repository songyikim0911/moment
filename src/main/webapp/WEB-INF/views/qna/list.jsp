<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<%@include file="../includes/header.jsp"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>



<style>
    .container
</style>

<div class="page-wrapper">
    <div class="page-breadcrumb">
        <div class="row">
            <div class="col-12 d-flex no-block align-items-center">
                <h4 class="page-title">Q/A</h4>
                <div class="ml-auto text-right">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Q/A</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <!-- /.row -->
                <!-- Main row -->
                <div class="row">
                    <!-- Left col -->
                    <section class="col-lg-12 mb-4">
                        <section class="content">
                            <div class="container bg-light">
                                        <div class="card">
                                            <div class="card-header">
                                                <h3 class="card-title">목록</h3>
<%--                                                <sec:authorize access="isAuthenticated()">--%>
                                                <button type="button" class="btn btn-outline-primary" style="float: right;"><a href="/qna/write">문의작성</a> </button>
<%--                                                </sec:authorize>--%>
                                            </div>
                                            <!-- /.card-header -->
                                        <div class="card-body">
                                                <table class="table table-bordered">
                                                    <thead>
                                                    <tr>
                                                        <th style="width: 400px">제목</th>
<%--                                                        <th>Writer</th>--%>
                                                        <th>작성일</th>
                                                        <th>작성자</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <c:forEach items="${dtoList}" var="dto">
                                                    <tr>
                                                        <td><a href="javascript:moveRead(${dto.qnaId})"><c:out value="${dto.qnaTitle}"></c:out></a></td>
<%--                                                        <td><c:out value="${dto.qnaWriter}"></c:out></td>--%>
                                                        <td>
                                                            <fmt:parseDate value="${dto.qnaRegDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                                            <fmt:formatDate pattern="yyyy-MM-dd" value="${parsedDateTime}"/>
                                                        </td>
                                                        <td><c:out value="${dto.qnaWriter}"></c:out></td>
                                                    </tr>
                                                    </c:forEach>
                                                    </tbody>
                                                </table>
                                            <form action="/qna/list" method="get">
                                                <input type="hidden" name="page" value=1>
                                                <input type="hidden" name="size" value="${pageMaker.size}">
                                                <div class="col-sm-3">
                                                    <!-- select -->
                                                    <div class="form-group-lg">
                                                        <label>Custom Select</label>
                                                        <select name="type" class="custom-select">
                                                            <option value="T" ${pageRequestDTO.type=="T"?"selected":""}>제목</option>
                                                            <option value="C" ${pageRequestDTO.type=="C"?"selected":""}>내용</option>
                                                            <option value="TC" ${pageRequestDTO.type=="TC"?"selected":""}>제목+내용</option>
                                                            <option value="W" ${pageRequestDTO.type=="W"?"selected":""}>작성자</option>
                                                            <option value="TCW" ${pageRequestDTO.type=="TCW"?"selected":""}>제목+내용+작성자</option>
                                                        </select>
                                                        <div class="input-group input-group-sm">
                                                            <input type="text" class="form-control" name="keyword" value="<c:out value="${pageRequestDTO.keyword}"></c:out>">
                                                            <span class="input-group-append">
                                                             <button type="submit" class="btn btn-info btn-flat">Go!</button>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>

                                        </div>
                                            <!-- /.card-body -->

                                            <div class="card-footer clearfix">
                                                <ul class="pagination pagination-sm m-0 float-right">
                                                    <c:if test="${pageMaker.prev}">
                                                      <li class="page-item"><a class="page-link" href="javascript:movePage(${pageMaker.start - 1})">이전</a></li>
                                                    </c:if>

                                                    <c:forEach var="num" begin="${pageMaker.start}" end="${pageMaker.end}">
                                                        <li class="page-item ${pageMaker.page == num ? 'active':''}"><a class="page-link" href="javascript:movePage(${num})">${num}</a></li>
                                                    </c:forEach>

                                                    <c:if test="${pageMaker.next}">
                                                        <li class="page-item"><a class="page-link" href="javascript:movePage(${pageMaker.end + 1})">다음</a>
                                                        </li>
                                                    </c:if>
                                                </ul>
                                            </div>
                                            <!-- /.end Pagination -->
                                        </div>
                                        <!-- /.card -->
                                    </div>
                        </section>
                    </section>
                    <!-- /.Left col -->
                </div>
                <!-- /.row (main row) -->
            </div><!-- /.container-fluid -->
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
<div class="modal fade" id="modal-sm">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Small Modal</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>문의 등록이 완료 되었습니다.&hellip;</p>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<form id="actionForm" action="/qna/list" method="get">
    <input type="hidden" name="page" value="${pageMaker.page}">
    <input type="hidden" name="size" value="${pageMaker.size}">

    <c:if test="${pageRequestDTO.type != null}">
    <input type="hidden" name="type" value="${pageRequestDTO.type}">
    <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
    </c:if>
</form>

<%@include file="../includes/footer.jsp"%>

<script>

    const actionForm = document.querySelector("#actionForm")

    const result = '${result}'

    if(result && result !== '') {
        $('#modal-sm').modal('show')

        window.history.replaceState(null, '', '/qna/list');
    }

    function movePage(pageNum){

        actionForm.querySelector("input[name='page']").setAttribute("value", pageNum)

        actionForm.submit()

    }

    function moveRead(qnaId){

        actionForm.setAttribute("action", "/qna/read")
        actionForm.innerHTML += `<input type = 'hidden' name = 'qnaId' value = '\${qnaId}'>`
        actionForm.submit()
    }

</script>

</body>
</html>