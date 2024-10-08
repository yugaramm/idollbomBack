$(document).ready(function() {
    prevImage();
    test();
    document.querySelector("#searchAddress").addEventListener("click", execDaumPostcode);
});

// 이미지를 미리 불러오는 js
function prevImage(input) {
    if (input.files && input.files[0]) {
        let reader = new FileReader();
        reader.onload = function (e) {
            document.getElementById('preview').src = e.target.result;
            document.getElementById('myfie').src=e.target.result;
            let myFileInput = document.getElementById('myfile');
            myFileInput.files = input.files;

        };
        reader.readAsDataURL(input.files[0]);
    } else {
        document.getElementById('preview').src = "";

    }
}

function handleFileChange(input) {
    // 여기서 두 번째 파일 입력 요소에서 선택한 파일에 대한 처리를 진행
    console.log(input.files);
    // 예시로 콘솔에 출력
}

//유효성검사
function test() {
    let p1 = document.getElementById('childName').value;
    let p2 = document.getElementById('childInstruct').value;
    let p3 = document.getElementById('presentNew').value;

    if (p3 != p2) {
        alert("비밀번호가 일치 하지 않습니다");
        return false;
    } else if (p1 == p3) {
        alert("현재 비밀번호와 같습니다");
        return false;
    } else {
        var newPassword = document.getElementById('hiddenPassword');
        newPassword.value = p2;
        console.log(p2);
        const btnSubmitModal=document.querySelector('.regist-btn');
        btnSubmitModal.addEventListener("click", ()=>{
            modal.style.display="none";
        });
        alert("성공적으로 수정되었습니다.");
    }
    document.getElementById('childName').value = '';
    document.getElementById('presentNew').value = '';
    document.getElementById('childInstruct').value = '';
}


