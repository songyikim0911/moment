<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header.jsp"%>

<div class="page-wrapper">
    <!-- ============================================================== -->
    <!-- Bread crumb and right sidebar toggle -->
    <!-- ============================================================== -->
    <div class="page-breadcrumb">
        <div class="row">
            <div class="col-12 d-flex no-block align-items-center">
                <h4 class="page-title">공지사항 게시판</h4>
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
        <div class="container bg-light">
            <div class="row">
                <!-- left column -->
                <div class="col-lg-12 mb-4">
                    <!-- general form elements -->
                    <div class="card card-primary">
                        <div class="card-header">
                            <h3 class="card-title">공지사항</h3>
                        </div>
                        <!-- /.card-header -->

                        <div class="card-body">
                            <div class="form-group">
                                <label for="exampleInputEmail10">번호</label>
                                <input type="text" name="noticeNo" class="form-control" id="exampleInputEmail10" value="<c:out value="${noticeDTO.noticeNo}"></c:out>" readonly>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputEmail1">제목</label>
                                <input type="text" name="noticeTitle" class="form-control" id="exampleInputEmail1" value="<c:out value="${noticeDTO.noticeTitle}"></c:out>" readonly>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <!-- textarea -->
                                    <div class="form-group">
                                        <label>내용</label>
                                        <textarea name="noticeContent" class="form-control" rows="3" disabled><c:out value="${noticeDTO.noticeContent}"></c:out>
                                        </textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.card-body -->

                        <div class="card-footer" style="background-color: #141619">
                            <button type="button" class="btn btn-default btnList">목록</button>
                            <button type="button" class="btn btn-secondary btnMod">수정</button>
                        </div>

                            <div>
                                <c:forEach items="${noticeDTO.files}" var="attach">
                                    <div>
                                            <c:if test="${attach.image}">
                                                <img onclick="javascript:showOrigin('${attach.getFileLink()}')" src="/viewFile?file=${attach.getThumbnail()}">
                                            </c:if>
                                            ${attach.fileName}
                                            </div>
                                </c:forEach>
                            </div>
                    </div>

                </div>
            </div>
        </div>
    </section>
</div>
<!-- /.content-wrapper -->

<form id="actionForm" action="/notice/list" method="get">
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

<script>
    const actionFrom = document.querySelector("#actionForm")

    document.querySelector(".btnList").addEventListener("click",()=> {actionFrom.submit()}, false)

    document.querySelector(".btnMod").addEventListener("click",()=> {

        const noticeNo = '${noticeDTO.noticeNo}'

        actionFrom.setAttribute("action","/notice/modify")
        actionForm.innerHTML +=`<input type='hidden' name='noticeNo' value='\${noticeNo}'>`
        actionFrom.submit()
    }, false)

</script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>


<script>

    const modalImage = new bootstrap.Modal(document.querySelector('#modal-image'))

    function showOrigin(fileLink){

        document.querySelector("#targetImage").src = `/viewFile?file=\${fileLink}`
        modalImage.show()
    }

    function after(result){
        console.log("after............")
        console.log("result", result)
    }



</script>

</body>
</html>
