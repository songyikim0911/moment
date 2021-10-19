<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header.jsp"%>
<div class="page-wrapper">
    <!-- ============================================================== -->
    <!-- Bread crumb and right sidebar toggle -->
    <!-- ============================================================== -->
    <div class="page-breadcrumb">
        <div class="row">
            <div class="col-12 d-flex no-block align-items-center">
                <h4 class="page-title">회원</h4>
                <div class="ml-auto text-right">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Member</li>
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
                <section class="col-lg-12">
                    <!-- TO DO List -->

                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">회원 목록</h3>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <table class="table table-bordered">
                                <thead>
                                <tr>
                                    <th style="width: 20px">ID(email)</th>
                                    <th>닉네임</th>
                                    <th>가입일</th>
                                    <th>이메일인증</th>
                                    <th>생일</th>
                                    <th>성별</th>
                                    <th>계정상태</th>
                                    <th>차단상태</th>
                                    <th>활성화/차단</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${dtoList}" var="dto">
                                    <tr>
                                        <c:set var="JoinDate" value="${fn:substring(dto.memRegister, 0, 10)}"/>
                                        <c:set var="BirthDate" value="${fn:substring(dto.memBirthday, 0, 10)}"/>
                                        <td><c:out value="${dto.memId}"></c:out></td>
                                        <td><c:out value="${dto.memNick}"></c:out></td>
                                        <td><c:out value="${JoinDate}"></c:out></td>
                                        <td>${dto.memEmailCert == true?"O":"X"}</td>
                                        <td><c:out value="${BirthDate}"></c:out></td>
                                        <td><c:out value="${dto.memSex}"></c:out></td>
                                       <c:choose>
                                           <c:when test="${dto.enabled==false}">
                                               <td>삭제된 계정</td>
                                           </c:when>
                                        <c:when test="${dto.memUnblocked==false}">
                                            <td>차단된 계정</td>
                                        </c:when>
                                           <c:when test="${dto.memEmailCert==false}">
                                               <td>이메일 인증전</td>
                                           </c:when>
                                           <c:otherwise>
                                               <td>활성화된 계정</td>
                                           </c:otherwise>
                                        </c:choose>
                                        <div class="blockBtns">
                                        <td><input type="checkbox" name="blocked" value="false" onClick="return false" ${dto.memUnblocked == false?"checked":""}></td>
                                        <c:choose>
                                        <c:when test="${dto.memUnblocked == true}">
                                            <td><button onclick="blocking(this.value)" class="btn-danger doBlocking" value="${dto.memId}" data-memId="${dto.memId}" data-memUnblocked="${dto.memUnblocked}">차단</button></td>
                                        </c:when>
                                            <c:when test="${dto.memUnblocked == false}">
                                        <td><button onclick="unBlocking(this.value)" class="btn-success doBlocking" value="${dto.memId}" data-memId="${dto.memId}" data-memUnblocked="${dto.memUnblocked}">해제</button></td>
                                            </c:when>
                                        </c:choose>
                                        </div>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>

                            <form action="/member/list" method="get">
                                <input type="hidden" name="page" value="1">
                                <input type="hidden" name="size" value="${pageMaker.size}">
                                <div class="col-sm-3">
                                    <!-- select -->
                                    <div class="form-group-lg">
                                        <label>Search</label>
                                        <select name="type" class="custom-select">
                                            <option value="">----</option>
                                            <option value="T" ${pageRequestDTO.type=="T"?"selected":""}>아이디</option>
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
                                        <li class="page-item"><a class="page-link" href="javascript:movePage(${pageMaker.start -1})"> << </a></li>
                                    </c:if>

                                    <c:forEach begin="${pageMaker.start}" end="${pageMaker.end}" var="num">
                                        <li class="page-item ${pageMaker.page == num?'active':''}"><a class="page-link" href="javascript:movePage(${num})">${num}</a></li>
                                    </c:forEach>

                                    <c:if test="${pageMaker.next}">
                                        <li class="page-item"><a class="page-link" href="javascript:movePage(${pageMaker.end +1})"> >> </a></li>
                                    </c:if>

                                </ul>
                            </div>
                    </div>
                    <!-- /.card -->
                </section>
                <!-- /.Left col -->
            </div>
            <!-- /.row (main row) -->
        </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
</div>

<!-- /.content-wrapper -->


<form id="actionForm" action="/member/list" method="get">
    <input type="hidden" name="page" value="${pageMaker.page}">
    <input type="hidden" name="size" value="${pageMaker.size}">

    <c:if test="${pageRequestDTO.type != null}">
        <input type="hidden" name="type" value="${pageRequestDTO.type}">
        <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
    </c:if>
</form>


<form id="blockingForm" action="/member/doblock" method="post">
<div class="modal fade" id="modal-sm">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">멤버 차단 설정</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>유저를 차단 하시겠습니까?</p>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                <button type="submit" class="btn btn-primary btnBlock" name="memId" value=${memId}>차단</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
</form>


<form id="unBlockingForm" action="/member/dounblock" method="post">
    <div class="modal fade" id="modal-sm2">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">멤버 차단 해제 설정</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>유저의 차단을 해제 하시겠습니까?</p>
                </div>
                <div class="modal-footer justify-content-between">
                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                    <button type="submit" class="btn btn-primary btnUnBlock" name="memId" value=${memId}>해제</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
</form>

<%@include file="../includes/footer.jsp"%>



<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>

    const actionForm = document.querySelector("#actionForm")

    const blockingForm = document.querySelector("#blockingForm")

    const unBlockingForm = document.querySelector("#unBlockingForm")

    function movePage(pageNum){

        actionForm.querySelector("input[name='page']").setAttribute("value",pageNum)
        actionForm.submit()



    }



    //modal 멤버 차단
    const modalDiv= $("#modal-sm")
    const modalDiv2 =$("#modal-sm2")


    function blocking(value){

        modalDiv.modal('show')

        document.querySelector(".btnBlock").addEventListener("click",(e)=>{

            const target = e.target

            if(target.matches(".btnBlock")){
                doBlock(value)
            }

        })

    }

    function unBlocking(value){

        modalDiv2.modal('show')

        document.querySelector(".btnUnBlock").addEventListener("click",(e)=>{

            const target = e.target

            if(target.matches(".btnUnBlock")){
                doUnBlock(value)
            }

        })

    }


    function doBlock(value){
        const memId = value
        const hidden=`<input type='hidden' name='memId' value='\${memId}'>`
        blockingForm.innerHTML += hidden
        blockingForm.submit()



    }

    function doUnBlock(value){
        const memId = value
        const hidden2=`<input type='hidden' name='memId' value='\${memId}'>`
        unBlockingForm.innerHTML += hidden2
        unBlockingForm.submit()


    }


</script>



</body>
</html>
