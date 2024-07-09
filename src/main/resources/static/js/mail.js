$(document).ready(function() {
    openModal();

});

function openModal(element) {
    //  const mailId = element.getAttribute('th:value');
    // const noteContent = element.getAttribute('data-content');
    let mailId= $(element).attr('data-mail-number');
    console.log(mailId);
    // 모달 요소 가져오기
    const modal = document.querySelector('.modal');

    // 모달 열기
    modal.style.display = 'flex';


    $.ajax({
        url: '/ParentMyPageRest/mailDetail',
        type: 'GET',
        contentType: 'application/json',
        data: { mailId: mailId },
        success: function(data) {

            console.log(data);
            console.log("데이터 가져오기 성공");
            // 이름가져오기
            $('#parent').val(data.proName);

            // // 세부정보 가져오기
            $('#textarea').val(data.parentNoteContent);


        },
        error: function(data) {
            console.error("데이터 가져오기 실패", data);
        }
    });



    // // 닫기 버튼 설정
    const closeModalButton = document.querySelector('#close-btn');
    closeModalButton.addEventListener('click', function() {
        modal.style.display = 'none';
    });
}
