app_shop.fn.opinionsInit = function(){

    // Najazd i klik na ikonki gwiazdek w formularzu
    $('.opinion_star').on('click', function() {
      var _this = $(this), 
        points = _this.siblings('strong'),
        input = _this.siblings('input');
  
      _this.addClass('active').prevAll('a').addClass('active');
      _this.nextAll('a').removeClass('active');
      points.text(_this.attr('title'));
      input.val(_this.attr('rel'));
  
      if ( $('.opinions_points_picture:not(.d-block)').length ) {
        $('.opinions_points_picture').addClass('d-block');
      }
      return false;
    });
  
    // Klik na wysłanie formularza + walidacja
    $('.shop_opinions_button button').on('click', function() {
        return app_shop.fn.opinionsValidate($('#shop_opinion_form'));
    });
  
    // Czyszczenie inputów z błędów
    $('#shop_opinion_form input[required]').on('blur, input', function() {
        if ($(this).val() != '') {
            $(this).parent().removeClass('has-error').find('.validate_message').remove();
        }
    });
  
    // Formularz jako popup
    $('#show_opinion_form').on('click', function(e) {
      e.stopPropagation();
      Modal({
        element: $('.opinions_add_form'),
        classList: '--add-opinion',
      })
      return false;
    });
  
    // Filtrowanie opinii na stronie
    document.querySelectorAll('.opinion_rate').forEach((el) => {
      el.addEventListener('click', function opinionRateClick(e) {
        e.preventDefault();
        const opinionMoreElement = document.querySelector('.opinions__more');
        if (opinionMoreElement) opinionMoreElement.style.display = 'none';
        const confirmedFilter = document.querySelector('#opinions_filter_confirmed:checked');
        const opinionElements = (confirmedFilter) ? document.querySelectorAll('.opinions_list__item[data-confirmed="true"]') : document.querySelectorAll('.opinions_list__item');
        opinionElements.forEach((element) => {
          if (element.getAttribute('data-opinion_rate') !== this.id && !this.classList.contains('--active')) {
            element.setAttribute('data-hide', true);
          } else {
            element.setAttribute('data-hide', false);
            app_shop?.vars?.bLazy?.revalidate();
          }
        });
        this.classList.toggle('--active');
        document.querySelectorAll(`.opinion_rate:not([id="${this.id}"])`).forEach((element) => {
          element.classList.remove('--active');
        });
        if (app_shop.vars.view > 2) {
          document.getElementById('opinions_section').scrollIntoView({
            behavior: 'smooth',
          });
        }
        if (document.querySelector('.opinions_list__item[data-hide="false"]')) {
          document.getElementById('no_opinions_of_type').classList.add('d-none');
        } else {
          document.getElementById('no_opinions_of_type').classList.remove('d-none');
        }
        return false;
      });
    });
  
    // Klikanie w ocenianie opinii
    $('.rate_opinion a').on('click', function(ev) {
        ev.preventDefault();
        var _this = $(this);
            opinionId = _this.siblings('input[name=opinionId]').val();
            opinionState = _this.find('input[name=opinionState]').val();
    
        $.ajax({
            url: '/ajax/opinions.php?action=rate',
            type: 'POST',
            dataType: 'json',
            data: "id="+opinionId+"&operation="+opinionState,
            success: function postRateOpinion(json) {
                if (json.errors.length) {
                    Alertek.Start(json.errors[0].faultString);
                }
                if (json.result) {
                    _this.parent().find('.opinion_rate_yes .rate_count').text(json.result.score_positive);
                    _this.parent().find('.opinion_rate_no .rate_count').text(json.result.score_negative);
                }
            }
        });
    });
  }
  
  app_shop.run(function() {
    app_shop.fn.opinionsInit();
  }, 'all', '#opinions_section', true);