<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header.jsp" %>

<div class="page-wrapper">
    <!-- ============================================================== -->
    <!-- Bread crumb and right sidebar toggle -->
    <!-- ============================================================== -->
    <div class="page-breadcrumb">
        <div class="row">
            <div class="col-12 d-flex no-block align-items-center">
                <h4 class="page-title">공지사항</h4>
                <div class="ml-auto text-right">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Notice</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>


    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <!-- Main row -->
            <div class="row">
                <!-- Left col -->
                <section class="col-lg-12 mb-4">
                    <!-- TO DO List -->
                    <div class="container bg-light">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">목록</h3>
                                <div align="right">
                                    <button class="btn btn-outline-primary"><a href="/notice/write">게시글등록</a></button>
                                </div>
                            </div>

                            <!-- /.card-header -->
                            <div class="card-body">
                                <table class="table table-bordered">
                                    <thead>
                                    <tr style="">
                                        <th style="width: 65px" align="center">번호</th>
                                        <th>제목</th>
                                        <th>등록일</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${dtoList}" var="dto">
                                        <tr>
                                            <td><c:out value="${dto.noticeNo}"></c:out></td>
                                            <td><a href="javascript:moveRead(${dto.noticeNo})"><c:out
                                                    value="${dto.noticeTitle}"></c:out></a></td>
                                            <td><c:out value="${dto.noticeRegDate}"></c:out></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>

                                <form action="/notice/list" method="get">
                                    <input type="hidden" name="page" value="1">
                                    <input type="hidden" name="size" value="${pageMaker.size}">
                                    <div class="col-sm-3">
                                        <!-- select -->
                                        <div class="form-group-lg">
                                            <label>Search</label>
                                            <select name="type" class="custom-select">
                                                <option value="">----</option>
                                                <option value="T" ${pageRequestDTO.type=="T"?"selected":""}>제목</option>
                                                <option value="TC" ${pageRequestDTO.type=="TC"?"selected":""}>제목내용
                                                </option>
                                                <option value="C" ${pageRequestDTO.type=="C"?"selected":""}>내용</option>
                                            </select>
                                            <div class="input-group input-group-sm">
                                                <input type="text" class="form-control" name="keyword"
                                                       value="${pageRequestDTO.keyword}">
                                                <span class="input-group-append">
                                            <button type="submit" class="btn btn-info btn-flat">Go!</button>
                                            </span>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <!-- /.card-body -->


                                <div class="card-footer clearfix">
                                    <ul class="pagination pagination-sm m-0 float-right">

                                        <c:if test="${pageMaker.prev}">
                                            <li class="page-item"><a class="page-link"
                                                                     href="javascript:movePage(${pageMaker.start -1})">
                                                << </a></li>
                                        </c:if>

                                        <c:forEach begin="${pageMaker.start}" end="${pageMaker.end}" var="num">
                                            <li class="page-item ${pageMaker.page == num?'active':''}"><a
                                                    class="page-link" href="javascript:movePage(${num})">${num}</a></li>
                                        </c:forEach>

                                        <c:if test="${pageMaker.next}">
                                            <li class="page-item"><a class="page-link"
                                                                     href="javascript:movePage(${pageMaker.end +1})">
                                                >> </a></li>
                                        </c:if>

                                    </ul>
                                </div>
                            </div>
                            <!-- /.card -->
                        </div>
                    </div>
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
                <p>One fine body&hellip;</p>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<form id="actionForm" action="/notice/list" method="get">
    <input type="hidden" name="page" value="${pageMaker.page}">
    <input type="hidden" name="size" value="${pageMaker.size}">

    <c:if test="${pageRequestDTO.type != null}">
        <input type="hidden" name="type" value="${pageRequestDTO.type}">
        <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
    </c:if>
</form>

<%@include file="../includes/footer.jsp" %>

<script>

    const actionForm = document.querySelector("#actionForm")

    const result = '${result}'

    if (result && result !== '') {
        $('#modal-sm').modal('show')

        window.history.replaceState(null, '', '/notice/list');
    }

    function movePage(pageNum) {

        actionForm.querySelector("input[name='page']").setAttribute("value", pageNum)
        actionForm.submit()

    }

    function moveRead(noticeNo) {

        actionForm.setAttribute("action", "/notice/read")
        actionForm.innerHTML += `<input type='hidden' name='noticeNo' value='\${noticeNo}'>`
        actionForm.submit()

    }

</script>


</body>
</html>