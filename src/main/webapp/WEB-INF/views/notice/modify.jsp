<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header.jsp"%>

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
                            <li class="breadcrumb-item active" aria-current="page">공지사항</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>


    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <!-- left column -->
                <div class="col-md-12">
                    <!-- general form elements -->
                    <div class="card card-primary">
                        <div class="card-header">
                            <h3 class="card-title"> Notice Modify </h3>
                        </div>
                        <!-- /.card-header -->
                        <form id="form1">
                            <input type="hidden" name="page" value="${pageRequestDTO.page}">
                            <input type="hidden" name="size" value="${pageRequestDTO.size}">

                            <c:if test="${pageRequestDTO.type != null}">
                                <input type="hidden" name="type" value="${pageRequestDTO.type}">
                                <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
                            </c:if>

                            <div class="card-body">
                                <div class="form-group">
                                    <label for="exampleInputEmail10">번호</label>
                                    <input type="text" name="noticeNo" class="form-control" id="exampleInputEmail10" value="<c:out value="${noticeDTO.noticeNo}"></c:out>" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">제목</label>
                                    <input type="text" name="noticeTitle" class="form-control" id="exampleInputEmail1" value="<c:out value="${noticeDTO.noticeTitle}"></c:out>" >
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <!-- textarea -->
                                        <div class="form-group">
                                            <label>내용</label>
                                            <textarea name="noticeContent" class="form-control" rows="3" ><c:out value="${noticeDTO.noticeContent}"></c:out>
                                        </textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="temp"></div>
                            <!-- /.card-body -->

                            <div class="card-footer">
                                <button type="submit" class="btn btn-default btnList">목록</button>
                                <button type="submit" class=" btn btn-secondary btnMod">수정</button>
                                <button type="submit" class="btn btn-danger btnDel">삭제</button>
                            </div>
                        </form>
                    </div>

                    <label for="exampleInputFile">File input</label>
                    <div class="input-group">
                        <div class="custom-file">
                            <input type="file" name="uploadFiles" class="custom-file-input" id="exampleInputFile" multiple>
                            <label class="custom-file-label" for="exampleInputFile">Choose file</label>
                        </div>
                        <div class="input-group-append">
                            <span class="input-group-text" id="uploadBtn">Upload</span>
                        </div>
                    </div>

                    <div class="uploadResult">
                        <c:forEach items="${noticeDTO.files}" var="attach">
                            <div data-uuid="${attach.uuid}" data-filename="${attach.fileName}" data-uploadpath="${attach.uploadPath}"
                                 data-image="${attach.image}">
                                <c:if test="${attach.image}">
                                    <img src="/viewFile?file=${attach.getThumbnail()}">
                                </c:if>
                                <span>${attach.fileName}</span>
                                <button onclick="javascript:removeDiv(this)" >x</button>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- /.card -->
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


<%@include file="../includes/footer.jsp"%>

<script>
    const form = document.querySelector("#form1")
    const actionForm = document.querySelector("#actionForm")

    document.querySelector(".btnList").addEventListener("click", (e) => {
        e.preventDefault()
        e.stopPropagation()
        actionForm.submit();
    },false);

    document.querySelector(".btnDel").addEventListener("click", (e) => {
        e.preventDefault()
        e.stopPropagation()

        form.setAttribute("action","/notice/remove")
        form.setAttribute("method","post")
        form.submit()

    },false);

    document.querySelector(".btnMod").addEventListener("click", (e) => {
        e.preventDefault()
        e.stopPropagation()

        const fileDivArr = uploadResultDiv.querySelectorAll("div")

        if(fileDivArr && fileDivArr.length > 0){
            let str ="";
            for(let i = 0; i < fileDivArr.length; i++){
                const target = fileDivArr[i]
                const uuid = target.getAttribute("data-uuid")
                const fileName = target.getAttribute("data-filename")
                const uploadPath = target.getAttribute("data-uploadpath")
                const image = target.getAttribute("data-image")

                str += `<input type='hidden' name='files[\${i}].uuid' value='\${uuid}' >`
                str += `<input type='hidden' name='files[\${i}].fileName' value='\${fileName}' >`
                str += `<input type='hidden' name='files[\${i}].uploadPath' value='\${uploadPath}' >`
                str += `<input type='hidden' name='files[\${i}].image' value='\${image}' >`
            }
            document.querySelector(".temp").innerHTML = str
        }//end if

        form.setAttribute("action","/notice/modify")
        form.setAttribute("method","post")
        form.submit()

    },false);


</script>


<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script>

    const uploadResultDiv = document.querySelector(".uploadResult")

    document.querySelector("#uploadBtn").addEventListener("click",(e) => {

        const formData = new FormData()
        const fileInput = document.querySelector("input[name='uploadFiles']")

        for(let i = 0; i < fileInput.files.length; i++){

            //console.log(fileInput.files[i])

            formData.append("uploadFiles", fileInput.files[i])
        }

        console.log(formData)

        const headerObj = { headers: {'Content-Type': 'multipart/form-data'}}

        axios.post("/upload", formData, headerObj).then((response) => {
            const arr = response.data
            console.log(arr)
            let str = ""
            for(let i = 0; i < arr.length; i++){
                const {uuid,fileName,uploadPath,image,thumbnail,fileLink} = {...arr[i]}

                if(image){
                    str += `<div data-uuid='\${uuid}' data-filename='\${fileName}' data-uploadpath='\${uploadPath}' data-image='\${image}' ><img src='/viewFile?file=\${thumbnail}'/><span>\${fileName}</span>
                            <button onclick="javascript:removeDiv(this)">x</button></div>`
                }else {
                    str += `<div data-uuid='\${uuid}'data-filename='\${fileName}' data-uploadpath='\${uploadPath}' data-image='\${image}'><a href='/downFile?file=\${fileLink}'>\${fileName}</a></div>`
                }


            }//end for
            uploadResultDiv.innerHTML += str

        })


    },false)

    function removeDiv(ele){
        ele.parentElement.remove()
    }

</script>

</body>
</html>
