<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<style>
  .container
</style>

<section class="ftco-section contact-section ftco-degree-bg">
  <div class="container bg-light">
    <div class="col-lg-12 mb-4">
      <div class="card card-primary">
        <div class="card-header">
          <h2 class="h4">게시글 작성</h2>
        </div>
      </div>
      <div class="row block-12">
        <div class="col-md-12 pr-md-5">
          <form id="form1" action="/miniboard/write" method="post">
            <div class="card-body">
              <div class="form-group">
                <label for="exampleInputEmail1">제목</label>
                <input type="text" name="mbTitle" class="form-control" id="exampleInputEmail1" placeholder="제목 입력">
              </div>
              <div class="uploadResult">
                <c:forEach items="${miniDTO.files}" var="attach">
                  <div>
                    <br>
                    <button type="button" onclick="javascript:removeFile('${attach.getFileLink()}')">삭제</button>
                  </div>
                </c:forEach>
              </div>
              <!-- textarea -->
              <div class="form-group">
                <label>내용</label>
                <textarea name="mbContent" class="form-control" rows="3" placeholder="내용 입력"></textarea>
              </div>

              <div class="form-group">
                <label for="exampleInputEmail2">작성자</label>
                <input type="text" name="mbWriter" class="form-control" id="exampleInputEmail2" placeholder="Enter Writer" readonly value="email0@naver.com">
              </div>
              <div class="row">
              </div>
            </div>
            <!-- /.card-body -->
            <div class="temp"></div>
            <div class="card-footer" style="background-color: #141619">
              <button type="submit" id="submitBtn" class="btn btn-primary py-1 px-2">등록</button>
            </div>
          </form>


          <style>
            .uploadResult {
              display: flex;
              justify-content: center;
              flex-direction: row;
            }
          </style>

          <label for="exampleInputFile">Image input</label>
          <div class="input-group">
            <div class="custom-file">
              <input type="file" name="uploadFiles" class="custom-file-input" id="exampleInputFile" multiple placeholder="Choose Image">
              <label class="custom-file-label" for="exampleInputFile">${fileName}</label>
            </div>
            <div class="input-group-append">
              <span class="input-group-text" id="uploadBtn">Upload</span>
            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
</section>

<!-- File Upload -->

<link rel="stylesheet" href="/resources/upload/css/css.css">
<link rel="stylesheet" href="/resources/upload/js/js.js">


<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>

  const uploadResultDiv = document.querySelector(".uploadResult")

  document.querySelector("#uploadBtn").addEventListener("click",(e) => {

    const formData = new FormData()
    const fileInput = document.querySelector("input[name='uploadFiles']")

    for(let i = 0; i < fileInput.files.length; i++){


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
          str += `<div data-uuid='\${uuid}' data-filename='\${fileName}' data-uploadpath='\${uploadPath}' data-image='\${image}' ><img src='/viewFile?file=\${thumbnail}'/>
                          <br><button type="button" onclick="javascript:removeFile('\${fileLink}',this)">삭제</button></div>`
        }else {
          str += `<div data-uuid='\${uuid}' data-filename='\${fileName}' data-uploadpath='\${uploadPath}' data-image='\${image}'><a href='/downFile?file=\${fileLink}'>\${fileName}</a></div>`
        }
      }//end for
      uploadResultDiv.innerHTML += str
      fileInput.value = ""
    })

  },false)

  function removeFile(fileLink,ele){
    console.log(fileLink)
    axios.post("/removeFile", {fileName:fileLink}).then(response => {
      const targetDiv = ele.parentElement
      targetDiv.remove()
    })
  }

  document.querySelector("#submitBtn").addEventListener("click", (e) => {
    e.stopPropagation()
    e.preventDefault()

    const form1 = document.querySelector("#form1")
    const fileDivArr = uploadResultDiv.querySelectorAll("div")

    if(!fileDivArr){
      form1.submit()
      return
    }

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
    form1.submit()

  },false)

</script>

</body>
</html>