$(function(){
    //회원가입 버튼
    $('.join').click(function(){
        if($('.id').val() == ''){
            $('.id_alert').text('아이디를 입력하세요').css('color','#ff585c').css('font-size','0.75rem');
            $('.id').focus();
            return false;
        }else{
            clear();
        }

        let idTerms = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,20}$/;
        let id = $('.id').val();
        if(!idTerms.test(id)){
            $('.id_alert').text('6~20자리의 영문,숫자를 조합하여 입력하세요').css('color','#ff585c').css('font-size','0.75rem');
            $('.id').val("");
            $('.id').focus();
            return false;
        }

        if($('.pw1').val() == ''){
            $('.pw1_alert').text('비밀번호를 입력하세요').css('color','#ff585c').css('font-size','0.75rem');
            $('.pw1').focus();
            return false;
        }else{
            clear();
        }

        let pwTerms = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,20}$/;
        let pw1 = $('.pw1').val();
        let pw2 = $('.pw2').val();
        if(!pwTerms.test(pw1)){
            $('.pw1_alert').text('6~20자리의 영문,숫자,특수문자 를 조합하여 입력하세요').css('color','#ff585c').css('font-size','0.75rem');
            $('.pw1').val("");
            $('.pw1').focus();
            return false;
        }

        if($('.pw2').val() == ''){
            $('.pw2_alert').text('비밀번호를 확인하세요').css('color','#ff585c').css('font-size','0.75rem');
            $('.pw2').focus();
            return false;
        }else{
            clear();
        }

        if(pw1 != pw2){
            $('.pw2_alert').text('비밀번호가 일치하지 않습니다.').css('color','#ff585c').css('font-size','0.75rem');
            $('.pw2').val("");
            $('.pw2').focus();
            return false;
        }

        if($('.email').val() == ''){
            $('.email_alert').text('이메일을 입력하세요').css('color','#ff585c').css('font-size','0.75rem');
            return false;
        }else{
            clear();
        }

        let emailTerms = /^\w{3,12}@[a-z]{2,10}[\.][a-z]{2,3}[\.]?[a-z]{0,2}$/;
        let email = $('.email').val();
        if(emailTerms.test(email) == false){
            $('.email_alert').text('이메일형식에 맞지않습니다.').css('color','#ff585c').css('font-size','0.75rem');
            $('.email').val("");
            $('.email').focus();
            return false;
        }
        
        if($('.name').val() == ''){
            $('.name_alert').text('이름을 입력하세요').css('color','#ff585c').css('font-size','0.75rem');
            $('.name').focus();
            return false;
        }else{
            clear();
        }
        
        let nameTerms = /^[가-힣]{2,5}$/;
        let name = $('.name').val();
        if(!nameTerms.test(name)){
            $('.name_alert').text('이름을 다시 입력해주세요').css('color','#ff585c').css('font-size','0.75rem');
            $('.name').val("");
            $('.name').focus();
            return false;
        }

        if($('.day').val() == ''){
            $('.day_alert').text('생년월일을 입력하세요').css('color','#ff585c').css('font-size','0.75rem');
            $('.day').focus();
            return false;
        }else{
            clear();
        }

        let dayTerms = /^[0-9]{6}$/;
        let day = $('.day').val();
        if(!dayTerms.test(day)){
            $('.day_alert').text('생년월일을 6자리로 입력해주세요').css('color','#ff585c').css('font-size','0.75rem');
            $('.day').val("");
            $('.day').focus();
            return false;
        }

        if($('#check1').is(":checked") == false){
            alert('필수선택사항에 동의하셔야됩니다.');
            return false;
        }else if($('#check2').is(":checked") == false){
            alert('필수선택사항에 동의하셔야됩니다.');
            return false;
        }

        let con = confirm("가입하시겠습니까?");
        if(con){
            location.replace('login.html')
        }

        function clear(){
            $('.id_alert').text('');
            $('.pw1_alert').text('');
            $('.pw2_alert').text('');
            $('.email_alert').text('');
            $('.name_alert').text('');
            $('.day_alert').text('');
        }
    });

    //취소버튼
    $('.cancle').click(function(){
    let con = confirm('가입을 취소하시겠습니까?');
    if(con){
        $('.form')[0].reset();
    }
    });

    //checkbox
    $('#check').click(function(){
        if($('#check').is(':checked')){
            $('input[type=checkbox]').prop('checked',true);
        }else{
            $('input[type=checkbox]').prop('checked',false);
        }
    });
    $('.each').click(function(){
        let checked = $(this).is(':checked');
        if(!checked){
            $('#check').prop('checked',false);
        }else{
            let eachCheck = true;
            $('.each').each(function(){
                eachCheck = eachCheck && $(this).is(':checked');
            });
            $('#check').prop('checked',eachCheck);
        }
    });

    // 성별
    $('.men').click(function(e){
        e.preventDefault();
        $('.women').addClass('on');
        $(this).addClass('on');
    });
    $('.women').click(function(e){
        e.preventDefault();
        $('.men').removeClass('on');
        $(this).removeClass('on');
    });
});