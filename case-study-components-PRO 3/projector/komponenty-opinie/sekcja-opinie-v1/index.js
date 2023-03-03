app_shop.run(function moreOpinions() {
    $('.opinions__more_txt').on('click', function clickMoreOpinions(e) {
      e.preventDefault();
      $('#opinions_section .opinions_list [data-hide="true"]').attr('data-hide', false);
      app_shop?.vars?.bLazy?.revalidate();
      $('.opinions__more').hide();
      $('.opinions_list').addClass('show');
      return false;
    });
  }, 'all', '.opinions__more', true);
  
  app_shop.run(function moreOpinions() {
    $('#opinions_section .opinions_element_photo a').on('click', function clickPhotoOpinions(e) {
      e.preventDefault();
      e.stopPropagation();
      const $this = $(this);
      const fileLink = $this.attr('href');
      const fileName = $this.find('img').attr('title');
      const tmpImg = new Image();
      tmpImg.src = fileLink;
      tmpImg.onload = function() {
        Modal({
          html: `<div id="ui-dialogimg"><img alt="${fileName}" src="${fileLink}" /></div>`,
        });
      };
      return false;
    });
  }, 'all', '#opinions_section .opinions_element_photo', true);
  
  app_shop.run(function filterConfirmedOpinions() {
    document.getElementById('opinions_filter_confirmed').addEventListener('change', function() {
      const opinionMoreElement = document.querySelector('.opinions__more');
      if (opinionMoreElement) opinionMoreElement.style.display = 'none';
      const rateFilter = document.querySelector('.opinion_rate.--active');
      const opinionElements = (rateFilter) ? document.querySelectorAll(`.opinions_list__item[data-opinion_rate="${rateFilter.id}"]`) : document.querySelectorAll('.opinions_list__item');
      opinionElements.forEach((el) => {
        if (this.checked && el.getAttribute('data-confirmed') === 'false') {
          el.setAttribute('data-hide', true);
          if (app_shop.vars.view > 2) {
            document.getElementById('opinions_section').scrollIntoView({
              behavior: 'smooth',
            });
          }
        } else {
          el.setAttribute('data-hide', false);
          app_shop?.vars?.bLazy?.revalidate();
        }
      });
      if (document.querySelector('.opinions_list__item[data-hide="false"]')) {
        document.getElementById('no_opinions_of_type').classList.add('d-none');
      } else {
        document.getElementById('no_opinions_of_type').classList.remove('d-none');
      }
    });
  }, 'all', '#opinions_filter_confirmed', true);
  
  app_shop.vars.opinions_empty_input = <iai:variable vid="Proszę wypełnić to pole"/> + "."
  app_shop.vars.opinions_not_email = <iai:variable vid="Podano niepoprawny adres email"/> + "."
  
  // Walidacja formularza
  app_shop.fn.validateEmail = function(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(String(email).toLowerCase());
  }
  
  // Walidacja inputów i wyświetlanie/usuwanie błędów
  app_shop.fn.opinionsValidate = function(form) {
    var inputs = form.find('input[required]');
    $.each(inputs, function(index, el) {
      $(el).parent()
        .removeClass('has-error')
        .find('.validate_message').remove();
      if ( !$(el).val() ) {
        $(el).parent()
          .addClass('has-error')
          .append('<span class="help-block validate_message text-danger">'+app_shop.vars.opinions_empty_input+'</span>');;
      }
      else if ($(el).prop('type') === 'email' && !app_shop.fn.validateEmail($(el).val())) {
        $(el).parent()
        .addClass('has-error')
        .append('<span class="help-block validate_message text-danger">'+app_shop.vars.opinions_not_email+'</span>');;
      }
    });
    if ( form.find('.has-error').length ) {
      return false;
    }
    return true;
  }