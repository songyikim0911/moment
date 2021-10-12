<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<div class="page-wrapper">
    <!-- ============================================================== -->
    <!-- Bread crumb and right sidebar toggle -->
    <!-- ============================================================== -->
    <div class="page-breadcrumb">
        <div class="row">
            <div class="col-12 d-flex no-block align-items-center">
                <h4 class="page-title"></h4>
                <div class="ml-auto text-right">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="#"></a></li>
                            <li class="breadcrumb-item active" aria-current="page"></li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>


<form id="form1" action="/member/join" method="post">
    <div class="card-body">
        <div class="form-group">
            <label for="exampleInputEmail1">아이디(이메일)</label>
            <input type="text" name="memId" class="form-control" placeholder="Enter Id">
        </div>
        <div class="form-group">
            <label for="exampleInputEmail1">닉네임(선택)</label>
            <input type="text" name="memNick" class="form-control" placeholder="Enter Nickname">
        </div>
        <div class="form-group">
            <label for="exampleInputEmail1">비밀번호</label>
            <input type="password" name="memPwd" class="form-control"  id="exampleInputEmail1" placeholder="Enter Password">
        </div>
        <div>성별
        <select name="memSex">
            <option value="남">남</option>
            <option value="여">여</option>
            <option value="선택없음" selected>선택없음</option>
        </select>
        </div>
        <div>기념일
            <input type="text" id="datepicker" placeholder="날짜선택" name="memBirthday">
        </div>

    </div>
    <div class="card-footer">
        <button type="submit"  class="btn btn-primary btnAdd">Submit</button>
    </div>

</form>

</div>
    <!-- /.card-body -->

<%@include file="../includes/footer.jsp"%>


<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>

    $(function () {
        $("#datepicker").datepicker();
    });

    $(function () {
        $("#datepicker2").datepicker();
    });



</script>

