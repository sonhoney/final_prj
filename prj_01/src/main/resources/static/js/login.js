$(function(){
    $('.btn_login').click(function(){
        if($('.id').val() == ''){
            $('.id_alert').text('아이디를 입력하세요').css('color','#ff585c').css('font-size','0.75rem');
            $('.id').focus();
            return false;
        }else{
            clear();
        }

        if($('.pw').val() == ''){
            $('.pw_alert').text('비밀번호를 입력하세요').css('color','#ff585c').css('font-size','0.75rem');
            $('.pw').focus();
            return false;
        }else{
            clear();
            let id = $('.id').val();
            alert(id + '님 환영합니다.');
            window.location.href = 's_index.html';
            return false;
        }
        function clear(){
            $('.id_alert').text('');
            $('.pw_alert').text('');
        }
    });
});