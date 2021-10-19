<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header.jsp"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

    <div class="page-wrapper">
        <div class="page-breadcrumb">
            <div class="row">
                <div class="col-12 d-flex no-block align-items-center">
                    <h4 class="page-title">자유게시판</h4>
                    <div class="ml-auto text-right">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="#">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Board</li>
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
                    <section class="col-lg-12">
                        <section class="content">
                            <div class="container-fluid">
                                        <div class="card-body">
                                            <div>
                                            <%@include file="../miniboard/write.jsp"%>
                                            </div>
                                        </div>
                                        <div class="card">
                                            <!-- /.card-header -->
                                            <div class="card-body">
                                                <div>
                                                    <h2></h2>
                                                </div>
                                                <table class="table table-bordered">
                                                    <thead>
                                                    <tr>
                                                        <th style="width: 400px">내용</th>
<%--                                                        <th>Writer</th>--%>
                                                        <th>작성자</th>
                                                        <th>등록일</th>
                                                    </tr>
                                                    </thead>
                                                <form id="form2">
                                                    <input type="hidden" name="page" value="${pageRequestDTO.page}">
                                                    <input type="hidden" name="size" value="${pageRequestDTO.size}">
                                                    <tbody>
                                                    <c:forEach items="${dtoList}" var="dto">
                                                    <input type="hidden" name="mbNo" value="${dto.mbNo}">
                                                    <tr>
                                                        <td><a href="javascript:moveRead(${dto.mbNo})"><c:out value="${dto.mbTitle}[${dto.mbReCount}]"></c:out></a></td>
                                                        <td><c:out value="${dto.mbWriter}"></c:out></td>
                                                        <td>
                                                            <fmt:parseDate value="${dto.mbRegDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                                            <fmt:formatDate pattern="yyyy-MM-dd" value="${parsedDateTime}"/>
                                                        </td>
                                                    </tr>
                                                    </c:forEach>
                                                    </tbody>
                                                </form>
                                                </table>
                                            <form action="/miniboard/list" method="get">
                                                <input type="hidden" name="page" value=1>
                                                <input type="hidden" name="size" value="${pageMaker.size}">
                                                <div class="col-sm-3">
                                                    <!-- select -->
                                                    <div class="form-group-lg">
                                                        <label>Custom Select</label>
                                                        <select name="type" class="custom-select">
                                                            <option value="C" ${pageRequestDTO.type=="C"?"selected":""}>내용</option>
                                                            <option value="W" ${pageRequestDTO.type=="W"?"selected":""}>작성자</option>
                                                            <option value="CW" ${pageRequestDTO.type=="CW"?"selected":""}>내용+작성자</option>
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
<div class="modal fade" id="modal-lg">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">글 수정</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="hidden" name="reNo">
                <input type="text" name="reWriter">
                <input type="text" name="reContent">
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-info modBtn">수정</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
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
                <p>등록이 완료 되었습니다.&hellip;</p>
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
<form id="actionForm" action="/miniboard/list" method="get">
    <input type="hidden" name="page" value="${pageMaker.page}">
    <input type="hidden" name="size" value="${pageMaker.size}">

    <c:if test="${pageRequestDTO.type != null}">
    <input type="hidden" name="type" value="${pageRequestDTO.type}">
    <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
    </c:if>
</form>

<%@include file="../includes/footer.jsp"%>


<script>
    const form = document.querySelector("#form2")
    const actionForm = document.querySelector("#actionForm")

    const result = '${result}'

    if(result && result !== '') {
        $('#modal-sm').modal('show')

        window.history.replaceState(null, '', '/miniboard/list');
    }

    function movePage(pageNum){

        actionForm.querySelector("input[name='page']").setAttribute("value", pageNum)

        actionForm.submit()

    }

    function moveRead(mbNo){

        actionForm.setAttribute("action", "/miniboard/read")
        actionForm.innerHTML += `<input type = 'hidden' name = 'mbNo' value = '\${mbNo}'>`
        actionForm.submit()
    }

</script>


</body>
</html>